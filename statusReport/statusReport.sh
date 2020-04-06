#!/usr/bin/env sh

## get statusReport directory
srdir=$(dirname $(readlink -f $0))

## set autoMail.py & statusReport.ini
srmail=${srdir}/autoMail.py
srini=${srdir}/statusReport.ini

## Create statusReport
srdate=$(date +%Y-%m-%d)
srfile=${srdir}/${srdate}_status_report.log

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

## Send statusReport By EMail
${srmail} -c ${srini} -s "Status Report : ${srdate}" -m ${srfile}

