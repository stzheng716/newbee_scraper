import json
import webbrowser
import openai
from dotenv import dotenv_values
from utils import sample_job_description, insert_GPT_response

config = dotenv_values(".env")
openai.api_key = config["OPEN_AI_API_KEY"]


def request_GPT(jobs):
    """
    input: [{},{}]
    output:[{entry_level: True, job_id: job_id}]
    """

    initial_prompt = """"You are a job filter bot. You will be given a job description. Respond only in JSON. Return the technology needs for the job and the salary of the job as well. Here is an example of what your response should look like:

    {"apply": True, "tech_stack": ['language', 'language', 'framework', 'etc'...], "salary": "$140,000 - $190,000"}

    Determine if the experience required is < 3 years. If it is, return {"apply": True}. If experience is > 4 years, return {"apply": False}. Your response MUST INCLUDE {"apply": True} or {"apply": False} key-object pair.

    """

    for job in jobs:

        # messages = [{"role":  "user", "content": initial_prompt},
        #             {"role":  "user", "content": f"Here is an example of job that should return 'True': {sample_job_description}"},
        #             {"role": "assistant", "content": json.dumps({
        #                 "entry_level": True,
        #                 "tech_stack": ['Python', 'Go', 'Postgres', 'MySQL', 'Redis', 'DynamoDB', 'Docker', 'AWS', 'Kubernetes', 'Kafka', 'Embedded systems'],
        #                 "salary": "$140,000 - $190,000"
        #             })}]

        messages = [{"role":  "system", "content": initial_prompt},
                    {"role": "user", "content": job[6]}]
        try:
            res = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=messages,
                # made token used per request
                max_tokens=1000,
            )
            print("Job Title >> ", job[1])
            print("Job URL >> ", job[2])
            print("Token count >> ", res)
            resp = json.loads(res.choices[0].message.content)
            print("GPT-Response >> ", resp)
            job_url = job[2]
            webbrowser.open_new_tab(job_url)

            breakpoint()
            # insert_GPT_response(resp, job[3])
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
