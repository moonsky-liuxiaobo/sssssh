#for raspberry

#check SD card is get ready
DIRECTORY="/media/usb/"
if [ "`ls -A $DIRECTORY`" = "" ];then
    echo -e "The SD card \033[4;31m is not inserted \033[0m correctly! Please check it!"
    exit 0
fi

#get raspberry id
echo ""
echo -e "Please input your Raspberry \033[4;31m id \033[0m."
read raspberry_id

#check SD card whether has old data
echo ""
if [ -f "/media/usb/data-"${raspberry_id}".tar.gz" ];then
    echo -e "The file named \033[4;31m data-${raspberry_id}.tar.gz \033[0m is already in your SD Card! Please delete or backup it first!"
    echo "Please input [y/n] and press Enter!"
    read key1
    if [ $key1 = 'y' ];then
	sudo rm /media/usb/data-${raspberry_id}.tar.gz
        echo ""
        echo -e "Delete \033[4;31m data.tar.gz \033[0m successfully!"
    else
        echo ""
	echo -e "You have to delete \033[4;31m data.tar.gz \033[0m in the SD Card!"
	exit 0
    fi
fi

#check data folder whether has data
DIRRECTORY="/home/pi/LR/data/"
if [ "`ls -A $DIRRECTORY`" = "" ];then
    echo ""
    echo "You have not recorded any data! Please try again!"
    exit 0
fi

#check should not rename
cd LR/data
key2=0
for file in `ls $1`
    do
    if [ -d $1"/"$file ];then
        read_dir $1"/"$file
    else
        if [ "$file" == "1" ];then
        key2=1
        fi
    fi
    done

#start rename
index=1
if [ "$key2" == "0" ];then
    for file in `ls $1`
        do
        if [ -d $1"/"$file ];then
            read_dir $1"/"$file
            echo $1"/"$file
        else
            sudo mv $file $index
     	    #cd $index
	    sudo chmod 777 *
	    index=`expr $index + 1`
            #cd ..
        fi
        done
fi
echo -e "It shows what is under \033[4;31m 'LR/data/ ' \033[0m directory, folders and number of files in each folder."

#show data/ detailes
for file in `ls $1`
    do
    if [ -d $1"/"$file ];then
        read_dir $1"/"$file
    else
        echo -e -n "Path:data/ \033[4;31m $file \033[0m"
        cd $file
        data_num=$(ls -lR|grep "^-"|wc -l)
        cd ..
        echo -e "   Number: \033[4;31m $data_num \033[0m"
    fi
    done
echo ""

#start tar
echo "Choose which data folder you want to copy, please input the folder number as following format."
echo " 1/ 2/ 3/... n/"
read foldes_list
echo $foldes_list
echo "Data folder selection finished!"

#tar data to SD casr
ls
sudo tar -zcvf /home/pi/LR/logs/data-${raspberry_id}.tar.gz $foldes_list
sudo cp /home/pi/LR/logs/data-${raspberry_id}.tar.gz /media/usb/
echo "Copy Finished! "

if [ -f "/media/usb/data-"${raspberry_id}".tar.gz" ];then
    sudo rm -rf /home/pi/LR/data/*
else
    echo "Failed to copy! Please try again!"
fi
