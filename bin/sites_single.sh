#/usr/bin


. ./config.txt

TMPFILE="${APPDIR}\tmp.out"

TMPL="${APPDIR}\AppSections"


eval "cd \"${INDIR}\""
#for SITE_NAME in `IFS="$(printf '\n\t')" ; ls; unset IFS `; 
#do 

#----------------------------------------------------------------------------------------------
SITE_NAME="BS 81399 Hayfields centre"
#----------------------------------------------------------------------------------------------
#SITE_NAME="$1"

VERT="${INDIR}\\${SITE_NAME}"


eval "cd \"${VERT}\Fotos\""

CT_NAME=`ls | grep -i contain `
FS_NAME=`ls | grep -i full `
Z1_NAME=`ls | grep -i zoom | grep 1$`
Z2_NAME=`ls | grep -i zoom | grep 2$`
Z3_NAME=`ls | grep -i zoom | grep 3$`
Z4_NAME=`ls | grep -i zoom | grep 4$`
Z5_NAME=`ls | grep -i zoom | grep 5$`
Z6_NAME=`ls | grep -i zoom | grep 6$`


INCT="${VERT}\Fotos\\${CT_NAME}"
INFS="${VERT}\Fotos\\${FS_NAME}"
INZ1="${VERT}\Fotos\\${Z1_NAME}"
INZ2="${VERT}\Fotos\\${Z2_NAME}"
INZ3="${VERT}\Fotos\\${Z3_NAME}"
INZ4="${VERT}\Fotos\\${Z4_NAME}"
INZ5="${VERT}\Fotos\\${Z5_NAME}"
INZ6="${VERT}\Fotos\\${Z6_NAME}"

NUMCON=`ls | grep -ic contain | sed 's/ //g'`

echo ""
echo ""
echo "Will process [${VERT}]"
echo ""
echo ""

eval "cd \"${VERT}\""
HAVDONE=`ls | grep -ic section | sed 's/ //g'`

if [ ${HAVDONE} -ge 1 ]
then

echo "Site [${VERT}] already fixed..."
echo ""
echo ""

else

echo "Fixing Site [${VERT}] ..."

eval "cd \"${VERT}\Fotos\""
CONTAIN_ZOOM=`ls | grep -ic zoom`

if [ ${CONTAIN_ZOOM} -eq 0 ]
then

echo "The folders is not yet fixed in ${VERT} !!!"
echo ""
echo "Fix folders and try again."
echo ""

else

MAXZOOM=`ls | grep -i zoom | sed 's/ //g' | tr A-Z a-z | sort -r | head -1`

NUMSEC=`echo ${MAXZOOM} | sed 's/zoom//g'` 

eval "cd \"${APPDIR}\""

SRCDIR=`ls ${TMPL} | grep ${NUMSEC}`

echo "Will use [${SRCDIR}] for this site..."

eval "cd \"${TMPL}\""

eval "cp -R \"${SRCDIR}\" \"${VERT}\""


#-----------------------------------------------------------------------------------------------------------------------------#

echo "Processing: [Full site]..."
FULL_SITE="${VERT}\\${SRCDIR}\\Resources\Images\01. Full_Site"
eval "cd \"${INFS}\""
eval "cp *.jpg \"${FULL_SITE}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${FULL_SITE}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  eval "mv \"${FLE}\" Full_Site${SEQ: -4}.jpg"
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."
eval "cat \"${VERT}\\${SRCDIR}\01. Full_Site.html\" | sed 's/<h3>.\+<\/h3>/<h3>${SITE_NAME}<\/h3>/g;s/0032/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\01. Full_Site.html"

#-----------------------------------------------------------------------------------------------------------------------------#
echo "Processing: [Container]..."

if [ ${NUMCON} -eq 1 ]
then

CON_SITE="${VERT}\\${SRCDIR}\\Resources\Images\02. Container_Site"

eval "cd \"${INCT}\""
eval "cp *.jpg \"${CON_SITE}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${CON_SITE}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  eval "mv \"${FLE}\" Container_Site${SEQ: -4}.jpg"
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."
eval "cat \"${VERT}\\${SRCDIR}\02. Container_Site.html\" | sed 's/0016/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\02. Container_Site.html"


# end if for -> [ ${NUMCON} -eq 1 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 1 ]
then

# ZOOM_1_="${VERT}\\${SRCDIR}\\Resources\Images\03. Zoom_1"
# ZOOM_10="${VERT}\\${SRCDIR}\\Resources\Images\03. Zoom_1\01. Zoom_1"
# ZOOM_1A="${VERT}\\${SRCDIR}\\Resources\Images\03. Zoom_1\02. Zoom_1.A"
# ZOOM_1B="${VERT}\\${SRCDIR}\\Resources\Images\03. Zoom_1\03. Zoom_1.B"
# ZOOM_1C="${VERT}\\${SRCDIR}\\Resources\Images\03. Zoom_1\04. Zoom_1.C"

