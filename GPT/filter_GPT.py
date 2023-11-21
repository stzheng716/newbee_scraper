import json
# import webbrowser
import openai
from dotenv import dotenv_values
from database_utils.bulk_insert import bulk_insert_GPT_response
from utilities.utils import select_US_roles_entry

config = dotenv_values(".env")
openai.api_key = config["OPEN_AI_API_KEY"]
TOKENS = 0
# error log:
ERRORS = []

def request_GPT(jobs):
    """
    input: [{},{}]
    output:[{entry_level: True, job_id: job_id}]

    Sends job description to OpenAI API and returns JSON object.
    Errors are handled by skipping the job - most errors come from GPT 
    being a silly goose and returning a paragraph instead of JSON.

    That said - there's some string-fu happening to clean the GPT responses up before converting them to Python dicts. 
    """
    # TODO: Consider adding "Step 1", "Step 2", "Step 3", etc to the prompt.  
    initial_prompt = """You are a job filter bot that evaluates job descriptions. You will extract and return technology stack used and salary as a JSON object. Assess if the job would be appropriate for a full stack developer with 0-3 years of experience, inclusive. Your response should follow these guidelines: return {\"apply\": \"True\"} if the job requires 3 years of experience or less, and there is no explicit degree requirement. If it requires the applicant is currently pursuing a degree the application is disqualified. Do not make any assumptions about degree requirements if they are not mentioned in the job description. Issue {\"apply\": \"False\"} if the job requires more than 3 years of experience or explicitly states that a Bachelors, Masters, or PhD degree is necessary. List all mentioned technologies in the job description within the \"tech_stack\" array without distinguishing between different versions of the technologies. Provide the salary information as {\"salary\": \"See application for details.\"} if it is not stated, or return the partial or full salary range as specified in the job description as a string: \"salary\": \"$int - $int\".  Return an <80 word summary of the job description and a \"reasoning\" of why the job is applicable or not. Return as JSON}"""
    count = 0
    work_slice = jobs[count : count + 25]

    def ask_the_robot(jobs_slice, count):
        GPT_blessings = []
        print("length slice =", len(jobs_slice))
        display_count = 0
        for job in jobs_slice:

            messages = [{"role":  "system", "content": initial_prompt},
                        {"role": "user", "content": job[6]}]
            try:
                res = openai.ChatCompletion.create(
                    model="ft:gpt-3.5-turbo-1106:personal::8M0ktJe9",
                    response_format={ "type": "json_object" },
                    messages=messages,
                    temperature=0.5,
                    # made token used per request
                    max_tokens=1000,
                )

                resp_raw = res.choices[0].message.content
                
                #clean up response string
                resp_cleaned = resp_raw.replace("\n", "").replace("'''", "").replace("```", "").replace("json", "").replace("JSON", "").replace("  ", "")

                resp = json.loads(resp_cleaned)

                # Count the tokens, why not? 
                tokens = res.usage.total_tokens
                global TOKENS
                TOKENS += tokens

                '''Print statements for testing'''
                # job_url = job[2]
                # webbrowser.open_new_tab(job_url)
                # print("Job Title >> ", job[1])
                # print("Job URL >> ", job[2])
                # print("Token count >> ", res.usage.total_tokens)
                # print("GPT-Response >> ", resp)
                # breakpoint()
                # print(TOKENS)
                    # end test prints
                GPT_blessings.append((json.dumps(resp), job[3]))
                display_count += 1
                print (display_count)
                if len(GPT_blessings) >= 20:
                    break
                # bulk_insert_GPT_response(json.dumps(resp), job[3])
                # print("Go Check PG Admin! for job id>>>", job[3])

            except openai.error.AuthenticationError as e:
                print("The API key is invalid or has insufficient permissions.")            
                ERRORS.append({"job_URL": job[2], "error":e})
                print (ERRORS)
            except openai.error.RateLimitError as e:
                print("Rate limit exceeded. Please wait before making more requests.")            
                ERRORS.append({"job_URL": job[2], "error":e})
                print (ERRORS)
            except openai.error.OpenAIError as e:
                print(
                    f"A network-related error occurred while making the request.{e}")            
                ERRORS.append({"job_URL": job[2], "error":e})
                print (ERRORS)
            except KeyError as e:
                print("API key not found in the .env file.")            
                ERRORS.append({"job_URL": job[2], "error":e})
                print (ERRORS)
            except ValueError as e:
                '''this is the most common error'''
                print("The input job descriptions are not in the expected format.")
                print(e)
                ERRORS.append({"job_URL": job[2], "error":e})
                print (ERRORS)

        print("responses list >>", GPT_blessings)
        print("Total Token Count >>> ", TOKENS)
        print("ERRORS >>> ", ERRORS)
        bulk_insert_GPT_response(GPT_blessings)
        count += 20
        global work_slice
        work_slice = jobs[count : count + 20]
        print("count =", count, "  len(jobs) =", len(jobs))
    
        if count < len(jobs):
            ask_the_robot(work_slice, count)
    ask_the_robot(work_slice, count)
        
jobs = select_US_roles_entry()

request_GPT(jobs)