#! /usr/bin/env python

fd = open("/home/kniepbert/KniepBert.log","w")
deb = open("/home/kniepbert/KniepBert.deb","w")
def log(msg):
    fd.write(msg+'\n')
def send(msg):
    deb.write(msg+'\n')
    print msg+'\n'


# Init
print 'RobotOption 3 0'
print 'RobotOption 1 1\n'
print 'Name kniepbert'
print 'Colour ffaaaa aaffff\n'
rotWin = 0.7
import time,random

inp = raw_input('')
while True:
    msg=inp.split()
    if len(msg)<2: pass
    elif msg[0]=='Initialize' and msg[1]=='1':
        pass
    elif msg[0]=='Dead' or msg[0]=='GameFinished':
        log('Ende')
        break
    elif msg[0]=='Radar':
        if msg[2]=='2': # Should be the Wall
            pass
        else:
            log(inp)
    elif msg[0]=='RobotInfo' and msg[2]=='0':
        send('Colour bbaaaa bbeeff')
        send('Shoot 10')
    else:
        print 'Accelerate 0.5\n'
        rotWin = rotWin*(-1)
        print 'Rotate 7 %s\n' % rotWin
    inp=raw_input('')

fd.close()