# convert input -crop WxH+X+Y +repage output
# convert -crop 2445x1376+688+0 Zoom_1_0000.jpg Zoom_1a_0000.jpg
# convert -crop 2213x1245+785+474 Zoom_1_0000.jpg Zoom_1b_0000.jpg
# convert -crop 2093x1177+833+983 Zoom_1_0000.jpg Zoom_1c_0000.jpg


echo "Processing: [Zoom1]..."
ZOOM_10="${VERT}\\${SRCDIR}\\Resources\Images\03. Zoom_1\01. Zoom_1"
ZOOM_1A="${VERT}\\${SRCDIR}\\Resources\Images\03. Zoom_1\02. Zoom_1.A"
ZOOM_1B="${VERT}\\${SRCDIR}\\Resources\Images\03. Zoom_1\03. Zoom_1.B"
ZOOM_1C="${VERT}\\${SRCDIR}\\Resources\Images\03. Zoom_1\04. Zoom_1.C"

eval "cd \"${INZ1}\""
eval "cp *.jpg \"${ZOOM_10}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_10}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_1_${SEQ: -4}.jpg"
  
  eval "convert Zoom_1_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_1A}\Zoom_1.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_1_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_1B}\Zoom_1.B_${SEQ: -4}.jpg\""

  eval "convert Zoom_1_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_1C}\Zoom_1.C_${SEQ: -4}.jpg\""

  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\03. Zoom_1.html\" | sed 's/0028/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\03. Zoom_1.html"

eval "cat \"${VERT}\\${SRCDIR}\09. Zoom_1.A.html\" | sed 's/0028/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\09. Zoom_1.A.html"

eval "cat \"${VERT}\\${SRCDIR}\10. Zoom_1.B.html\" | sed 's/0028/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\10. Zoom_1.B.html"

eval "cat \"${VERT}\\${SRCDIR}\11. Zoom_1.C.html\" | sed 's/0028/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\11. Zoom_1.C.html"


# end if for -> [ ${NUMSEC} -ge 1 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 2 ]
then

# ZOOM_2_="${VERT}\\${SRCDIR}\\Resources\Images\04. Zoom_2"
# ZOOM_20="${VERT}\\${SRCDIR}\\Resources\Images\04. Zoom_2\01. Zoom_2"
# ZOOM_2A="${VERT}\\${SRCDIR}\\Resources\Images\04. Zoom_2\02. Zoom_2.A"
# ZOOM_2B="${VERT}\\${SRCDIR}\\Resources\Images\04. Zoom_2\03. Zoom_2.B"
# ZOOM_2C="${VERT}\\${SRCDIR}\\Resources\Images\04. Zoom_2\04. Zoom_2.C"

echo "Processing: [Zoom2]..."

ZOOM_20="${VERT}\\${SRCDIR}\\Resources\Images\04. Zoom_2\01. Zoom_2"
ZOOM_2A="${VERT}\\${SRCDIR}\\Resources\Images\04. Zoom_2\02. Zoom_2.A"
ZOOM_2B="${VERT}\\${SRCDIR}\\Resources\Images\04. Zoom_2\03. Zoom_2.B"
ZOOM_2C="${VERT}\\${SRCDIR}\\Resources\Images\04. Zoom_2\04. Zoom_2.C"

eval "cd \"${INZ2}\""
eval "cp *.jpg \"${ZOOM_20}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_20}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}

  eval "mv \"${FLE}\" Zoom_2_${SEQ: -4}.jpg"
  
  eval "convert Zoom_2_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_2A}\Zoom_2.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_2_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_2B}\Zoom_2.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_2_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_2C}\Zoom_2.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\04. Zoom_2.html\" | sed 's/0027/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\04. Zoom_2.html"

eval "cat \"${VERT}\\${SRCDIR}\12. Zoom_2.A.html\" | sed 's/0027/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\12. Zoom_2.A.html"

eval "cat \"${VERT}\\${SRCDIR}\13. Zoom_2.B.html\" | sed 's/0027/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\13. Zoom_2.B.html"

eval "cat \"${VERT}\\${SRCDIR}\14. Zoom_2.C.html\" | sed 's/0027/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\14. Zoom_2.C.html"


# end if for -> [ ${NUMSEC} -ge 2 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 3 ]
then

