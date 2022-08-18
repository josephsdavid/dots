#!/usr/bin/env bash
ZIPDIR="/home/david/Downloads"
DBDIR="./db"
IDFILE="${ZIPDIR}/.last_id"
### ADDR="http://www.chesscenter.com/twic/zips/"
ADDR="http://www.theweekinchess.com/zips/"
WOPTS=""
PGNFILE="${DBDIR}/twic.pgn"

if [ ! -d $ZIPDIR ]; then
	echo "Creating folder \"${ZIPDIR}/\""
	mkdir ${ZIPDIR}
fi

if [ ! -d $DBDIR ]; then
	echo "Creating folder \"${DBDIR}/\""
	mkdir ${DBDIR}
fi

## the first known issue of TWIC
i=920
## a very high number which will not be reached
last_i=$((9999))

if [ $# == 0 ]; then

    if [ -f ${IDFILE} ]; then
	LAST_ID=`cat ${IDFILE}`
    else
    	LAST_ID=`cd ${ZIPDIR}; ls * | sort | tail -1`
    	LAST_ID=`basename ${LAST_ID} .zip`
    fi
    if [ ${LAST_ID} ]; then
        echo "Last id: ${LAST_ID}"
        i=$((${LAST_ID} + 1))

    fi
else

    if [ $1 == "--help" ]; then
        echo "Usage: $0 [<start_issue> [<end_issue> [ <pgnfile>] ] ]"
        exit 1
    elif [ $# -ge 2 ]; then
        last_i=$(($2))

    fi
    i=$1
fi


if [ $# == 3 ]; then
    PGNFILE=$3
fi

echo -e "Downloading issues \033[31m$i \033[0mto \033[31m${last_i}\033[0m"
echo "Starting download from issue $i..."

DOWNLOADED=""
CONT="true"
while $CONT -eq "true"; do
    echo -ne "\033[33m downloading TWIC issue \033[31m$i\033[33m...."
    dest_name="twic${i}.zip"
    `wget -q $WOPTS $ADDR/twic${i}g.zip -O - > ${ZIPDIR}/twic${i}.zip`
    SIZE=`stat -c "%s" ${ZIPDIR}/${dest_name}`
    if [ ${SIZE} != "0" ]; then
        CONT="true"
        echo -e "\033[32m done!"
        DOWNLOADED="${DOWNLOADED} ${dest_name}"
        i=$(($i+ 1))
    else
        echo -e "\033[31m failed!"
        rm ${ZIPDIR}/${dest_name}
	#if [ -f ${IDFILE} ]; then
		echo $(($i -1)) > ${IDFILE}
	#fi
        CONT="false"
    fi
    if [ $i -gt ${last_i} ]; then
        CONT="false"
    fi
done

echo
echo -e "\033[33m ---------------------------------"
echo

echo -en "\033[31m Updating PGN file \033[32m$PGNFILE\033[31m...."
for fname in ${DOWNLOADED}; do

    unzip -c $ZIPDIR/${fname} >> ${PGNFILE}

done

echo -e "\033[32m done! \033[0m"

echo
echo -e "\033[33m ---------------------------------"
echo

echo -e "\033[31m Rebuilding SCID DB....\033[33m"

pgnscid -f ${PGNFILE} twic

echo
echo -e "\033[32m done! \033[0m"
echo
echo -e "\033[33m --------------------------------- \033[0m"
echo

