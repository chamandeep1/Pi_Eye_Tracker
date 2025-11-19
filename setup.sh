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

#Install opencv in the main pi environment first so it can be installed in virtual environment later
sudo apt install python3-opencv libopencv-dev libopenblas0 libopenblas-dev

#Create new virtual environment and activate it
cd /home/pi/
sudo mkdir EyeTracker
cd EyeTracker
sudo python3.11 -m venv eyetracker
source eyetracker/bin/activate

# Give permission to the eye tracker folder for writing
sudo chown -R pi:pi /home/pi/EyeTracker/eyetracker

#Install Numpy
pip install numpy

#Linking OpenCV in the base environment ot the virtual environment
ln -sf /usr/lib/python3/dist-packages/cv2.cpython-313-aarch64-linux-gnu.so \
/home/pi/EyeTracker/eyetracker/lib/python3.13/site-packages/cv2.so
#Use followign command to test
#python -c "import cv2; print(cv2.__version__)"

#Download Haar Cascades (eyes + face) for detection in the project folder
wget https://raw.githubusercontent.com/opencv/opencv/master/data/haarcascades/haarcascade_frontalface_default.xml
wget https://raw.githubusercontent.com/opencv/opencv/master/data/haarcascades/haarcascade_eye.xml








