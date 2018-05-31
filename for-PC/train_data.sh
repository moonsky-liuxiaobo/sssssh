#终极版
#for PC
#check donkeycar
#pip install --upgrade pip
#pip install -e donkeycar
#check tensorflow

#check data
echo ""
cd LearningRover/
DIRECTORY="LR_car/data/"
if [ "`ls -A $DIRECTORY`" = "" ];then
    echo -e "Data folders are \033[4;31m empty! \033[0m Please check it!"
    exit 0
fi

echo -e "Please input your raspberry \033[4;31m id \033[0m."
echo -e -n "\033[4;31m id \033[0m:"
read raspberry_id

#get document list
echo ""
echo "Here's the details:"
cd LR_car/data/
for file in `ls $1`
	do
    if [ -d $1"/"$file ];then
        read_dir $1"/"$file
    else
        cd $file
        date_num=$(ls -lR|grep "^-"|wc -l)
        echo -e -n "Document path: \033[4;31m data/"$file"\033[0m  "
        echo -e "Nubmer: \033[4;31m ${date_num} \033[0m "
        cd ..
        #list=`expr $file + ','`
        #$list=${file}","
    fi
	done

#get train_list
echo ""
echo "Please choice the documents to train, Enter like:"
echo "data/1,data/2...data/n..."
read train_list
echo $train_list
cd ..
python manage.py train --tub=$train_list --model=models/default.h5
echo -e "\033[4;31m train over! \033[4;31m "

#clean train data
if [ -f /media/usb/"${DATE}"-default.h5 ];then
    sudo rm -rf data/*
fi

#backups
DATE=$(date "+ %Y-%m-%d %H:%M:%S")
cd ../../../data/${raspberry_id}
sudo cp ../../LearningRover-pkg/LearningRover/LR_car/models/default.h5 ./"${DATE}"-default.h5
sudo chmod 777 "${DATE}"-default.h5