# ZOOM_3_="${VERT}\\${SRCDIR}\\Resources\Images\05. Zoom_3"
# ZOOM_30="${VERT}\\${SRCDIR}\\Resources\Images\05. Zoom_3\01. Zoom_3"
# ZOOM_3A="${VERT}\\${SRCDIR}\\Resources\Images\05. Zoom_3\02. Zoom_3.A"
# ZOOM_3B="${VERT}\\${SRCDIR}\\Resources\Images\05. Zoom_3\03. Zoom_3.B"
# ZOOM_3C="${VERT}\\${SRCDIR}\\Resources\Images\05. Zoom_3\04. Zoom_3.C"

echo "Processing: [Zoom3]..."

ZOOM_30="${VERT}\\${SRCDIR}\\Resources\Images\05. Zoom_3\01. Zoom_3"
ZOOM_3A="${VERT}\\${SRCDIR}\\Resources\Images\05. Zoom_3\02. Zoom_3.A"
ZOOM_3B="${VERT}\\${SRCDIR}\\Resources\Images\05. Zoom_3\03. Zoom_3.B"
ZOOM_3C="${VERT}\\${SRCDIR}\\Resources\Images\05. Zoom_3\04. Zoom_3.C"

eval "cd \"${INZ3}\""
eval "cp *.jpg \"${ZOOM_30}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_30}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_3_${SEQ: -4}.jpg"
  
  eval "convert Zoom_3_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_3A}\Zoom_3.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_3_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_3B}\Zoom_3.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_3_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_3C}\Zoom_3.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\05. Zoom_3.html\" | sed 's/0027/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\05. Zoom_3.html"

eval "cat \"${VERT}\\${SRCDIR}\15. Zoom_3.A.html\" | sed 's/0027/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\15. Zoom_3.A.html"

eval "cat \"${VERT}\\${SRCDIR}\16. Zoom_3.B.html\" | sed 's/0027/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\16. Zoom_3.B.html"

eval "cat \"${VERT}\\${SRCDIR}\17. Zoom_3.C.html\" | sed 's/0027/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\17. Zoom_3.C.html"


# end if for -> [ ${NUMSEC} -ge 3 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#
if [ ${NUMSEC} -ge 4 ]
then


# ZOOM_4_="${VERT}\\${SRCDIR}\\Resources\Images\06. Zoom_4"
# ZOOM_40="${VERT}\\${SRCDIR}\\Resources\Images\06. Zoom_4\01. Zoom_4"
# ZOOM_4A="${VERT}\\${SRCDIR}\\Resources\Images\06. Zoom_4\02. Zoom_4.A"
# ZOOM_4B="${VERT}\\${SRCDIR}\\Resources\Images\06. Zoom_4\03. Zoom_4.B"
# ZOOM_4C="${VERT}\\${SRCDIR}\\Resources\Images\06. Zoom_4\04. Zoom_4.C"

echo "Processing: [Zoom4]..."

ZOOM_40="${VERT}\\${SRCDIR}\\Resources\Images\06. Zoom_4\01. Zoom_4"
ZOOM_4A="${VERT}\\${SRCDIR}\\Resources\Images\06. Zoom_4\02. Zoom_4.A"
ZOOM_4B="${VERT}\\${SRCDIR}\\Resources\Images\06. Zoom_4\03. Zoom_4.B"
ZOOM_4C="${VERT}\\${SRCDIR}\\Resources\Images\06. Zoom_4\04. Zoom_4.C"


eval "cd \"${INZ4}\""
eval "cp *.jpg \"${ZOOM_40}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_40}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_4_${SEQ: -4}.jpg"
  
  eval "convert Zoom_4_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_4A}\Zoom_4.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_4_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_4B}\Zoom_4.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_4_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_4C}\Zoom_4.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\06. Zoom_4.html\" | sed 's/0022/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\06. Zoom_4.html"

eval "cat \"${VERT}\\${SRCDIR}\17. Zoom_4.A.html\" | sed 's/0022/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\17. Zoom_4.A.html"

eval "cat \"${VERT}\\${SRCDIR}\18. Zoom_4.B.html\" | sed 's/0022/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\18. Zoom_4.B.html"

eval "cat \"${VERT}\\${SRCDIR}\19. Zoom_4.C.html\" | sed 's/0022/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\19. Zoom_4.C.html"


# end if for -> [ ${NUMSEC} -ge 4 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 5 ]
then

# ZOOM_5_="${VERT}\\${SRCDIR}\\Resources\Images\07. Zoom_5"
# ZOOM_50="${VERT}\\${SRCDIR}\\Resources\Images\07. Zoom_5\01. Zoom_5"
# ZOOM_5A="${VERT}\\${SRCDIR}\\Resources\Images\07. Zoom_5\02. Zoom_5.A"
# ZOOM_5B="${VERT}\\${SRCDIR}\\Resources\Images\07. Zoom_5\03. Zoom_5.B"
# ZOOM_5C="${VERT}\\${SRCDIR}\\Resources\Images\07. Zoom_5\04. Zoom_5.C"

