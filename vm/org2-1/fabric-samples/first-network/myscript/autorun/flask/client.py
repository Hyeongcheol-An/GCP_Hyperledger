# Flask Client

import urllib.request

def request(url):
    response = urllib.request.urlopen(url)
    byte_data = response.read()
    text_data = byte_data.decode('utf-8')
    return text_data

if __name__ == "__main__":
    print(request("http://34.66.226.174:8080/docker"))
    print(request("http://34.66.226.174:8080/channel"))
    