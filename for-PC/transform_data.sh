#终极版
#for PC

#check SDcard
DIRECTORY="/media/usb/"
if [ "`ls -A $DIRECTORY`" = "" ];then
	echo -e "Not found your \033[4;31m SDcard \033[0m! Please check it!"
	exit 0
fi

#clean data
cd LearningRover/LR_car/
DIRECTORY="data"
if [ ! "`ls -A $DIRECTORY`" = "" ];then
	echo -e "You data doucument has \033[4;31m old data \033[0m, Please delete it!"
	echo "[y/n]?" 
	read key
	if [ $key = 'y' ];then
		cd data/
		sudo rm -rf *
		cd ..
		echo "Successful delete old data!"
	else
		echo "You must delete it!"
		exit 0
	fi
fi

#input raspberry number
echo ""
echo -e "Please input your raspberry \033[4;31m id \033[0m."
echo -e -n "\033[4;31m id \033[0m:"
read raspberry_id
#echo "/media/usb/data-"${raspberry_id}".tar.gz"

#check data.tar
if [ ! -f "/media/usb/data-"${raspberry_id}".tar.gz" ];then
    echo -e "Not found \033[4;31m data \033[0m ! Please check it"
    exit 0
fi

#copy data.tar and
sudo cp /media/usb/data-"${raspberry_id}".tar.gz data/
echo "Successful copy to data/!"

#tar data
cd data
sudo chmod 777 *
sudo tar -xvf "data-"${raspberry_id}.tar.gz
sudo rm "data-"${raspberry_id}.tar.gz
echo -e "Successful tar to data/ !"
sudo chmod 777 *

#Permissions
for file in `ls $1`
	do
	if [ -d $1"/"$file ];then
		read_dir $1"/"$file
	else
		#sudo mv $file $index
		DIRECTORY=$file
		if [ ! "`ls -A $DIRECTORY`" = "" ]; then
			cd $file
			sudo chmod 777 *
			cd ../
		fi
	fi
done

#backups
cd ../../../../data/"${raspberry_id}"
DATE=$(date "+ %Y-%m-%d %H:%M:%S")
echo ${DATE}
sudo cp /media/usb/data-"${raspberry_id}".tar.gz ./
sudo mv data-"${raspberry_id}".tar.gz "${DATE}".tar.gz
sudo rm "/media/usb/data-"${raspberry_id}.tar.gz
sudo chmod 777 *