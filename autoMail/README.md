
#   基于Python3的简易电子邮件发送程序

##  1.配置邮件服务器、发件人、收件人信息

    -修改autoMail.ini文件中Mail Server，Sender，Recipient信息；

    -或者复制autoMail.ini生成新的配置文件，并修改上述信息。

##  2.使用autoMail.py发送电子邮件

    -默认使用autoMail.ini中配置信息；

    -如使用自定义配置文件，需使用参数-c或--config指定配置文件。

### 帮助信息如下：

```
usage: autoMail.py [-h] [-c CONFIG] [-s SUBJECT] [-m MESSAGE] [-a ATTACHMENT]

Use SMTP to Send Mail

optional arguments:
  -h, --help            show this help message and exit
  -c CONFIG, --config CONFIG
                        File, Config File To Define Server/Sender/Recipient
  -s SUBJECT, --subject SUBJECT
                        String, Mail Subject Text
  -m MESSAGE, --message MESSAGE
                        File, Mail Message File
  -a ATTACHMENT, --attachment ATTACHMENT
                        File, Mail Attachment File
```

### 示例信息
```
autoMail.py -c mySMTP.ini -s "Auto Mail Test" -m Message.info -a Attachment.file
```
