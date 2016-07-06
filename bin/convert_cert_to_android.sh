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

OUTPUT_FILENAME="`openssl x509 -inform DER -subject_hash -in ${CERT_FILE_INPUT} |head  -1`.0"
openssl x509 -inform DER -subject_hash -in ${CERT_FILE_INPUT} |tail +2 > ${OUTPUT_FILENAME}
LINENUMBER=`openssl x509 -inform DER -text -in ${CERT_FILE_INPUT} |grep -n 'BEGIN CERT' | cut -d ':' -f 1`
(( LINENUMBER = LINENUMBER - 1 ))
openssl x509 -inform DER -text -in ${CERT_FILE_INPUT}  | head -${LINENUMBER} >> ${OUTPUT_FILENAME}

cat ${OUTPUT_FILENAME}

echo "Created file under ${OUTPUT_FILENAME}.  Now remount /system and use adb to push this file to /system/etc/security/cacerts"
