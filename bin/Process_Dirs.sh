#/usr/bin

. ./config.txt

eval "cd \"${INDIR}\""

if [ ${SINGLESITE} == "Y" ]
then

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
eval "date"
echo ""
echo "___${PROC_DIR}]___"
echo ""
eval "cd \"${APPDIR}\\bin\""

eval "./Sites.sh ${ONE_SITE}"

else

IFS="$(printf '\n\t')"
for PROC_DIR in `ls`
do

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
eval "date"
echo ""
echo "___${PROC_DIR}]___"
echo ""
eval "cd \"${APPDIR}\\bin\""

eval "./Sites.sh \"${PROC_DIR}\""

done
unset IFS

echo ""
echo ""
echo "I am done processing the directories."
echo ""

fi

echo "Press enter to continue..."
read ans