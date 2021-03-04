#!/usr/bin/env python3

from giturlparse import parse
from ppretty import ppretty
import json
import sys

# url = 'git@github.com:Org/Private-repo.git'
# url2 = 'https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git'
# url3 = 'git@gitee.com:pdusb/linux-firmware.git'

# surl = parse(url)
# print(ppretty(surl,seq_length=10))
# print(surl.urls)
# # attrs = vars(surl)
# # {'kids': 0, 'name': 'Dog', 'color': 'Spotted', 'age': 10, 'legs': 2, 'smell': 'Alot'}
# # now dump this in some way or another
# # print(', '.join("%s: %s" % item for item in attrs.items()))
# # print(surl)

# surl = parse(url2)
# print(ppretty(surl,seq_length=10))
# print(surl.urls)

# surl = parse(url3)
# print(ppretty(surl,seq_length=10))
# print(surl.urls)
# print(surl.urls['https'])

ifile="repos.json"
ofile="pdusb-mirror-repos.txt"
USEHTTP=1
USESSH=0
USEGIT=0

def main(argv):
  global USESSH,USEGIT,USEHTTP
   # try:
   #    opts, args = getopt.getopt(argv[1:],"hgsi:o:",["ifile=","ofile="])
   # except getopt.GetoptError:
   #    print 'argv[1] -i <inputfile> -o <outputfile>'
   #    sys.exit(2)
   # for opt, arg in opts:
   #    if opt == '-h':
   #       USEHTTP=1
   #       USEGIT=0
   #       USESSH=0
   #    elif opt == '-g':
   #      USEGIT=1
   #      USEHTTP=0
   #      USESSH=0
   #    elif opt == '-s':
   #      USEGIT=0
   #      USEHTTP=0
   #      USESSH=1
   #    elif opt in ("-i", "--ifile"):
   #       ifile = arg
   #    elif opt in ("-o", "--ofile"):
   #       ofile = arg
  if len(sys.argv) >2:
    if sys.argv[1] == "http":
      USEGIT=0
      USESSH=0
      USEHTTP=1
    elif sys.argv[1] == "ssh":
      USEGIT=0
      USESSH=1
      USEHTTP=0
    elif sys.argv[1] == "git":
      USEGIT=1
      USESSH=0
      USEHTTP=0

  print("Input file  ",ifile)
  print("Output file ",ofile)
  print("HTTP {} GIT {} SSH {}".format(USEHTTP,USEGIT,USESSH))

  f = None
  try:
    f = open(ofile, "w")
  except Exception as e:
    print("Failed Open write file ")

  try:
    with open(ifile) as json_file:
        data = json.load(json_file)
        for p in data['mirrors']:
          surl = parse(p['dst'])
          
          if USEHTTP:
            f.write(p['src']+" "+surl.urls['https']+"\n")
          if USESSH:
            f.write(p['src']+" "+surl.urls['ssh']+"\n")
          if USEGIT:
            f.write(p['src']+" "+surl.urls['git']+"\n")
            # print('Src: ' + p['src'])
            # print('Dst: ' + p['dst'])
            # print('')
  except EnvironmentError:
    print("Failed Open input file ")

  if f:
    f.close()

if __name__ == "__main__":
   main(sys.argv[0:])
