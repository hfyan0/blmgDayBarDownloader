#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh
OUTFOLDER=/home/$(whoami)/Dropbox/nirvana/mvo/data/

source $BLMGCOMMON

for FILE_SUFFIX in hk1 hk2 us
do

    if [[ $FILE_SUFFIX == "hk1" ]]
    then
        SYMBOLLIST="1 2 3 4 5 6 8 11 12 13 14 16 17 19 23 27 41 52 54 62 66 83 101 133 135 144 151 157 168 177 207 267 291 293 319 321 322 323 330 338 341 345 347 358 386 388 390 425 435 468 489 494 517 525 533 538 551 552 576 598 669 686 688 694 698 700 728 753 762 763 778 808 823 836 857 883 902 914 916 939 941 958 960 966 991 992 998 999 1023 1038 1044 1066 1071 1088 1093 1099 1109 1113 1133 1138 1157 1170 1171 1186 1199 1211 1288 1299 1330 1336 1339 1359 1398 1426 1447 1599 1618 1666 1700 1766 1776 1800 1816 1880 1898 1899 1919 1928 1988 1999 2018 2028 2038 2202 2238 2313 2318 2319 2328 2333 2338 2348 2356 2380 2388 2600 2601 2628 2669 2688 2698 2727 2777 2778 2800 2866 2883 2899 3323 3328 3336 3380 3699 3813 3898 3968 3988 3993 6030 6823 6837 6881 6886"
        SYM_SUFFIX="HK Equity"
    elif [[ $FILE_SUFFIX == "hk2" ]]
    then
        SYMBOLLIST="8 14 41 43 119 123 136 142 148 152 165 168 173 177 178 179 200 215 220 242 272 285 303 308 315 316 317 330 336 338 341 345 358 363 390 400 405 410 425 439 440 460 489 493 506 511 522 552 570 576 586 590 604 606 636 658 665 670 680 694 696 698 699 732 737 751 753 763 777 778 787 806 817 861 867 868 881 884 902 914 916 931 934 958 968 981 996 1031 1055 1066 1083 1099 1112 1117 1171 1186 1199 1208 1211 1212 1282 1293 1308 1313 1315 1316 1333 1336 1339 1347 1357 1363 1382 1432 1458 1508 1515 1530 1668 1680 1766 1776 1788 1813 1816 1882 1888 1898 1918 1919 1958 1970 1999 2038 2039 2128 2186 2199 2202 2238 2269 2314 2329 2333 2338 2356 2357 2380 2386 2588 2600 2607 2611 2689 2727 2777 2778 2883 2899 3323 3331 3360 3377 3380 3383 3396 3606 3618 3698 3800 3808 3886 3888 3898 3899 3900 3908 3969 6030 6099 6818 6881 6886"
        SYM_SUFFIX="HK Equity"
    elif [[ $FILE_SUFFIX == "us" ]]
    then
        SYMBOLLIST="AA AAPL AIG AXP BA BAC C CAT CCE CSCO CVX DD DIS GE GM GS HD HON HPQ IBM INTC IP JNJ JPM KHC KODK MCD MMM MO MRK MSFT NKE PFE PG PM T TRV UNH UTX V VZ WMT XOM SPY DIA"
        SYM_SUFFIX="US Equity"
    fi

    ###################################################
    SYMBOLSTR=""
    for SYM in $SYMBOLLIST
    do
        SYMBOLSTR=$SYMBOLSTR" -s "$SYM
    done

    ###################################################
    # Key
    ###################################################
    java -jar $BIN -f BOOK_VAL_PER_SH $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_bps_"$FILE_SUFFIX".csv
    java -jar $BIN -f TOTAL_EQUITY $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_totequity_"$FILE_SUFFIX".csv
    java -jar $BIN -f BS_TOT_ASSET $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_totasset_"$FILE_SUFFIX".csv
    java -jar $BIN -f OPER_ROE $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_oper_roe_"$FILE_SUFFIX".csv
    java -jar $BIN -f RETURN_COM_EQY $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_roe_"$FILE_SUFFIX".csv
    java -jar $BIN -f OPERATING_ROA $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_oper_roa_"$FILE_SUFFIX".csv
    java -jar $BIN -f COM_EQY_TO_TOT_ASSET $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_eqytoast_"$FILE_SUFFIX".csv
    java -jar $BIN -f IS_EPS $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_eps_"$FILE_SUFFIX".csv
    java -jar $BIN -f OPER_INC_PER_SH $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_oper_eps_"$FILE_SUFFIX".csv
    java -jar $BIN -f WACC_COST_DEBT $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_costofdebt_"$FILE_SUFFIX".csv
    java -jar $BIN -f TOT_LIAB_PER_SH $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_totliabps_"$FILE_SUFFIX".csv
    java -jar $BIN -f IS_OPER_INC $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_operincm_"$FILE_SUFFIX".csv
    java -jar $BIN -f IS_STATUTORY_TAX_RATE $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_stattaxrate_"$FILE_SUFFIX".csv
    java -jar $BIN -f RETURN_ON_ASSET $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_roa_"$FILE_SUFFIX".csv
    java -jar $BIN -f BEST_EPS $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_best_eps_"$FILE_SUFFIX".csv
    java -jar $BIN -f BS_SH_OUT $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_outshr_"$FILE_SUFFIX".csv

    # ###################################################
    # # Others
    # ###################################################
    # java -jar $BIN -f EBITDA $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_ebitda_"$FILE_SUFFIX".csv
    # java -jar $BIN -f PE_RATIO $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_pe_ratio_"$FILE_SUFFIX".csv
    # java -jar $BIN -f PB_RATIO $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_pbratio_"$FILE_SUFFIX".csv
    # java -jar $BIN -f CURR_ENTP_VAL $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_curentpval_"$FILE_SUFFIX".csv
    # java -jar $BIN -f BEST_EV $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_bestev_"$FILE_SUFFIX".csv
    # java -jar $BIN -f PX_TO_BOOK_RATIO $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_pb_ratio_"$FILE_SUFFIX".csv
    # java -jar $BIN -f EQY_DPS $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_dps_"$FILE_SUFFIX".csv
    # java -jar $BIN -f DVD_SH_LAST $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_dpshrlast_"$FILE_SUFFIX".csv
    # java -jar $BIN -f EQY_DVD_YLD_IND $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_dvdyld_"$FILE_SUFFIX".csv
    # java -jar $BIN -f EFF_TAX_RATE $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_eff_taxrate_"$FILE_SUFFIX".csv
    # java -jar $BIN -f EQY_FUND_CRNCY $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_curcy_"$FILE_SUFFIX".csv
    # java -jar $BIN -f NET_DEBT_PER_SHARE $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_netdebtps_"$FILE_SUFFIX".csv
    # java -jar $BIN -f SALES_REV_TURN $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_revenue_"$FILE_SUFFIX".csv
    # java -jar $BIN -f REVENUE_PER_SH $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_revps_"$FILE_SUFFIX".csv
    # java -jar $BIN -f BEST_SALES $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_bestrev_"$FILE_SUFFIX".csv
    # java -jar $BIN -f IS_INT_EXPENSE $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_intexp_"$FILE_SUFFIX".csv
    # java -jar $BIN -f IS_INT_EXPENSES $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_intexp_"$FILE_SUFFIX".csv
    # java -jar $BIN -f IS_COGS_TO_FE_AND_PP_AND_G $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_cogs_"$FILE_SUFFIX".csv
    # java -jar $BIN -f IS_OPERATING_EXPN $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_opexp_"$FILE_SUFFIX".csv
    # java -jar $BIN -f CUR_MKT_CAP $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_mktcap_"$FILE_SUFFIX".csv
    # java -jar $BIN -f DVD_PAYOUT_RATIO $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_dvdpayout_"$FILE_SUFFIX".csv
    # java -jar $BIN -f CF_CASH_FLOW_FIRM $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_cashflowtofirm_"$FILE_SUFFIX".csv
    # java -jar $BIN -f IS_DEPR_EXP $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_depre_exp_"$FILE_SUFFIX".csv
    # java -jar $BIN -f CASH_FLOW_PER_SH $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_oper_cfps_"$FILE_SUFFIX".csv
    # java -jar $BIN -f FREE_CASH_FLOW_PER_SH $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_fcfps_"$FILE_SUFFIX".csv
    # java -jar $BIN -f BEST_CALCULATED_FCF $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_bestfcf_"$FILE_SUFFIX".csv
    # java -jar $BIN -f CASHFLOW_FROM_OPERATIONS_SUM $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_oper_cf_"$FILE_SUFFIX".csv
    # java -jar $BIN -f SHORT_AND_LONG_TERM_DEBT $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_stltdebt_"$FILE_SUFFIX".csv
    # java -jar $BIN -f LONG_TERM_DEBT_SUM $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_ltdebt_"$FILE_SUFFIX".csv
    # java -jar $BIN -f INDUSTRIAL_LONG_TERM_DEBT_SUM $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_indus_ltdebt_"$FILE_SUFFIX".csv
    # java -jar $BIN -f CUR_RATIO $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_indus_curratio_"$FILE_SUFFIX".csv
    # java -jar $BIN -f GROSS_MARGIN $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_grossmrg_"$FILE_SUFFIX".csv
    # java -jar $BIN -f BEST_GROSS_MARGIN $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_bestgrossmrg_"$FILE_SUFFIX".csv
    # java -jar $BIN -f LISTED_SH $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_numlistedshr_"$FILE_SUFFIX".csv
    # java -jar $BIN -f GRAND_TOTAL_NUM_SHR $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_grandtotnumshr_"$FILE_SUFFIX".csv
    # java -jar $BIN -f SHARES_OUTSTANDING_SUM $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_os_shr_"$FILE_SUFFIX".csv
    # java -jar $BIN -f EQY_SH_OUT $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 19001001 -end 20301231 -adjusted false -o $OUTFOLDER/hist_eqyshrout_"$FILE_SUFFIX".csv

done
