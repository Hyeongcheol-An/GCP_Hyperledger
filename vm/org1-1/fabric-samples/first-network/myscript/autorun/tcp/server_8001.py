import socket 
import threading 

HOST = '' 
PORT = 8001

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
s.bind((HOST, PORT)) 
s.listen(1) 
conn, addr = s.accept() 

print('Connected by', addr[0])
data = "Connect by Server"
conn.send(data.encode('utf-8'))

def sendingMsg(): 
    while True: 
        data = input() 
        data = '[server] : ' + data
        data = data.encode("utf-8") 
        conn.send(data) 
    conn.close() 
        
def gettingMsg(): 
    while True: 
        data = conn.recv(1024) 

        if not data: 
            break
        else: 
            data = data.decode("utf-8", "ignore")
            print('[client] : ' + data) 
    conn.close() 
            
threading._start_new_thread(sendingMsg,()) 
threading._start_new_thread(gettingMsg,()) 
            
            
while True:
    pass

