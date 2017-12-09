#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh
OUTFOLDER=/home/$(whoami)/Dropbox/nirvana/mvo/data/
QVICOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/qvi_common.sh

source $BLMGCOMMON
source $QVICOMMON

# ###################################################
# # futures
# ###################################################
# java -jar $BIN -f PX_LAST -s HI1 -s HC1 -symsuffix " Index" -start 20030101 -end 20301231 -adjusted false -o $OUTFOLDER/hist_adj_px_hk_fut.csv
#
#
# ###################################################
# # HK US stocks
# ###################################################
#
# for FILE_SUFFIX in hk1 hk2 us sp au
# do
#     set_symstr_sym_suffix
#     java -jar $BIN -f PX_LAST $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 20050101 -end 20301231 -adjusted true  -o $OUTFOLDER/hist_adj_px_"$FILE_SUFFIX".csv
#     java -jar $BIN -f PX_LAST $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 20050101 -end 20301231 -adjusted false -o $OUTFOLDER/hist_unadj_px_"$FILE_SUFFIX".csv
# done
#
# ###################################################
# # Currencies
# ###################################################
# java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME -s "CNYHKD Curncy" -start 19000101 -end 20301231 -adjusted false -o $OUTFOLDER/CNYHKD.csv
# java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME -s "USDHKD Curncy" -start 19000101 -end 20301231 -adjusted false -o $OUTFOLDER/USDHKD.csv
# java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME -s "SGDHKD Curncy" -start 19000101 -end 20301231 -adjusted false -o $OUTFOLDER/SGDHKD.csv
java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME -s "AUDHKD Curncy" -start 19000101 -end 20301231 -adjusted false -o $OUTFOLDER/AUDHKD.csv
