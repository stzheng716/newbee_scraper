import json
# import webbrowser
import openai
from dotenv import dotenv_values
from utilities.utils import insert_GPT_response

config = dotenv_values(".env")
openai.api_key = config["OPEN_AI_API_KEY"]
TOKENS = 0
# error log:
ERRORS = {}

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
    initial_prompt = """You are a job filter bot that evaluates job descriptions to extract and return technology requirements and salary information in a JSON format. Respond with a decision to apply based on the specified criteria and include the identified technology stack and salary information. Your response should follow these guidelines:
    Issue {"apply": "True"} if the job requires 3 years of experience or less, and there is no explicit degree requirement.
    Issue {"apply": "False"} if the job requires more than 3 years of experience or explicitly states that a Bachelors, Masters, or PhD degree is necessary.
    List all mentioned technologies in the job description within the 'tech_stack' array without distinguishing between different versions of the technologies.
    Provide the salary information as {"salary": "None"} if it is not stated, or return the partial or full salary range as specified in the job description.
    Do not make any assumptions about degree requirements if they are not mentioned in the job description. Return only JSON. 
    Here is an example of what the data produced could look like:
    {"apply": "true", "tech_stack": ['language', 'language', 'framework', ...], "salary": "$140,000 - $190,000"}
    """

    for job in jobs:

        messages = [{"role":  "system", "content": initial_prompt},
                    {"role": "user", "content": job[6]}]
        try:
            res = openai.ChatCompletion.create(
                model="gpt-3.5-turbo-1106",
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
            global TOKENS;
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

            insert_GPT_response(resp, job[3])
            # print("Go Check PG Admin! for job id>>>", job[3])

        except openai.error.AuthenticationError as e:
            print("The API key is invalid or has insufficient permissions.")            
            global ERRORS;
            ERRORS.append({"job_URL": job[2], "error":e})
            print (ERRORS)
        except openai.error.RateLimitError as e:
            print("Rate limit exceeded. Please wait before making more requests.")            
            global ERRORS;
            ERRORS.append({"job_URL": job[2], "error":e})
            print (ERRORS)
        except openai.error.OpenAIError as e:
            print(
                f"A network-related error occurred while making the request.{e}")            
            global ERRORS;
            ERRORS.append({"job_URL": job[2], "error":e})
            print (ERRORS)
        except KeyError as e:
            print("API key not found in the .env file.")            
            global ERRORS;
            ERRORS.append({"job_URL": job[2], "error":e})
            print (ERRORS)
        except ValueError as e:
            '''this is the most common error'''
            print("The input job descriptions are not in the expected format.")
            print(e)
            global ERRORS;
            ERRORS.append({"job_URL": job[2], "error":e})
            print (ERRORS)
    print("Total Token Count >>> ", TOKENS)
    print("ERRORS >>> ", ERRORS)
