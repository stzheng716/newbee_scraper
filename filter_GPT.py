import openai
from dotenv import dotenv_values
import argparse

config = dotenv_values(".env")
openai.api_key = config["OPEN_AI_API_KEY"]

def request_GPT(jobs):

    """
    input: [{},{}]
    output:[{entry_level: True, job_id: job_id}]
    """

    initial_prompt = """
    You are a job filter bot. You will be given job 
    description and return a true or false if it is entry level. 
    Entry level meaning less than 3 year of experiences needed. 
    Return the technology needs for the job. Here is an example:
    {
        entry_level: true,
        tech_stack: [React, Typescript, Javascript]
    } 
    """

    for job in jobs:

        messages = [{"role": "system", "content": initial_prompt},
                    {"role": "user", "content": job[6]}]

        try:
            res = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=messages,
                # made token used per request
                max_tokens=1000,
            )
            print(job[1])
            print(res)
            print(res.choices[0].message.content)
            breakpoint()

        except openai.error.AuthenticationError:
            print("The API key is invalid or has insufficient permissions.")
        except openai.error.RateLimitError:
            print("Rate limit exceeded. Please wait before making more requests.")
        except openai.error.OpenAIError as e:
            print(f"A network-related error occurred while making the request.{e}")
        except KeyError:
            print("API key not found in the .env file.")
        except ValueError:
            print("The input job descriptions are not in the expected format.")
        breakpoint()