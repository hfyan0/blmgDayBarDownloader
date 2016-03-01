#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh
OUTFILE=/home/$(whoami)/Dropbox/dataENF/blmg/d1_adj_allstk.csv

source $BLMGCOMMON

SYMBOLSTR=""

for sym in $SYMBOLLIST_HKSTKALL_D1
do
    SYMBOLSTR=$SYMBOLSTR" -s $sym"
done

java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME $SYMBOLSTR -symsuffix " HK Equity" -start 20100101 -end 20201231 -adjusted true -o $OUTFILE
