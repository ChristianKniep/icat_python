#! /usr/bin/env python

import time,random,sys,os
import Queue


def log(msg):
    fd.write(msg+'\n')
def send(msg):
    deb.write(msg+'\n')
    print msg+'\n'


def err(msg):
    sys.stderr.write(msg)

class MyRobot(object):
    def __init__(self):
        print 'RobotOption 3 0'
        print 'RobotOption 1 1'
        print 'Name kniepbert'
        print 'Colour ffaaaa aaffff'
        
        # create the pipe
        self.receive, self.transmit = os.pipe()
        # dispatchLogic
        self.dL = dispatchLogic()
        
    def eval(self):
        child_pid = os.fork()
        if child_pid == 0:
            x = raw_input('')
            while x!='EOF':
                length = os.write(self.transmit, ';; %s' % x)
                x = raw_input('')
        else:
            print "Parent Process: PID# %s" % os.getpid()
            count=0
            while True:
                count = count + 1
                line = os.read(self.receive, 128)
                m = line.split(';;')
                self.dL.eval(m) 

class dispatchLogic(object):
    def __init__(self):
        self.time   = 0
        self.x      = 0
        self.y      = 0
        self.speed  = 0
        self.cAngle = 0
        self.rAngle = 0
        self.power  = 0
    def eval(self,item):
        m = item.split()
        if m[0]=='Info':
            self.time   = m[1]
            self.speed  = m[2]
            self.cAngle = m[3]
        elif m[0]=='Coordinates':
            self.x      = m[1]
            self.y      = m[2]
            self.rAngle = m[3]
        elif m[0]=='Energy':
            self.power  = m[1]
        elif m[0]=='Radar':
            pass
        elif m[0]=='Initialize':
            err('Init')
        
    
robo = MyRobot()
robo.eval()