echo "Processing: [Zoom5]..."

ZOOM_50="${VERT}\\${SRCDIR}\\Resources\Images\07. Zoom_5\01. Zoom_5"
ZOOM_5A="${VERT}\\${SRCDIR}\\Resources\Images\07. Zoom_5\02. Zoom_5.A"
ZOOM_5B="${VERT}\\${SRCDIR}\\Resources\Images\07. Zoom_5\03. Zoom_5.B"
ZOOM_5C="${VERT}\\${SRCDIR}\\Resources\Images\07. Zoom_5\04. Zoom_5.C"


eval "cd \"${INZ5}\""
eval "cp *.jpg \"${ZOOM_50}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_50}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_5_${SEQ: -4}.jpg"
  
  eval "convert Zoom_5_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_5A}\Zoom_5.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_5_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_5B}\Zoom_5.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_5_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_5C}\Zoom_5.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\07. Zoom_5.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\07. Zoom_5.html"

eval "cat \"${VERT}\\${SRCDIR}\20. Zoom_5.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\20. Zoom_5.A.html"

eval "cat \"${VERT}\\${SRCDIR}\21. Zoom_5.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\21. Zoom_5.B.html"

eval "cat \"${VERT}\\${SRCDIR}\22. Zoom_5.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\22. Zoom_5.C.html"


# end if for -> [ ${NUMSEC} -ge 5 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 6 ]
then

# ZOOM_6_="${VERT}\\${SRCDIR}\\Resources\Images\08. Zoom_6"
# ZOOM_60="${VERT}\\${SRCDIR}\\Resources\Images\08. Zoom_6\01. Zoom_6"
# ZOOM_6A="${VERT}\\${SRCDIR}\\Resources\Images\08. Zoom_6\02. Zoom_6.A"
# ZOOM_6B="${VERT}\\${SRCDIR}\\Resources\Images\08. Zoom_6\03. Zoom_6.B"
# ZOOM_6C="${VERT}\\${SRCDIR}\\Resources\Images\08. Zoom_6\04. Zoom_6.C"

echo "Processing: [Zoom6]..."

ZOOM_60="${VERT}\\${SRCDIR}\\Resources\Images\08. Zoom_6\01. Zoom_6"
ZOOM_6A="${VERT}\\${SRCDIR}\\Resources\Images\08. Zoom_6\02. Zoom_6.A"
ZOOM_6B="${VERT}\\${SRCDIR}\\Resources\Images\08. Zoom_6\03. Zoom_6.B"
ZOOM_6C="${VERT}\\${SRCDIR}\\Resources\Images\08. Zoom_6\04. Zoom_6.C"

eval "cd \"${INZ6}\""
eval "cp *.jpg \"${ZOOM_60}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_60}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_6_${SEQ: -4}.jpg"
  
  eval "convert Zoom_6_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_6A}\Zoom_6.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_6_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_6B}\Zoom_6.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_6_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_6C}\Zoom_6.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\08. Zoom_6.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\08. Zoom_6.html"

eval "cat \"${VERT}\\${SRCDIR}\23. Zoom_6.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\23. Zoom_6.A.html"

eval "cat \"${VERT}\\${SRCDIR}\24. Zoom_6.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\24. Zoom_6.B.html"

eval "cat \"${VERT}\\${SRCDIR}\25. Zoom_6.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\25. Zoom_6.C.html"


# end if for -> [ ${NUMSEC} -ge 6 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 7 ]
then

# ZOOM_7_="${VERT}\\${SRCDIR}\\Resources\Images\09. Zoom_7"
# ZOOM_70="${VERT}\\${SRCDIR}\\Resources\Images\09. Zoom_7\01. Zoom_7"
# ZOOM_7A="${VERT}\\${SRCDIR}\\Resources\Images\09. Zoom_7\02. Zoom_7.A"
# ZOOM_7B="${VERT}\\${SRCDIR}\\Resources\Images\09. Zoom_7\03. Zoom_7.B"
# ZOOM_7C="${VERT}\\${SRCDIR}\\Resources\Images\09. Zoom_7\04. Zoom_7.C"

echo "Processing: [Zoom7]..."

ZOOM_70="${VERT}\\${SRCDIR}\\Resources\Images\09. Zoom_7\01. Zoom_7"
ZOOM_7A="${VERT}\\${SRCDIR}\\Resources\Images\09. Zoom_7\02. Zoom_7.A"
ZOOM_7B="${VERT}\\${SRCDIR}\\Resources\Images\09. Zoom_7\03. Zoom_7.B"
ZOOM_7C="${VERT}\\${SRCDIR}\\Resources\Images\09. Zoom_7\04. Zoom_7.C"

