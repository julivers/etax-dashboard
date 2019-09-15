#!/bin/sh
dt=`date +%Y%m%d`
#echo $dt
temp="/data/palembang/sushitei/temp.csv"
temp2="/data/palembang/sushitei/temp2.csv"
f="/data/palembang/sushitei/sushitei_"$dt".rst"

#echo $f
cd /home/palembang/sushitei
/bin/mv SushiTei_20* /data/palembang/sushitei
cd /data/palembang/sushitei
cat SushiTei_20* | col -b > $temp

sed -i 's/"//g' $temp
sed -i '/transactionid/d' $temp

cat $temp | awk -F"," '{print "sushitei,Sushi Tei,"$8","int($4+$5)","$2}' > $f
#/usr/bin/awk ' BEGIN {FS=",";OFS=",";} {split($3, date, / /);$3=date[1]; print $0}' $temp2 > $f
#/usr/bin/awk ' BEGIN {FS=",";OFS=",";} {split($3, date, /-/);$3=date[3]"-"date[1]"-"date[2]; print $0}' $temp > $f


/bin/mv SushiTei_20* /data/palembang/sushitei/backup
sleep 1

if [ -s "$f" ]; then
     parse=`/usr/bin/python /home/etax/script/importstruk.py $f`
     if [ $? -eq 0 ];then
  	/bin/mv $f /data/palembang/sushitei/ready
     fi
fi
