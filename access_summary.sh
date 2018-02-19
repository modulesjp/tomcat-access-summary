#!/bin/sh

# Initial Config
. /export/data/shell/init.sh
#. /export/data/shell/mail_send.sh
export PATH=$PATH:/usr/sbin

# Variable setting
LOGDATE=`date -d '1 day ago' '+%Y-%m-%d'`
DATA=()

# EXECUTION
grep_result=($(grep GET /usr/local/tomcat/logs/access_log.${LOGDATE}.txt | awk '{print $7}' | sort | uniq -c | grep -ive '\.\(css\|js\|txt\|ico\|png\|bootstrap*\|ttf\|woff2\)'))

if [ ${?} -eq 0 ]; then
  for i in "${grep_result[@]}"
    do
      expr $i + 1 2>/dev/null 1>/dev/null
      RET=$?
      if [ $RET -lt 2 ]; then
        DATA=("${DATA[@]}" "[ $i pv : ")
      else
        ISF=$'\n'
        DATA=("${DATA[@]}" "$i ]")
      fi
  done
else
  write_log "001-E There is no access infomation."
fi

echo ${DATA[@]}
exit