eval "cd \"${INZ7}\""
eval "cp *.jpg \"${ZOOM_70}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_70}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_7_${SEQ: -4}.jpg"
  
  eval "convert Zoom_7_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_7A}\Zoom_7.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_7_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_7B}\Zoom_7.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_7_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_7C}\Zoom_7.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\26. Zoom_7.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\26. Zoom_7.html"

eval "cat \"${VERT}\\${SRCDIR}\27. Zoom_7.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\27. Zoom_7.A.html"

eval "cat \"${VERT}\\${SRCDIR}\28. Zoom_7.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\28. Zoom_7.B.html"

eval "cat \"${VERT}\\${SRCDIR}\29. Zoom_7.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\29. Zoom_7.C.html"


# end if for -> [ ${NUMSEC} -ge 7 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 8 ]
then

# ZOOM_8_="${VERT}\\${SRCDIR}\\Resources\Images\10. Zoom_8"
# ZOOM_80="${VERT}\\${SRCDIR}\\Resources\Images\10. Zoom_8\01. Zoom_8"
# ZOOM_8A="${VERT}\\${SRCDIR}\\Resources\Images\10. Zoom_8\02. Zoom_8.A"
# ZOOM_8B="${VERT}\\${SRCDIR}\\Resources\Images\10. Zoom_8\03. Zoom_8.B"
# ZOOM_8C="${VERT}\\${SRCDIR}\\Resources\Images\10. Zoom_8\04. Zoom_8.C"

echo "Processing: [Zoom8]..."

ZOOM_80="${VERT}\\${SRCDIR}\\Resources\Images\10. Zoom_8\01. Zoom_8"
ZOOM_8A="${VERT}\\${SRCDIR}\\Resources\Images\10. Zoom_8\02. Zoom_8.A"
ZOOM_8B="${VERT}\\${SRCDIR}\\Resources\Images\10. Zoom_8\03. Zoom_8.B"
ZOOM_8C="${VERT}\\${SRCDIR}\\Resources\Images\10. Zoom_8\04. Zoom_8.C"

eval "cd \"${INZ8}\""
eval "cp *.jpg \"${ZOOM_80}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_80}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_8_${SEQ: -4}.jpg"
  
  eval "convert Zoom_8_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_8A}\Zoom_8.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_8_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_8B}\Zoom_8.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_8_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_8C}\Zoom_8.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\30. Zoom_8.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\30. Zoom_8.html"

eval "cat \"${VERT}\\${SRCDIR}\31. Zoom_8.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\31. Zoom_8.A.html"

eval "cat \"${VERT}\\${SRCDIR}\32. Zoom_8.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\32. Zoom_8.B.html"

eval "cat \"${VERT}\\${SRCDIR}\33. Zoom_8.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\33. Zoom_8.C.html"


# end if for -> [ ${NUMSEC} -ge 8 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 9 ]
then

# ZOOM_9_="${VERT}\\${SRCDIR}\\Resources\Images\11. Zoom_9"
# ZOOM_90="${VERT}\\${SRCDIR}\\Resources\Images\11. Zoom_9\01. Zoom_9"
# ZOOM_9A="${VERT}\\${SRCDIR}\\Resources\Images\11. Zoom_9\02. Zoom_9.A"
# ZOOM_9B="${VERT}\\${SRCDIR}\\Resources\Images\11. Zoom_9\03. Zoom_9.B"
# ZOOM_9C="${VERT}\\${SRCDIR}\\Resources\Images\11. Zoom_9\04. Zoom_9.C"

echo "Processing: [Zoom9]..."

ZOOM_90="${VERT}\\${SRCDIR}\\Resources\Images\11. Zoom_9\01. Zoom_9"
ZOOM_9A="${VERT}\\${SRCDIR}\\Resources\Images\11. Zoom_9\02. Zoom_9.A"
ZOOM_9B="${VERT}\\${SRCDIR}\\Resources\Images\11. Zoom_9\03. Zoom_9.B"
ZOOM_9C="${VERT}\\${SRCDIR}\\Resources\Images\11. Zoom_9\04. Zoom_9.C"

eval "cd \"${INZ9}\""
eval "cp *.jpg \"${ZOOM_90}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_90}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_9_${SEQ: -4}.jpg"
  
  eval "convert Zoom_9_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_9A}\Zoom_9.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_9_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_9B}\Zoom_9.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_9_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_9C}\Zoom_9.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\34. Zoom_9.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\34. Zoom_9.html"

