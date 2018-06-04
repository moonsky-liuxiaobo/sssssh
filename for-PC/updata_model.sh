#终极版
#for PC

#check SD card
DIRECTORY="/media/usb/"
if [ "`ls -A $DIRECTORY`" = "" ];then
    echo -e "\033[4;31m SDcard \033[0m not found! Please check your SDcard reader!"
    exit 0
fi

#check SD card wthear has default.h5
if [  -f "/media/usb/default.h5" ];then
    echo -e "There is a \033[4;31m default.h5 \033[0m file on your SDcard! You must be delete it before training!"
    echo "[y/n]?"
    read key
    if [ $key = 'y' ];then
    	sudo rm /media/usb/default.h5
    	echo "Deleting default.h5 Successfully!"
    else
    	echo "You must delete \033[4;31m default.h5 \033[0m before training!"
    	exit 0
    fi
fi

#check models/ has default.h5
cd LearningRover/LR_car/
if [ ! -f "models/default.h5" ];then
    echo -e "default.h5 file \033[4;31m not found \033[0m under directory models/! Please check it!"
    exit 0
fi

#copy
sudo cp models/default.h5 /media/usb/
echo "copy default.h5 to SD card finished!"

#delete model
sudo rm models/default.h5