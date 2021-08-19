SRC_FILES=`ls -1 lib/src`
for file in $SRC_FILES
do
mv "lib/src/${file}" "lib/${file}"
done
dartdoc --output docs
for file in $SRC_FILES
do
mv "lib/${file}" "lib/src/${file}"
done