
# 常见设备研发所需Repo镜像集合

- 每天三次,自动从各自Repo的地址镜像更新到Gitee,国内使用可以无缝替换.
- 每天三次,每天三次,每天三次,不是一次性买卖,每天自动
- 陆续新增不同repo

## 手动使用

简单粗暴的直接替换掉地址即可,如使用镜像前
```Bash
git clone https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git my-firmware
```
使用镜像可以直接替换掉URL地址即可
```Bash
git clone https://gitee.com/pdusb/linux-firmware.git
```

## 脚本中使用

- 下载本Repo
- Copy 目录shellscripts里面的文件到目标系统,如/projects/scripts
- 在要使用镜像的脚本里面
  - 如原来代码为
```Bash
  url="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"
  git clone $url xxx
```
  - 则修改为
```Bash
  url="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"
  url = $(/projects/scripts/pdusb-git-mirror.sh /projects/scripts "$url")
  git clone $url xxx
```


## Mirror 对应表

| Name  |  Source  |  Gitee  | 
|---|---|---|
| linux-firmware | [https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git) | [https://gitee.com/pdusb/linux-firmware.git](https://gitee.com/pdusb/linux-firmware.git) | 
| micropython | [https://github.com/micropython/micropython.git](https://github.com/micropython/micropython.git) | [https://gitee.com/pdusb/micropython.git](https://gitee.com/pdusb/micropython.git) | 
| pico-micropython-examples | [https://github.com/raspberrypi/pico-micropython-examples.git](https://github.com/raspberrypi/pico-micropython-examples.git) | [https://gitee.com/pdusb/pico-micropython-examples.git](https://gitee.com/pdusb/pico-micropython-examples.git) | 
| linux-stable | [git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git](git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git) | [https://mirrors.tuna.tsinghua.edu.cn/git/linux-stable.git](https://mirrors.tuna.tsinghua.edu.cn/git/linux-stable.git) | 


## 交流沟通

愉快的加入QQ群聊吧

![群聊](https://gitee.com/pdusb/pdusb-fast-pico/raw/master/img/pdusb-qq-group.png)

