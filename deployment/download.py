# -*- coding: utf-8 -*-
import os
import shutil
import urllib2

import datetime
import yaml


class Download(object):
    def __init__(self, config):
        self.config = config

    def download(self):
        for i in range(0, len(self.config["apps"]["war"])):
            app = self.config["apps"]
            f = urllib2.urlopen(app["url"][i])
            data = f.read()
            with open(app["war"][i], "wb") as code:
                code.write(data)

    def backup(self):
        for i in range(0, len(self.config["apps"]["war"])):
            name = self.config["apps"]["war"][i]
            old_file = self.config["tomcat"]["home"] + "webapps/" + name
            dir = self.config["tomcat"]["home"] + "webapps/" + self.config["apps"]["dir"][i]
            print old_file
            localtime = datetime.datetime.now().strftime("%Y%m%d")
            os.rename(old_file, old_file + "bak" + localtime)
            os.rename(name, old_file)
            shutil.rmtree(dir)


if __name__ == "__main__":
    f = open("./config/config.yaml")
    config = yaml.safe_load(f)
    f.close()
    download = Download(config)
    download.download()
