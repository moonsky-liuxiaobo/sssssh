#for raspberry
#check SD card has default.h5
if [ ! -f "/media/usb/default.h5" ];then
    echo "There is no file named default.h5 in your SD Card! Please check it!"
    exit 0
fi

#check models whether has default.h5
if [ -f "/home/pi/LR/models/default.h5" ];then
    echo -e "There is a file named \033[4;31m 'default.h5' \033[0m under directory '/home/pi/LR/models/ '!"
    echo -e "You should delete this \033[4;31m default.h5 \033[0m first, Please enter [y/n]"
    read key_delete_h5
    if [ $key_delete_h5 = "y" ];then
        sudo rm /home/pi/LR/models/default.h5
        echo -e "Delete \033[4;31m default.h5 \033[0m successfully!"
    else
        echo -e "You have to delete \033[4;31m default.h5 \033[0m!"
        exit 0
    fi
fi
#copy default.h5 to raspbery
sudo cp /media/usb/default.h5 /home/pi/LR/models/
echo -e "\033[4;31m 'default.h5' \033[0m has been updated from SDCard"
sudo rm /media/usb/default.h5
