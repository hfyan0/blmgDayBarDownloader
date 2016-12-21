#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/target/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh
OUTFILE1=/home/$(whoami)/Dropbox/dataENF/blmg/d1_fundl_allstk.csv
OUTFILE1_TMP=/home/$(whoami)/Dropbox/dataENF/blmg/d1_fundl_allstk_tmp.csv
OUTFILE1_TMP2=/home/$(whoami)/Dropbox/dataENF/blmg/d1_fundl_allstk_tmp2.csv
OUTFOLDER_ADJ=/home/$(whoami)/Dropbox/dataENF/blmg/data_fundl_adj/
BRKSCT=/home/$(whoami)/Dropbox/dataENF/blmg/brkBlmgBarFrSglFileToIndivFile.py

source $BLMGCOMMON

###################################################
# all stocks
###################################################
cat /dev/null > $OUTFILE1

SYMBOLSTR="-s HSI -s SPX -s SPXT"

cat /dev/null > $OUTFILE1_TMP
cat /dev/null > $OUTFILE1_TMP2

java -jar $BIN -f PE_RATIO -f PX_LAST $SYMBOLSTR -symsuffix " Index" -start 19001001 -end 20201231 -adjusted true -o $OUTFILE1_TMP
# java -jar $BIN -f PX_LAST -f EQY_SH_OUT -f CUR_MKT_CAP -f PE_RATIO $SYMBOLSTR -symsuffix " Index" -start 20161001 -end 20201231 -adjusted true -o $OUTFILE1_TMP
# java -jar $BIN -f TRAIL_12M_EPS $SYMBOLSTR -symsuffix " Index" -start 20161001 -end 20201231 -adjusted true -o $OUTFILE1_TMP2

cat $OUTFILE1_TMP >> $OUTFILE1
cat $OUTFILE1_TMP2 >> $OUTFILE1
