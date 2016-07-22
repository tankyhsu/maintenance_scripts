# -*- coding: UTF-8 –*-

import yaml
import commands
import time


class Tomcat:
    check_tomcat_alive_command = "ps -ef | grep tomcat | grep catalina.home"
    get_tomcat_pid_command = "ps -ef | grep tomcat | grep catalina.home| awk '{print $2}'"
    times = 90

    def __init__(self, config):
        self.old_pid = 0
        self.new_pid = 1
        self.config = config
        self.output = ''
        self.code = 0
        if self.config["tomcat"]["home"].endswith("/"):
            self.start_shell = self.config["tomcat"]["home"] + "bin/startup.sh"
            self.stop_shell = self.config["tomcat"]["home"] + "bin/shutdown.sh"
        else:
            self.start_shell = self.config["tomcat"]["home"] + "/bin/startup.sh"
            self.stop_shell = self.config["tomcat"]["home"] + "/bin/shutdown.sh"

    def stop(self):
        if Tomcat.is_tomcat_alive():
            self.old_pid = Tomcat.get_tomcat_pid()
            self.code, self.output = commands.getstatusoutput(self.stop_shell)
            count = 0
            if self.code == 0:
                while count < Tomcat.times:
                    time.sleep(1)
                    count += 1
                    if Tomcat.is_tomcat_alive():
                        print "tomcat is still alive after " + str(count) + "s"
                    else:
                        print "tomcat is dead after " + str(count) + "s"
                        print " 关闭TOMCAT成功！"
                        return
                else:
                    print "tomcat is still alive after " + str(count) + "s and I think something is wrong with it "
                    print "关闭TOMCAT失败！" + self.output
        else:
            print "Tomcat is already dead!"

    def start(self):
        if Tomcat.is_tomcat_alive():
            print "Tomcat is on going!"
        else:
            self.code, self.output = commands.getstatusoutput(self.start_shell)
            print "Tomcat is going to start!"
            time.sleep(5)
            self.new_pid = Tomcat.get_tomcat_pid()
            if Tomcat.is_tomcat_alive():
                print "TOMCAT已成功发送启动命令，并且正在启动中，无法检测启动完成时间！"

    def restart(self):
        self.stop()
        self.start()
        if self.new_pid == self.old_pid:
            print "#####重启TOMCAT失败,进程ID并未改变######"
        print "tomcat旧的进程ID为" + self.old_pid, "tomcat新的进程ID为" + self.new_pid

    @classmethod
    def is_tomcat_alive(cls):
        status, output = commands.getstatusoutput(cls.check_tomcat_alive_command)
        result = output.split("\n")

        if len(result) > 1:
            return True
        else:
            return False

    @classmethod
    def get_tomcat_pid(cls):
        _, pid = commands.getstatusoutput(cls.get_tomcat_pid_command)
        return pid.split("\n")[0]


if __name__ == "__main__":
    f = open("./config/config.yaml")
    config = yaml.safe_load(f)
    f.close()
    tomcat = Tomcat(config)
    tomcat.restart()
