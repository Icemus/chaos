#!/usr/bin/env python3

import smtplib
import configparser
import argparse

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders

parser = argparse.ArgumentParser(description='Use SMTP to Send Mail')
parser.add_argument('-c', '--config', default='autoMail.ini', type=str,
                    help='File, Config File To Define Server/Sender/Recipient ')
parser.add_argument('-s', '--subject', default='', type=str,
                    help='String, Mail Subject Text')	
parser.add_argument('-m', '--message', default='', type=str,
                    help='File, Mail Message File')	
parser.add_argument('-a', '--attachment', default='', type=str,
                    help='File, Mail Attachment File')													
arg = parser.parse_args()

cfg = configparser.ConfigParser()
cfg.read(arg.config)

smtpserver = cfg.get('smtp','server')
smtpport = cfg.get('smtp','port')
fromaddr = cfg.get('sender','user')
passwd = cfg.get('sender','password')
toaddr = cfg.get('recipient','to').split(',')
cc= cfg.get('recipient','cc').split(',')
bcc= cfg.get('recipient','bcc').split(',')

'''
    Message
'''
msg = MIMEMultipart()

if arg.subject != '' :
    msg['Subject']  = arg.subject

if arg.message != '' :
    description = open(arg.message,"r")
    body = "".join(description.readlines())
    msg.attach(MIMEText(body,'plain'))
    description.close()

'''
    Add Attachment.
'''
if arg.attachment != '' :
    attach = open(arg.attachment,"rb")
    part = MIMEBase('application','octet-stream')
    part.set_payload((attach).read())
    encoders.encode_base64(part)
    part.add_header('Content-Disposition',"attachment; filename= %s" % arg.attachment.split("/")[-1])
    msg.attach(part)
    attach.close()
    
'''
    Send Mail
'''
text=msg.as_string()

server = smtplib.SMTP(smtpserver,smtpport)
server.starttls()
server.login(fromaddr,passwd)
server.sendmail(fromaddr,toaddr+cc+bcc,text)
server.quit()

