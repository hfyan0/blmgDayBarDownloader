#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh

source $BLMGCOMMON

###################################################
# HK US stocks
###################################################

SYMBOLLIST="SGDHKD USDHKD CNHHKD CNYHKD EURHKD GBPHKD JPYHKD AUDHKD NZDHKD CADHKD"
SYM_SUFFIX="Curncy"

SYMBOLSTR=""
for SYM in $SYMBOLLIST
do
    SYMBOLSTR=$SYMBOLSTR" -s "$SYM
done
java -jar $BIN -f PX_LAST $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 20170501 -end 20201231 -adjusted false -o fx.csv
