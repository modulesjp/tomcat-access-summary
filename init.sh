#!/bin/sh

# Variable setting
LOGDIR="/export/data/shell/log"
LOGFILE="${LOGDIR}/`basename ${0} .sh`.log"
EXECUTIONDATE="`date '+%Y/%m/%d'`"

write_log() {
  msg="${EXECUTIONDATE}${1}"
  echo -e "${msg}" >> "${LOGFILE}"
}