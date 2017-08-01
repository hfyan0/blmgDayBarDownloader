#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh
OUTFOLDER=/home/$(whoami)/Dropbox/nirvana/mvo/data/

source $BLMGCOMMON

###################################################
# futures
###################################################
java -jar $BIN -f PX_LAST -s HI1 -s HC1 -symsuffix " Index" -start 20030101 -end 20201231 -adjusted false -o $OUTFOLDER/hist_adj_px_hk_fut.csv


###################################################
# HK US stocks
###################################################

for FILE_SUFFIX in hk us
do
    if [[ $FILE_SUFFIX == "hk" ]]
    then
        # SYMBOLLIST="1 2 3 4 5 6 8 11 12 13 16 17 19 23 27 66 83 101 135 144 151 168 177 267 291 293 322 323 330 338 345 347 358 386 388 390 489 494 525 551 552 576 598 688 694 700 728 753 762 763 823 836 857 883 902 914 916 939 941 991 992 998 1038 1044 1066 1071 1088 1099 1109 1113 1133 1138 1157 1171 1186 1199 1211 1288 1299 1336 1339 1359 1398 1618 1766 1776 1800 1816 1880 1898 1919 1928 1988 2018 2038 2202 2238 2318 2319 2328 2333 2338 2388 2600 2601 2628 2669 2698 2727 2777 2866 2883 2899 3323 3328 3699 3898 3968 3988 3993 6030 6837 6881 6886"
        SYMBOLLIST="1 2 3 4 5 6 8 11 12 13 14 16 17 19 23 27 41 52 54 62 66 83 101 133 135 144 151 157 168 177 207 267 291 293 319 321 322 323 330 338 341 345 347 358 386 388 390 425 435 468 489 494 517 525 533 538 551 552 576 598 669 686 688 694 698 700 728 753 762 763 778 808 823 836 857 883 902 914 916 939 941 958 960 966 991 992 998 999 1023 1038 1044 1066 1071 1088 1093 1099 1109 1113 1133 1138 1157 1170 1171 1186 1199 1211 1288 1299 1330 1336 1339 1359 1398 1426 1447 1599 1618 1666 1700 1766 1776 1800 1816 1880 1898 1899 1919 1928 1988 1999 2018 2028 2038 2202 2238 2313 2318 2319 2328 2333 2338 2348 2356 2380 2388 2600 2601 2628 2669 2688 2698 2727 2777 2778 2800 2866 2883 2899 3323 3328 3336 3380 3699 3813 3898 3968 3988 3993 6030 6823 6837 6881 6886"
        SYM_SUFFIX="HK Equity"
    else
        SYMBOLLIST="AA AAPL AIG AXP BA BAC C CAT CCE CSCO CVX DD DIS GE GM GS HD HON HPQ IBM INTC IP JNJ JPM KHC KODK MCD MMM MO MRK MSFT NKE PFE PG PM T TRV UNH UTX V VZ WMT XOM SPY DIA"
        SYM_SUFFIX="US Equity"
    fi

    SYMBOLSTR=""
    for SYM in $SYMBOLLIST
    do
        SYMBOLSTR=$SYMBOLSTR" -s "$SYM
    done
    java -jar $BIN -f PX_LAST $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 20050101 -end 20201231 -adjusted true -o $OUTFOLDER/hist_adj_px_"$FILE_SUFFIX".csv
    java -jar $BIN -f PX_LAST $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 20050101 -end 20201231 -adjusted false -o $OUTFOLDER/hist_unadj_px_"$FILE_SUFFIX".csv
done

###################################################
# Currencies
###################################################
java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME -s "CNYHKD Curncy" -start 19000101 -end 20201231 -adjusted false -o $OUTFOLDER/CNYHKD.csv

# ###################################################
# CNT=1
# for SYM in $SYMBOLLIST1
# do
#     if [[ $CNT -eq 1 ]]
#     then
#         SYMBOLSTR=""
#         for SYM in $SYMBOLLIST1
#         do
#             SYMBOLSTR=$SYMBOLSTR" -s "$SYM
#         done
#     elif [[ $CNT -eq 2 ]]
#     then
#         SYMBOLSTR=""
#         for SYM in $SYMBOLLIST2
#         do
#             SYMBOLSTR=$SYMBOLSTR" -s "$SYM
#         done
#     elif [[ $CNT -eq 3 ]]
#     then
#         SYMBOLSTR=""
#         for SYM in $SYMBOLLIST3
#         do
#             SYMBOLSTR=$SYMBOLSTR" -s "$SYM
#         done
#     elif [[ $CNT -eq 4 ]]
#     then
#         SYMBOLSTR=""
#         for SYM in $SYMBOLLIST4
#         do
#             SYMBOLSTR=$SYMBOLSTR" -s "$SYM
#         done
#     elif [[ $CNT -eq 5 ]]
#     then
#         SYMBOLSTR=""
#         for SYM in $SYMBOLLIST5
#         do
#             SYMBOLSTR=$SYMBOLSTR" -s "$SYM
#         done
#     else
#         break
#     fi
#
#     java -jar $BIN -f PX_LAST $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 20030101 -end 20201231 -adjusted true -o $OUTFOLDER/hist_adj_px_"$FILE_SUFFIX"_"$CNT".csv
#     java -jar $BIN -f PX_LAST $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 20030101 -end 20201231 -adjusted false -o $OUTFOLDER/hist_unadj_px_"$FILE_SUFFIX"_"$CNT".csv
#     cat $OUTFOLDER/hist_adj_px_"$FILE_SUFFIX"_"$CNT".csv >> $OUTFOLDER/hist_adj_px_"$FILE_SUFFIX".csv
#     cat $OUTFOLDER/hist_unadj_px_"$FILE_SUFFIX"_"$CNT".csv >> $OUTFOLDER/hist_unadj_px_"$FILE_SUFFIX".csv
#     CNT=$(expr $CNT + 1)
# done
