#!/bin/sh

if [ $# != 1 ]
then
   echo 'Usage: convert_cert_to_android.sh [name of cert file]'
   exit -1
fi
CERT_FILE_INPUT=$1
if [ ! -f $1 ]
then
   echo "Cannot find file $1"
   exit -1
fi

# Gets the filename that is used in Android and adds a .0 on the end
OUTPUT_FILENAME="`openssl x509 -inform DER -subject_hash -in ${CERT_FILE_INPUT} |head  -1`.0"
openssl x509 -inform DER -subject_hash -in ${CERT_FILE_INPUT} |tail +2 > ${OUTPUT_FILENAME}
# Find the line number where BEGIN CERT appears
LINENUMBER=`openssl x509 -inform DER -text -in ${CERT_FILE_INPUT} |grep -n 'BEGIN CERT' | cut -d ':' -f 1`
(( LINENUMBER = LINENUMBER - 1 ))
# Now take that information and remove the subject hash on the end
openssl x509 -inform DER -text -in ${CERT_FILE_INPUT}  | head -${LINENUMBER} >> ${OUTPUT_FILENAME}

# Show the output of the work
cat ${OUTPUT_FILENAME}

echo "Created file under ${OUTPUT_FILENAME}.  Now remount /system and use adb to push this file to /system/etc/security/cacerts"
