#cd pi
#chmod +x setup.sh (Optional - if the file is not ececutable)
#./setup.sh

#setting colour for comments in shell script
#https://misc.flogisoft.com/bash/tip_colors_and_formatting
colr='\e[33m\e[48;5;21m' #yellow text with blue background

#Reading system date and time and updating file name
now=$(date +'%m-%d-%y-%H'HH'-%M'MM'')
file="log-"$now".txt"

#Updating and Upgrading linux system
echo -e "${colr}Starting system update"
sudo apt-get update > ../$file
echo -e "${colr}Initial Saving: "$file" after Update"
echo -e "${colr}Starting system upgrade"
sudo apt-get upgrade -y >> ../$file
echo -e "${colr}apt-get Upgrade complete"

#setting up nano to display linenumber
#https://unix.stackexchange.com/questions/15594/is-there-line-numbering-for-nano
sudo sed -i "s/^# set linenumbers/set linenumbers/g" /etc/nanorc
echo "Nano setup to display line number"

#Create new virtual environment and activate it
cd /home/pi/
sudo mkdir EyeTracker
cd EyeTracker
python3 -m venv eyetracker
source eyetracker/bin/activate

#Installing pip3 setup tools
pip install --upgrade pip setuptools wheel
echo -e "${colr}pip3 setup tools complete"

#Installing OpenCV
sudo apt install python3-opencv






