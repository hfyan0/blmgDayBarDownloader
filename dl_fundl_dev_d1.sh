#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
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

    java -jar $BIN -f PX_LAST -f EQY_SH_OUT -f CUR_MKT_CAP -f PE_RATIO $SYMBOLSTR -symsuffix " HK Equity" -start 20110101 -end 20201231 -adjusted true -o $OUTFILE1_TMP
    java -jar $BIN -f TRAIL_12M_EPS $SYMBOLSTR -symsuffix " HK Equity" -start 20100101 -end 20201231 -adjusted true -o $OUTFILE1_TMP2

    cat $OUTFILE1_TMP >> $OUTFILE1
    cat $OUTFILE1_TMP2 >> $OUTFILE1
done