eval "cat \"${VERT}\\${SRCDIR}\35. Zoom_9.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\35. Zoom_9.A.html"

eval "cat \"${VERT}\\${SRCDIR}\36. Zoom_9.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\36. Zoom_9.B.html"

eval "cat \"${VERT}\\${SRCDIR}\37. Zoom_9.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\37. Zoom_9.C.html"


# end if for -> [ ${NUMSEC} -ge 9 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 10 ]
then

# ZOOM_10_="${VERT}\\${SRCDIR}\\Resources\Images\12. Zoom_10"
# ZOOM_100="${VERT}\\${SRCDIR}\\Resources\Images\12. Zoom_10\01. Zoom_10"
# ZOOM_10A="${VERT}\\${SRCDIR}\\Resources\Images\12. Zoom_10\02. Zoom_10.A"
# ZOOM_10B="${VERT}\\${SRCDIR}\\Resources\Images\12. Zoom_10\03. Zoom_10.B"
# ZOOM_10C="${VERT}\\${SRCDIR}\\Resources\Images\12. Zoom_10\04. Zoom_10.C"

echo "Processing: [Zoom10]..."

ZOOM_100="${VERT}\\${SRCDIR}\\Resources\Images\12. Zoom_10\01. Zoom_10"
ZOOM_10A="${VERT}\\${SRCDIR}\\Resources\Images\12. Zoom_10\02. Zoom_10.A"
ZOOM_10B="${VERT}\\${SRCDIR}\\Resources\Images\12. Zoom_10\03. Zoom_10.B"
ZOOM_10C="${VERT}\\${SRCDIR}\\Resources\Images\12. Zoom_10\04. Zoom_10.C"

eval "cd \"${INZ10}\""
eval "cp *.jpg \"${ZOOM_100}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_100}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_10_${SEQ: -4}.jpg"
  
  eval "convert Zoom_10_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_10A}\Zoom_10.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_10_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_10B}\Zoom_10.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_10_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_10C}\Zoom_10.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\38. Zoom_10.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\38. Zoom_10.html"

eval "cat \"${VERT}\\${SRCDIR}\39. Zoom_10.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\39. Zoom_10.A.html"

eval "cat \"${VERT}\\${SRCDIR}\40. Zoom_10.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\40. Zoom_10.B.html"

eval "cat \"${VERT}\\${SRCDIR}\41. Zoom_10.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\41. Zoom_10.C.html"


# end if for -> [ ${NUMSEC} -ge 10 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 11 ]
then

# ZOOM_11_="${VERT}\\${SRCDIR}\\Resources\Images\13. Zoom_11"
# ZOOM_110="${VERT}\\${SRCDIR}\\Resources\Images\13. Zoom_11\01. Zoom_11"
# ZOOM_11A="${VERT}\\${SRCDIR}\\Resources\Images\13. Zoom_11\02. Zoom_11.A"
# ZOOM_11B="${VERT}\\${SRCDIR}\\Resources\Images\13. Zoom_11\03. Zoom_11.B"
# ZOOM_11C="${VERT}\\${SRCDIR}\\Resources\Images\13. Zoom_11\04. Zoom_11.C"

echo "Processing: [Zoom11]..."

ZOOM_110="${VERT}\\${SRCDIR}\\Resources\Images\13. Zoom_11\01. Zoom_11"
ZOOM_11A="${VERT}\\${SRCDIR}\\Resources\Images\13. Zoom_11\02. Zoom_11.A"
ZOOM_11B="${VERT}\\${SRCDIR}\\Resources\Images\13. Zoom_11\03. Zoom_11.B"
ZOOM_11C="${VERT}\\${SRCDIR}\\Resources\Images\13. Zoom_11\04. Zoom_11.C"

eval "cd \"${INZ11}\""
eval "cp *.jpg \"${ZOOM_110}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_110}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_11_${SEQ: -4}.jpg"
  
  eval "convert Zoom_11_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_11A}\Zoom_11.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_11_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_11B}\Zoom_11.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_11_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_11C}\Zoom_11.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\42. Zoom_11.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\42. Zoom_11.html"

eval "cat \"${VERT}\\${SRCDIR}\43. Zoom_11.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\43. Zoom_11.A.html"

eval "cat \"${VERT}\\${SRCDIR}\44. Zoom_11.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\44. Zoom_11.B.html"

eval "cat \"${VERT}\\${SRCDIR}\45. Zoom_11.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\45. Zoom_11.C.html"


# end if for -> [ ${NUMSEC} -ge 11 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 12 ]
then

