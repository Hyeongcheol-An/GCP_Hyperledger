import socketserver
import threading
 
HOST = ''
PORT = 9009
lock = threading.Lock()
 
class UserManager:
 
   def __init__(self):
      self.users = {}
 
   def addUser(self, username, conn, addr):
      if username in self.users:
         conn.send('이미 등록된 사용자입니다.\n'.encode())
         return None
 
      lock.acquire()
      self.users[username] = (conn, addr)
      lock.release()
 
      self.sendMessageToAll('[%s]님이 입장했습니다.' %username)
      print('+++ 대화 참여자 수 [%d]' %len(self.users))
         
      return username
 
   def removeUser(self, username):
      if username not in self.users:
         return
 
      lock.acquire()
      del self.users[username]
      lock.release()
 
      self.sendMessageToAll('[%s]님이 퇴장했습니다.' %username)
      print('--- 대화 참여자 수 [%d]' %len(self.users))
 
   def messageHandler(self, username, msg): # 전송한 msg를 처리하는 부분
      if msg[0] != '/': # 보낸 메세지의 첫문자가 '/'가 아니면
         self.sendMessageToAll('[%s] %s' %(username, msg))
         return
 
      if msg.strip() == '/quit': # 보낸 메세지가 'quit'이면
         self.removeUser(username)
         return -1
 
   def sendMessageToAll(self, msg):
      for conn, addr in self.users.values():
         conn.send(msg.encode())
           
 
class MyTcpHandler(socketserver.BaseRequestHandler):
   userman = UserManager()
     
   def handle(self): # 클라이언트가 접속시 클라이언트 주소 출력
      print('[%s] 연결됨' %self.client_address[0])
 
      try:
         username = self.registerUsername()
         msg = self.request.recv(1024)
         while msg:
            print(msg.decode())
            if self.userman.messageHandler(username, msg.decode()) == -1:
               self.request.close()
               break
            msg = self.request.recv(1024)
                 
      except Exception as e:
         print(e)
 
      print('[%s] 접속종료' %self.client_address[0])
      self.userman.removeUser(username)
 
   def registerUsername(self):
      while True:
         self.request.send('로그인ID:'.encode())
         username = self.request.recv(1024)
         username = username.decode().strip()
         if self.userman.addUser(username, self.request, self.client_address):
            return username
 
class ChatingServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass
         
def runServer():
   print('+++ 채팅 서버를 시작합니다.')
   print('+++ 채텅 서버를 끝내려면 Ctrl-C를 누르세요.')
 
   try:
      server = ChatingServer((HOST, PORT), MyTcpHandler)
      server.serve_forever()
   except KeyboardInterrupt:
      print('--- 채팅 서버를 종료합니다.')
      server.shutdown()
      server.server_close()
 
runServer()
