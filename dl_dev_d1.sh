#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh
OUTFILE1=/home/$(whoami)/Dropbox/dataENF/blmg/d1_adj_allstk.csv
OUTFILE1_TMP=/home/$(whoami)/Dropbox/dataENF/blmg/d1_adj_allstk_tmp.csv
OUTFILE2=/home/$(whoami)/Dropbox/dataENF/blmg/d1_adj_allidx.csv
OUTFILE3=/home/$(whoami)/Dropbox/dataENF/blmg/d1_adj_allhsi1.csv
OUTFILEALL=/home/$(whoami)/Dropbox/dataENF/blmg/d1_adj_all.csv
OUTFOLDER_ADJ=/home/$(whoami)/Dropbox/dataENF/blmg/data_adj/
BRKSCT=/home/$(whoami)/Dropbox/dataENF/blmg/brkBlmgBarFrSglFileToIndivFile.py

source $BLMGCOMMON

###################################################
# all stocks
###################################################
cat /dev/null > $OUTFILE1

for i in $(seq 1 10)
do
    SYMBOLSTR=""

    if   [[ $i -eq 1  ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_1;
    elif [[ $i -eq 2  ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_2;
    elif [[ $i -eq 3  ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_3;
    elif [[ $i -eq 4  ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_4;
    elif [[ $i -eq 5  ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_5;
    elif [[ $i -eq 6  ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_6;
    elif [[ $i -eq 7  ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_7;
    elif [[ $i -eq 8  ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_8;
    elif [[ $i -eq 9  ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_9;
    elif [[ $i -eq 10 ]]; then SYMLIST=$SYMBOLLIST_HKSTKALL_D1_10;
    fi

    for sym in $SYMLIST
    do
        SYMBOLSTR=$SYMBOLSTR" -s $sym"
    done

    java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME $SYMBOLSTR -symsuffix " HK Equity" -start 20110101 -end 20201231 -adjusted true -o $OUTFILE1_TMP

    cat $OUTFILE1_TMP >> $OUTFILE1
done

# ###################################################
# # all index
# ###################################################
# SYMBOLSTR=""
#
# for sym in $SYMBOLLIST_HKIDX_D1
# do
#     SYMBOLSTR=$SYMBOLSTR" -s $sym"
# done
#
# java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME $SYMBOLSTR -symsuffix " Index" -start 20110101 -end 20201231 -adjusted true -o $OUTFILE2
cat /dev/null > $OUTFILE2

###################################################
# HSI 1 Index
###################################################
java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME -s "$SYMBOLLIST_HKIDX_D1_HSI1" -start 20110101 -end 20201231 -adjusted true -o $OUTFILE3

cat $OUTFILE1 $OUTFILE2 $OUTFILE3 > $OUTFILEALL

###################################################
/usr/bin/python $BRKSCT $(whoami) $OUTFILEALL $OUTFOLDER_ADJ
