#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh
OUTFOLDER=/home/$(whoami)/Dropbox/nirvana/mvo/data/
QVICOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/qvi_common.sh

source $BLMGCOMMON
source $QVICOMMON

for FILE_SUFFIX in hk1 hk2 us sp au
do

    set_symstr_sym_suffix

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
