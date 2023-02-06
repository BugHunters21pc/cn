DONE WITH TCP

SOCKET PROGRAMMING TCP :

PROB 1:

CLIENT :

import socket
cs=socket.socket()
cs.connect(('localhost',9999))


print('Connected to server')
while True:
    
    msg1 = input("Please enter the message to the server : ")
    cs.send(msg1.encode())
    msg = cs.recv(1024)
    msg = msg.decode()
    print("Server replied:", msg,end="")
    if msg=="Goodbye":
        break
cs.close()

SERVER :

import socket
s=socket.socket()#Creates a new Socket
s.bind(("localhost",9999))
print("Server Is Listening")
s.listen(3)
c,addr = s.accept()
while True:
    
    rep=c.recv(1024)
    msgc=rep.decode()
    print("Client: ",msgc)
    if msgc=="Bye":
        msg="Goodbye"
        msg=msg.encode()
        c.send(msg)
        break
    else:
        msg="OK"
        msg=msg.encode()
        c.send(msg)
        
  
c.close()

PROB 2:

C:

import socket
cs=socket.socket()
cs.connect(('localhost',9999))


print('Connected to server')
while True:
    
    msg1 = input("Please enter the message to the server : ")
    cs.send(msg1.encode())
    msg = cs.recv(1024)
    msg = msg.decode()
    print("Server replied:", msg,end="")
    if msg=="Goodbye":
        break
cs.close()

S:

import socket
s=socket.socket()#Creates a new Socket
s.bind(("localhost",9999))
print("Server Is Listening")
s.listen(3)
c,addr = s.accept()
while True:
    
    rep=c.recv(1024)
    msgc=rep.decode()
    print("Client: ",msgc)
    if msgc=="Bye":
        msg="Goodbye"
        msg=msg.encode()
        c.send(msg)
        break
    else:
        msg=msgc[::-1]
        print('sending to client ',msg)
        msg=msg.encode()
        c.send(msg)
        
  
c.close()

PROB 3:

C:

import socket
cs=socket.socket()
cs.connect(('localhost',9999))


print('Connected to server')
while True: 
    msg1 = input("Please enter the message to the server : ")
    cs.send(msg1.encode())
    msg = cs.recv(1024)
    msg = msg.decode()
    print("Server replied:", msg,end="")
    check=input("Do you want to continue (y/n):")
    if (check=="n"):
        break
cs.close()

S:

import socket
s=socket.socket()#Creates a new Socket
s.bind(("localhost",9999))
print("Server Is Listening")
s.listen(3)
c,addr = s.accept()
while True:
    rep=c.recv(1024)
    #print(rep)
    if rep.decode()=='':
        break
    msgc=rep.decode()
    print("Client: ",msgc)
    msg=msgc.encode()
    c.send(msg)
c.close()

PROB 4:
C:

import socket
cs=socket.socket()
cs.connect(('localhost',9999))


print('Connected to server')
while True: 
    msg1 = input("Please enter the message to the server : ")
    cs.send(msg1.encode())
    msg = cs.recv(1024)
    msg = msg.decode()
    print("Server replied:", msg,end="")
    check=input("Do you want to continue (y/n):")
    if (check=="n"):
        break
cs.close()

S:

import socket
s=socket.socket()#Creates a new Socket
s.bind(("localhost",9999))
print("Server Is Listening")
s.listen(3)
c,addr = s.accept()
while True:
    rep=c.recv(1024)
    #print(rep)
    if rep.decode()=='':
        break
    msgc=rep.decode()
    print("Client: ",msgc)
    msg=''
    for i in msgc:
        msg+=format(ord(i), '08b')+" "
        
    c.send(msg.encode())
c.close()

PROB 5:
C:

import socket
s=socket.socket()#Creates a new Socket
s.connect(("localhost",9999))
rep=s.recv(1024)
msgc=rep.decode()
print('the time got from the server',msgc)
  
s.close()

S:

from datetime import datetime
import socket
s=socket.socket()#Creates a new Socket
s.bind(("localhost",9999))
print("Server Is Listening")
s.listen(3)
c,addr = s.accept()
print('Got a connection from ',addr)
d=str(datetime.now())
c.send(d.encode()) 
c.close()

SOCKET PROG UDP WORKSHEET :

PROB 1:

C1 :

import socket
c=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
serverAddr=('localhost',9999)
opt='y'
while opt=='y' or opt=='Y':
    msg=input("Enter the filename: ")
    c.sendto(bytes(msg,"utf-8"),serverAddr)
    Servermsg=c.recvfrom(1024)
    with open('newfile.txt','w') as f:
        f.write(Servermsg[0].decode())
    op=input("Do you want to continue: ")
    opt=op
    
