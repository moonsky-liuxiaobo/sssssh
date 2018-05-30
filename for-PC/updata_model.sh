#终极版
#for PC

#check SD card
DIRECTORY="/media/usb/"
if [ "`ls -A $DIRECTORY`" = "" ];then
    echo -e "Not found your \033[4;31m SDcard \033[0m! Please check it!"
    exit 0
fi

#check SD card wthear has default.h5
if [  -f "/media/usb/default.h5" ];then
    echo -e "SD card has found \033[4;31m other default.h5 \033[0m! You must be delete it!"
    echo "[y/n]?"
    read key
    if [ $key = 'y' ];then
    	sudo rm /media/usb/default.h5
    	echo "Successful delete delete.h5!"
    else
    	echo "You must be delete \033[4;31m default.h5 \033[0m!"
    	exit 0
    fi
fi

#check models/ has default.h5
cd LearningRover/LR_car/
if [ ! -f "models/default.h5" ];then
    echo -e "models/ has \033[4;31m not found \033[0m default.h5! Please check it!"
    exit 0
fi

#copy
sudo cp models/default.h5 /media/usb/
echo "Successful copy default.h5 to SD card!"

#delete model
sudo rm models/default.h5