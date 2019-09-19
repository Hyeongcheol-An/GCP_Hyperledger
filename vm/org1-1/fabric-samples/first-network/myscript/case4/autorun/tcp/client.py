import socket 
import threading 

HOST = "34.66.226.174" 
PORT = 8000 

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
s.connect((HOST, PORT)) 

def sendingMsg(): 
    while True: 
        try:
            data = s.recv(1024)
            if not data:
                break
            print(data.decode('utf-8'))
        except:
            pass

def gettingMsg(): 
    while True: 
        data = input()
        data = data.encode('utf-8')    
        s.send(data)

        if data == '/logout':
            break

    s.close()

threading._start_new_thread(gettingMsg,()) 
threading._start_new_thread(sendingMsg,())

while True:
    pass
