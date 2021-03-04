# Add new repo to this 

Add the mirror to repos.txt
Run update-gitee-script.sh 


# 创建新的git mirror -> gitee
1. 获取URL
2. gitee创建好对应的repo
  从原有url导入,
  创建完成后 点击页面的导入按钮
3. github 中添加repos的路径
  /home/benson/rpi/t1/nlinux/pdusb-fast-linux/repos.txt
  sourceurl dsturl
  - cd utils
  - convert-repo-to-json.sh
  - convert-repo-to-json.sh
  - cd ../shellscripts
  - cp ../utils/pdusb-mirror-repos.txt .

# bash脚本中使用
  通过脚本/函数传入当前git repo路径，如果有镜像，则返回gitee的镜像地址,如没有则返回原repo地址

  - copy shellscripts目录到系统里面
  - 在脚本里面执行
    在pdusb-git-mirror.sh路径里面直接执行
    pdusb-git-mirror.sh none "giturls"
    如
    pdusb-git-mirror.sh none https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
    会返回giteee的地址

  - 在任意地方执行
    pdusb-git-mirror.sh path_for_pdusb-mirror-repos "giturls"
    如
    pdusb-git-mirror.sh /projects/scripts https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git


