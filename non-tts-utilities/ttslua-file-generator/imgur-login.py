import sys
import webbrowser

# Setup your application: https://api.imgur.com/oauth2/addclient
# Call this application like this: python3 imgur-login.py <client-id>
# Accept and paste the access token from the url into the commandline

if len(sys.argv) < 2:
    print("No client-id provided")
    exit(1)

url = "https://api.imgur.com/oauth2/authorize?response_type=token&client_id=" + sys.argv[1]
webbrowser.open(url, new=2)

access_token = input("Enter Access_Token from the url: ")

with open("secrets", "w") as f:
    f.write(access_token)
