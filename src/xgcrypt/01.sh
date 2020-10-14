SELF=$0
DIR=$1
SRCSUFFIX=$2
DESTSUFFIX=$3

if [ $# -ne 3 ]; then
	echo "$SELF path,srcSuffix, destSuffix"
	exit 0
fi



if [ -d $DIR ]; then
   echo "$DIR is validate directory."
else
	echo "$DIR is invalidate directory."
	exit 0
fi

find $DIR -name *.$SRCSUFFIX |  while read i
do
  SRCNAME=$i
  echo "srcName is $SRCNAME";
  DESTNAME=${SRCNAME%.*}.$DESTSUFFIX
  echo "destName is $DESTNAME";
  mv $SRCNAME  $DESTNAME
done