# ZOOM_12_="${VERT}\\${SRCDIR}\\Resources\Images\14. Zoom_12"
# ZOOM_120="${VERT}\\${SRCDIR}\\Resources\Images\14. Zoom_12\01. Zoom_12"
# ZOOM_12A="${VERT}\\${SRCDIR}\\Resources\Images\14. Zoom_12\02. Zoom_12.A"
# ZOOM_12B="${VERT}\\${SRCDIR}\\Resources\Images\14. Zoom_12\03. Zoom_12.B"
# ZOOM_12C="${VERT}\\${SRCDIR}\\Resources\Images\14. Zoom_12\04. Zoom_12.C"

echo "Processing: [Zoom12]..."

ZOOM_120="${VERT}\\${SRCDIR}\\Resources\Images\14. Zoom_12\01. Zoom_12"
ZOOM_12A="${VERT}\\${SRCDIR}\\Resources\Images\14. Zoom_12\02. Zoom_12.A"
ZOOM_12B="${VERT}\\${SRCDIR}\\Resources\Images\14. Zoom_12\03. Zoom_12.B"
ZOOM_12C="${VERT}\\${SRCDIR}\\Resources\Images\14. Zoom_12\04. Zoom_12.C"

eval "cd \"${INZ12}\""
eval "cp *.jpg \"${ZOOM_120}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_120}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_12_${SEQ: -4}.jpg"
  
  eval "convert Zoom_12_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_12A}\Zoom_12.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_12_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_12B}\Zoom_12.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_12_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_12C}\Zoom_12.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\46. Zoom_12.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\46. Zoom_12.html"

eval "cat \"${VERT}\\${SRCDIR}\47. Zoom_12.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\47. Zoom_12.A.html"

eval "cat \"${VERT}\\${SRCDIR}\48. Zoom_12.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\48. Zoom_12.B.html"

eval "cat \"${VERT}\\${SRCDIR}\49. Zoom_12.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\49. Zoom_12.C.html"


# end if for -> [ ${NUMSEC} -ge 12 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 13 ]
then

# ZOOM_13_="${VERT}\\${SRCDIR}\\Resources\Images\15. Zoom_13"
# ZOOM_130="${VERT}\\${SRCDIR}\\Resources\Images\15. Zoom_13\01. Zoom_13"
# ZOOM_13A="${VERT}\\${SRCDIR}\\Resources\Images\15. Zoom_13\02. Zoom_13.A"
# ZOOM_13B="${VERT}\\${SRCDIR}\\Resources\Images\15. Zoom_13\03. Zoom_13.B"
# ZOOM_13C="${VERT}\\${SRCDIR}\\Resources\Images\15. Zoom_13\04. Zoom_13.C"

echo "Processing: [Zoom13]..."

ZOOM_130="${VERT}\\${SRCDIR}\\Resources\Images\15. Zoom_13\01. Zoom_13"
ZOOM_13A="${VERT}\\${SRCDIR}\\Resources\Images\15. Zoom_13\02. Zoom_13.A"
ZOOM_13B="${VERT}\\${SRCDIR}\\Resources\Images\15. Zoom_13\03. Zoom_13.B"
ZOOM_13C="${VERT}\\${SRCDIR}\\Resources\Images\15. Zoom_13\04. Zoom_13.C"

eval "cd \"${INZ13}\""
eval "cp *.jpg \"${ZOOM_130}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_130}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_13_${SEQ: -4}.jpg"
  
  eval "convert Zoom_13_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_13A}\Zoom_13.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_13_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_13B}\Zoom_13.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_13_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_13C}\Zoom_13.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\50. Zoom_13.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\50. Zoom_13.html"

eval "cat \"${VERT}\\${SRCDIR}\51. Zoom_13.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\51. Zoom_13.A.html"

eval "cat \"${VERT}\\${SRCDIR}\52. Zoom_13.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\52. Zoom_13.B.html"

eval "cat \"${VERT}\\${SRCDIR}\53. Zoom_13.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\53. Zoom_13.C.html"


# end if for -> [ ${NUMSEC} -ge 13 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 14 ]
then

# ZOOM_14_="${VERT}\\${SRCDIR}\\Resources\Images\16. Zoom_14"
# ZOOM_140="${VERT}\\${SRCDIR}\\Resources\Images\16. Zoom_14\01. Zoom_14"
# ZOOM_14A="${VERT}\\${SRCDIR}\\Resources\Images\16. Zoom_14\02. Zoom_14.A"
# ZOOM_14B="${VERT}\\${SRCDIR}\\Resources\Images\16. Zoom_14\03. Zoom_14.B"
# ZOOM_14C="${VERT}\\${SRCDIR}\\Resources\Images\16. Zoom_14\04. Zoom_14.C"

echo "Processing: [Zoom14]..."

