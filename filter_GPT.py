import json
import openai
from dotenv import dotenv_values
import argparse
from utils import sample_job_description, insert_GPT_response

config = dotenv_values(".env")
openai.api_key = config["OPEN_AI_API_KEY"]


def request_GPT(jobs):
    """
    input: [{},{}]
    output:[{entry_level: True, job_id: job_id}]
    """

    initial_prompt = """"You are a job filter bot. You will be given job description and return a true or false that requires less than 4 year of experiences needed or a full stack web development bootcamp graduate would apply to.  Return the technology needs for the job and the salary of the job as well. Respond only in JSON"
    """

    for job in jobs:

        messages = [{"role":  "user", "content": initial_prompt},
                    {"role":  "user", "content": f"Here is an example of job that should return 'True': {sample_job_description}"},
                    {"role": "assistant", "content": json.dumps({
                        "entry_level": True,
                        "tech_stack": ['Python', 'Go', 'Postgres', 'MySQL', 'Redis', 'DynamoDB', 'Docker', 'AWS', 'Kubernetes', 'Kafka', 'Embedded systems'],
                        "salary": "$140,000 - $190,000"
                    })}]

        try:
            res = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=messages,
                # made token used per request
                max_tokens=1000,
            )
            print(job[1])
            print(res)
            resp = json.loads(res.choices[0].message.content)
            print(resp)
            
            breakpoint()
            insert_GPT_response(resp, job[3])
            print("Go Check PG Admin! for job id>>>", job[3])

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