S1:

import os
import socket,sys
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.bind(('localhost',9999))
print("Server waiting")
while True:
    cData=s.recvfrom(1024)
    msg = cData[0]
    cIp = cData[1]
    print("Server is connected with : ",cIp)
    if os.path.exists(msg):
        f=open(msg,'r')
        s.sendto((f.read()).encode(),cIp)
    else:
        sys.exit()
        
    
s.close

PROB 2:

C2:

import socket
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
a=input('Enter Userid: ')
s.sendto(a.encode(),('localhost',9999))
d=s.recvfrom(1024)
if d[0].decode()=="exist":
    print('1.display')
    print('2.credit')
    print('3.debit')
    choice=input()
    if choice=='1':
        s.sendto('1'.encode(),('localhost',9999))
        msg=s.recvfrom(1024)
        print((msg[0]).decode())
    else:
        choice2=input('Enter the amount:')
        if choice=='2':
            s.sendto(('2'+choice2).encode(),('localhost',9999))
        else:
            s.sendto(('3'+choice2).encode(),('localhost',9999))
                       
else:
    s.sendto(('new').encode(),('localhost',9999))
    choinen=input('Account doesnt exist would you like to create?(y/n)')
    name=input('Enter name:')
    s.sendto((name).encode(),('localhost',9999))
    
S2:

import socket,csv,os
with socket.socket(socket.AF_INET,socket.SOCK_DGRAM) as s:
    s.bind(('localhost',9999))
    print('...yourBank...')
    file=open('yourBank.csv','a+')
    file.seek(0)
    csvreader =csv.reader(file)
    c=s.recvfrom(1024)
    exist=False
    #print(csvreader)
    for row in csvreader:
        #print(row)
        if row[0]==(c[0].decode()):
            exist=True
    if exist:
        s.sendto(bytes('exist','UTF-8'),c[1])
    else:
        s.sendto(bytes('doesnt exist','UTF-8'),c[1])
    new=s.recvfrom(1024)
    #print(new)
    if new[0].decode()=='1':
        file.seek(0)
        csvreader2 =csv.reader(file)
        #print('w')
        for row in csvreader2:
            #print(row)
            if row[0]==(c[0].decode()):
                #print(row)
                r=''.join(i+' ' for i in row)
                s.sendto(r.encode(),c[1])
    elif (new[0].decode())[0]=='2':
        file2=open('new.csv','w')
        file.seek(0)
        for i in file.readlines():
            #print(i[0]==(c[0].decode()))
            if i[0]==(c[0].decode()):
                s=i.split(',')
                #print(s)
                #print(str(int(s[2])+int((new[0].decode())[1:])))
                s[2]=str(int(s[2])+int((new[0].decode())[1:]))
                file2.write((''.join(j+',' for j in s))[:-1])
                file2.write('\n')

            else:
                file2.write(i)
        file.close()
        file2.close()  
        os.remove('yourBank.csv')
        os.rename('new.csv','yourBank.csv')
    elif (new[0].decode())[0]=='3':
        file2=open('new.csv','w')
        file.seek(0)
        for i in file.readlines():
            #print(i[0]==(c[0].decode()))
            if i[0]==(c[0].decode()):
                s=i.split(',')
                #print(s)
                #print(str(int(s[2])+int((new[0].decode())[1:])))
                if(int(s[2])<=int((new[0].decode())[1:])):
                    print('Insufficient balance')
                    file2.write(i)
                else:
                    s[2]=str(int(s[2])-int((new[0].decode())[1:]))
                    file2.write((''.join(j+',' for j in s))[:-1]) 
                    file2.write('\n')
            else:
                file2.write(i)
        file.close()
        file2.close()  
        os.remove('yourBank.csv')
        os.rename('new.csv','yourBank.csv')
    else:
        c=s.recvfrom(1024)[0].decode()
        file.seek(0)
    
        a=file.readlines()[-1][0]
      
        no=int(a[0])+1
        file.write('\n'+str(no)+','+c+',0')
        file.close()

PROB 3:

C3:

import socket,pickle
c=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
serverAddr=('localhost',9999)
msg=input("Enter the Dictname: ")
c.sendto(bytes(msg,"utf-8"),serverAddr)
Servermsg=c.recvfrom(1024)
print("Message from Server: \n",pickle.loads(Servermsg[0]))

S3:

import os
import socket,sys,pickle
myDic={'name':'preetham','age':'18'}
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.bind(('localhost',9999))
print("Server waiting")
cData=s.recvfrom(1024)
cIp = cData[1]

s.sendto(pickle.dumps(myDic),cIp)    
s.close()
