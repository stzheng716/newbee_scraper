import openai
from dotenv import dotenv_values
import argparse

config = dotenv_values(".env")
openai.api_key = config["OPEN_AI_API_KEY"]

def request_GPT(jobs):

    """
    input: [{},{}]
    """

    initial_prompt = f"You are a job filter bot. You will be given job description and determine if they are entry level jobs"
    messages = [{"role": "system", "content": initial_prompt}]

    for job in jobs:

            res = openai.ChatCompletion.create(
                messages.append(
                    {"role": "user", "job": job}
                    ),
                model="gpt-3.5-turbo",
                messages=messages
            )