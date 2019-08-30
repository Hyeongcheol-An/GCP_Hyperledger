import os
import shutil
from flask import Flask, request, render_template
app = Flask (__name__)

channeldir = "/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/autorun/flask/case4/channel-artifacts"
cryptodir = "/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/autorun/flask/case4/crypto-config"

vm_21_ip = "35.232.221.188"
count = 0

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/docker', methods=['GET'])
def docker():
    global count
    count += 1
    os.chdir("/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4/")
    os.system("./up.sh")

    return str(count)

@app.route('/upload')
def upload():
    return render_template('upload.html')


@app.route('/cryptogen', methods=['GET', 'POST'])
def cryptogen():
    os.chdir("/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4/")


    return str(count)

# flask.request.files.getlist("file[]")


@app.route('/channel', methods=['GET'])
def channel():
    return '2'


# def cryptogen():
#     os.chdir("/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/autorun/flask/case4/")
#     os.system('./run.sh')


# def trans_file():
#     os.chdir("/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/autorun/flask/case4/channel-artifacts")
#     return "10"


 
if __name__ == "__main__":
    # cryptogen()

    # files = os.listdir("../flask")
    # print(files)
    # os.system('ls')


    app.run(host="0.0.0.0", port=8080)
