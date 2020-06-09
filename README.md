# Setup Kong + Konga using Docker compose

This is a fork of the repo [here](https://github.com/vousmeevoyez/kong-konga-example) with a customised start script that will save anyone reading the article [here](https://dev.to/vousmeevoyez/setup-kong-konga-part-2-dan) lots of time trying to figure out what the hell is going on, or anyone attempting to run the start script in the original repo a ton of time trying to figure out why everything is broken, i.e. past me.

## Instructions

1. Run the `start.sh` script  

2. Copy the `id` value in the json retrieved from the last `curl` command (the json response will be printed to your terminal)

3. Run this (including the id you just copied in place of the placeholder):
`curl --location --request POST 'http://localhost:8001/consumers/{the_id_you_just_copied}/key-auth'`

4. You will have received an api key in the last call. Copy it. You'll need it for step 7.

5. Open your browser, navigate to `localhost:9000` to open konga. 

6. Set up an admin user and log in. 

7. Set up a KEY AUTH connection to kong like you see in `setup.png` (details below). Use the api key you got in step 3.

```
Name: admin-api
Loopback API URL: http://kong:8000/admin-api
API KEY: ${the_api_key_you_copied}
```

**If you experience some trouble, try increasing the sleep time in line 41 of `start.sh`.