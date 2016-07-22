# -*- coding: utf-8 -*-
import traceback

import yaml

from download import Download
from mail import Email
from tomcat import Tomcat

f = open("./config/config.yaml")
config = yaml.safe_load(f)
f.close()

text = "程序构建成功"
subject = "自动化构建成功"

try:
    # 下载

    download = Download(config)
    download.download()

    tomcat = Tomcat(config)
    tomcat.stop()

    print "##############下载成功##################"
    # 备份旧文件
    download.backup()

    print "##############备份成功##################"
    # 重启
    tomcat.start()
    print "##############重启成功##################"
except Exception, e:
    print Exception, ":", e
    subject = "自动化构建失败"
    text = "失败原因" + str(e)
    # 打印错误信息
    traceback.print_exc()

finally:
    email = Email(config)
    email.send(subject, text)

print "the end"
