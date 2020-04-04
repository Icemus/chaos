#!/usr/bin/env sh

srdate=`date +%Y-%m-%d`
srfile=${srdate}_status_report.log

cat /dev/null > ${srfile}

echo -e "Status Report : ${srdate}" >> ${srfile}

echo -e "\n>>>>>>> uptime start" >> ${srfile}
uptime >> ${srfile} 2>&1
echo -e "<<<<<<< uptime end" >> ${srfile}

echo -e "\n>>>>>>> vnstat start" >> ${srfile}
vnstat >> ${srfile} 2>&1
echo -e "<<<<<<< vnstat end" >> ${srfile}

echo -e "\n>>>>>>> yum check-update start" >> ${srfile}
yum check-update >> ${srfile} 2>&1
echo -e "<<<<<<< yum check-update end" >> ${srfile}

echo -e "\nStatus Report : Done" >> ${srfile}

autoMail.py -c ./statusReport.ini -s "Status Report : ${srdate}" -m ${srfile}

