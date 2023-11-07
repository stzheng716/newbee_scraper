import json
import webbrowser
import openai
from dotenv import dotenv_values
from utils import insert_GPT_response

config = dotenv_values(".env")
openai.api_key = config["OPEN_AI_API_KEY"]


def request_GPT(jobs):
    """
    input: [{},{}]
    output:[{entry_level: True, job_id: job_id}]
    """

    initial_prompt = """You are a job filter bot that evaluates job descriptions to extract and return technology requirements and salary information in a JSON format. Respond with a decision to apply based on the specified criteria and include the identified technology stack and salary information. Your response should follow these guidelines:
    Issue {"apply": True} if the job requires 3 years of experience or less, and there is no explicit degree requirement.
    Issue {"apply": False} if the job requires more than 3 years of experience or explicitly states that a Bachelors, Masters, or PhD degree is necessary.
    List all mentioned technologies in the job description within the 'tech_stack' array without distinguishing between different versions of the technologies.
    Provide the salary information as "salary": None if it is not stated, or return the partial or full salary range as specified in the job description.
    Do not make any assumptions about degree requirements if they are not mentioned in the job description, and ensure the JSON response is correctly formatted."""

    for job in jobs:

        messages = [{"role":  "system", "content": initial_prompt},
                    {"role": "user", "content": job[6]}]
        try:
            res = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=messages,
                # made token used per request
                max_tokens=1000,
            )
            resp = json.loads(res.choices[0].message.content)

            '''Print statements for testing'''
            # job_url = job[2]
            # print("Job Title >> ", job[1])
            # print("Job URL >> ", job[2])
            # print("Token count >> ", res)
            # print("GPT-Response >> ", resp)
            # webbrowser.open_new_tab(job_url)
            # breakpoint()
                # end test prints

            insert_GPT_response(resp, job[3])
            # print("Go Check PG Admin! for job id>>>", job[3])

        except openai.error.AuthenticationError:
            print("The API key is invalid or has insufficient permissions.")
        except openai.error.RateLimitError:
            print("Rate limit exceeded. Please wait before making more requests.")
        except openai.error.OpenAIError as e:
            print(
                f"A network-related error occurred while making the request.{e}")
        except KeyError:
            print("API key not found in the .env file.")
        except ValueError:
            print("The input job descriptions are not in the expected format.")
        breakpoint()
