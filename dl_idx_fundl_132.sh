#!/bin/bash
BIN=/home/$(whoami)/Dropbox/dataENF/blmg/blmgDayBarDownloader/blmg_day_bar_downloader-assembly-1.0-SNAPSHOT.jar
BLMGCOMMON=/home/$(whoami)/Dropbox/dataENF/blmg/common_path.sh
OUTFOLDER=/home/$(whoami)/Dropbox/nirvana/mvo/data/

SYMBOL_LIST="-s HSI -s HSCEI -s SPX -s NKY -s AS51 -s SMI -s AEX -s CAC -s DAX -s UKX -s NDX -s INDU"

source $BLMGCOMMON

java -jar $BIN -f BEST_EPS        $SYMBOL_LIST -symsuffix " Index" -start 19001001 -end 20201231 -adjusted false -o $OUTFOLDER/hist_idx_best_eps.csv
java -jar $BIN -f TRAIL_12M_EPS   $SYMBOL_LIST -symsuffix " Index" -start 19001001 -end 20201231 -adjusted false -o $OUTFOLDER/hist_idx_trail12m_eps.csv
java -jar $BIN -f DVD_SH_12M      $SYMBOL_LIST -symsuffix " Index" -start 19001001 -end 20201231 -adjusted false -o $OUTFOLDER/hist_idx_trail12m_dps.csv
java -jar $BIN -f PX_LAST         $SYMBOL_LIST -symsuffix " Index" -start 19001001 -end 20201231 -adjusted false -o $OUTFOLDER/hist_idx_last_px.csv
java -jar $BIN -f BOOK_VAL_PER_SH $SYMBOL_LIST -symsuffix " Index" -start 19001001 -end 20201231 -adjusted false -o $OUTFOLDER/hist_idx_bps.csv
