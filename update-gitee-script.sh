
cd utils
./convert-repo-to-json.sh
./pdusb-create-shell-mirror.py
cd ..
cp -f utils/pdusb-mirror-repos.txt shellscripts/
cp -f README-base.md README.md
cat utils/readme-mirror.txt >> README.md
cat README-after.md >> README.md
