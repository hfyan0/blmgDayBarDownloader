#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh
OUTFOLDER=/home/$(whoami)/Dropbox/nirvana/mvo/data/blmgData
QVICOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/qvi_common.sh

source $BLMGCOMMON
source $QVICOMMON

###################################################
# HK US stocks
###################################################

for FILE_SUFFIX in hk1 hk2 us sp au
do
    set_symstr_sym_suffix
    java -jar $BIN -f PX_OPEN -f PX_HIGH -f PX_LOW -f PX_LAST -f PX_VOLUME $SYMBOLSTR -symsuffix " $SYM_SUFFIX" -start 20050101 -end 20991231 -adjusted true -o $OUTFOLDER/hist_adj_px_"$FILE_SUFFIX".csv
done
