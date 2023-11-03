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

    initial_prompt = f"You are a job filter bot. You will be given job description and determine if they are entry level jobs"
    messages = [{"role": "system", "content": initial_prompt}]

    for job in jobs:
        try:
            res = openai.ChatCompletion.create(
                messages.append(
                    {"role": "user", "job": job.job_description}
                    ),
                model="gpt-3.5-turbo",
                messages=messages,
                # made token used per request
                max_tokens=1000,
            )
            print(res.choices[0].message.content)
            breakpoint()

        except openai.error.AuthenticationError:
            print("The API key is invalid or has insufficient permissions.")
        except openai.error.RateLimitError:
            print("Rate limit exceeded. Please wait before making more requests.")
        except openai.error.OpenAIError:
            print("A network-related error occurred while making the request.")
        except KeyError:
            print("API key not found in the .env file.")
        except ValueError:
            print("The input job descriptions are not in the expected format.")