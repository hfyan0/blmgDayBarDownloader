#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh

source $BLMGCOMMON

for FILE_SUFFIX in hk us
do

    ###################################################
    SYMBOLSTR=""
    for SYM in HSI
    do
        SYMBOLSTR=$SYMBOLSTR" -s "$SYM
    done
    SYM_SUFFIX=" Index"

    ###################################################
    java -jar $BIN -f PE_RATIO         $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $HOME/hsi_pe.csv
    java -jar $BIN -f PB_RATIO         $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $HOME/hsi_pb.csv
    java -jar $BIN -f PX_LAST          $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $HOME/hsi_px.csv
    java -jar $BIN -f BOOK_VAL_PER_SH  $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $HOME/hsi_bps.csv
    java -jar $BIN -f IS_EPS           $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $HOME/hsi_eps.csv

done
