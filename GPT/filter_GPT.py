import json
# import webbrowser
import openai
from dotenv import dotenv_values
from utilities.db_bulk_data_utils import bulk_insert_GPT_response
from utilities.db_utils import query_unblessed_US_jobs

config = dotenv_values(".env")
openai.api_key = config["OPEN_AI_API_KEY"]
# error log:

def handle_error(job, e, errors):
    error_type = type(e).__name__
    print(f"Encountered {error_type}: {e}")
    error_info = {"job_URL": job[2], "error": f"{error_type}: {e}"}
    errors.append(error_info)

def request_GPT(jobs):
    """
    input: [{},{}]
    output:[{entry_level: True, job_id: job_id}]

    Sends job description to OpenAI API and returns JSON object.
    Errors are handled by skipping the job - most errors come from GPT 
    being a silly goose and returning a paragraph instead of JSON.

    That said - there's some string-fu happening to clean the GPT responses up before converting them to Python dicts. 
    """
    initial_prompt = """You are a job filter bot that evaluates job descriptions. 
    Step 1) Assess if the job would be appropriate for a full stack developer with 0-3 years of experience, inclusive. Your response should follow these guidelines: return {\"apply\": \"True\"} if the job requires 3 years of experience or less, and there is no explicit degree requirement. If it requires the applicant is currently pursuing a degree the application is disqualified. Do not make any assumptions about degree requirements if they are not mentioned in the job description. Issue {\"apply\": \"False\"} if the job requires more than 3 years of experience or explicitly states that a Bachelors, Masters, or PhD degree is necessary. 
    Step 2) List all mentioned technologies in the job description within the \"tech_stack\" array without distinguishing between different versions of the technologies. If there is no tech_stack, return ['no technologies mentioned']
    Step 3) Provide the salary information. Seek out variable "date_variable" as month, year, week, or hour depending on the provided data. Return as {\"salary\": \"See application for details.\"} if it is not stated, or return the partial or full salary range as specified in the job description as a string: \"salary\": \"$int - $int /\"date_variable\"\".  
    Step 4) Return an <80 word summary of the job description.
    Step 5) Return a \"reasoning\" of why the job is applicable or not. 
    Step 6) Return as JSON}"""
    count = 0
    work_slice = jobs[count : count + 20]
    errors = []

    def ask_the_robot(jobs_slice, count, errors):
        GPT_blessings = []
        print("length slice =", len(jobs_slice))
        display_count = 0
        for job in jobs_slice:

            messages = [{"role":  "system", "content": initial_prompt},
                        {"role": "user", "content": job[6]}]
            try:
                res = openai.ChatCompletion.create(
                    model="ft:gpt-3.5-turbo-1106:personal::8M0ktJe9",
                    # model="gpt-3.5-turbo-1106",
                    response_format={ "type": "json_object" },
                    messages=messages,
                    temperature=0.5,
                    max_tokens=1000,
                )

                resp_raw = res.choices[0].message.content
                
                #GPT's responses can be inconsistent. This guards against that
                resp_cleaned = resp_raw.replace("\n", "").replace("'''", "").replace("```", "").replace("json", "").replace("JSON", "").replace("  ", "")
                
                resp = json.loads(resp_cleaned)
                GPT_blessings.append((json.dumps(resp), job[3]))
                display_count += 1
                print (display_count)
                if len(GPT_blessings) >= 20:
                    break

            except Exception as e:
                handle_error(job, e, errors)
                
        bulk_insert_GPT_response(GPT_blessings)
        count += 20
        global work_slice
        work_slice = jobs[count : count + 20]
        print("count =", count, "  len(jobs) =", len(jobs))
    
        if count < len(jobs):
            ask_the_robot(work_slice, count, errors)
    ask_the_robot(work_slice, count, errors)
        
jobs = query_unblessed_US_jobs()

# request_GPT(jobs)