ZOOM_140="${VERT}\\${SRCDIR}\\Resources\Images\16. Zoom_14\01. Zoom_14"
ZOOM_14A="${VERT}\\${SRCDIR}\\Resources\Images\16. Zoom_14\02. Zoom_14.A"
ZOOM_14B="${VERT}\\${SRCDIR}\\Resources\Images\16. Zoom_14\03. Zoom_14.B"
ZOOM_14C="${VERT}\\${SRCDIR}\\Resources\Images\16. Zoom_14\04. Zoom_14.C"

eval "cd \"${INZ14}\""
eval "cp *.jpg \"${ZOOM_140}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_140}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_14_${SEQ: -4}.jpg"
  
  eval "convert Zoom_14_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_14A}\Zoom_14.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_14_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_14B}\Zoom_14.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_14_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_14C}\Zoom_14.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\54. Zoom_14.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\54. Zoom_14.html"

eval "cat \"${VERT}\\${SRCDIR}\55. Zoom_14.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\55. Zoom_14.A.html"

eval "cat \"${VERT}\\${SRCDIR}\56. Zoom_14.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\56. Zoom_14.B.html"

eval "cat \"${VERT}\\${SRCDIR}\57. Zoom_14.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\57. Zoom_14.C.html"


# end if for -> [ ${NUMSEC} -ge 14 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#

if [ ${NUMSEC} -ge 15 ]
then

# ZOOM_15_="${VERT}\\${SRCDIR}\\Resources\Images\17. Zoom_15"
# ZOOM_150="${VERT}\\${SRCDIR}\\Resources\Images\17. Zoom_15\01. Zoom_15"
# ZOOM_15A="${VERT}\\${SRCDIR}\\Resources\Images\17. Zoom_15\02. Zoom_15.A"
# ZOOM_15B="${VERT}\\${SRCDIR}\\Resources\Images\17. Zoom_15\03. Zoom_15.B"
# ZOOM_15C="${VERT}\\${SRCDIR}\\Resources\Images\17. Zoom_15\04. Zoom_15.C"

echo "Processing: [Zoom15]..."

ZOOM_150="${VERT}\\${SRCDIR}\\Resources\Images\17. Zoom_15\01. Zoom_15"
ZOOM_15A="${VERT}\\${SRCDIR}\\Resources\Images\17. Zoom_15\02. Zoom_15.A"
ZOOM_15B="${VERT}\\${SRCDIR}\\Resources\Images\17. Zoom_15\03. Zoom_15.B"
ZOOM_15C="${VERT}\\${SRCDIR}\\Resources\Images\17. Zoom_15\04. Zoom_15.C"

eval "cd \"${INZ15}\""
eval "cp *.jpg \"${ZOOM_150}\""

echo "Renaming the files..."
IFS="$(printf '\n\t')"
STRT=0
eval "cd \"${ZOOM_150}\""
for FLE in `ls | sort`
do
  #echo ${FLE}
  SEQ='0000'${STRT}
  
  eval "mv \"${FLE}\" Zoom_15_${SEQ: -4}.jpg"
  
  eval "convert Zoom_15_${SEQ: -4}.jpg -crop 2445x1376+688+0 +repage \"${ZOOM_15A}\Zoom_15.A_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_15_${SEQ: -4}.jpg -crop 2213x1245+785+474 +repage \"${ZOOM_15B}\Zoom_15.B_${SEQ: -4}.jpg\""
  
  eval "convert Zoom_15_${SEQ: -4}.jpg -crop 2093x1177+833+983 +repage \"${ZOOM_15C}\Zoom_15.C_${SEQ: -4}.jpg\""
  
  let STRT++
done
unset IFS

echo "Fixing the html file..."

eval "cat \"${VERT}\\${SRCDIR}\58. Zoom_15.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\58. Zoom_15.html"

eval "cat \"${VERT}\\${SRCDIR}\59. Zoom_15.A.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\59. Zoom_15.A.html"

eval "cat \"${VERT}\\${SRCDIR}\60. Zoom_15.B.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\60. Zoom_15.B.html"

eval "cat \"${VERT}\\${SRCDIR}\61. Zoom_15.C.html\" | sed 's/0019/${SEQ: -4}/g' " > c:\\tmp.out
mv c:\\tmp.out "${VERT}\\${SRCDIR}\61. Zoom_15.C.html"


# end if for -> [ ${NUMSEC} -ge 15 ]
fi

#-----------------------------------------------------------------------------------------------------------------------------#


#end if for -> [ ${CONTAIN_ZOOM} -eq 0 ]
fi

#end if for -> [ ${HAVDONE} -ge 1 ]
fi
#done

#read ans

