#!/bin/bash
#Common for all Windows PortableApps registry
targetDirectory='/root/Downloads'
downloadTargetFilePath=$targetDirectory'/index.html'
downloadTargetLog=$targetDirectory'/downloads.log'
ahrefLink=$targetDirectory'/index1.txt'
httpCompleteUrl=$targetDirectory'/index2.txt'
targetFilePath=$targetDirectory'/downloadsLinks.txt'
#Specific Windows PortableApps registry
downloadUrl='http://sourceforge.net/projects/portableapps/files/7-Zip%20Portable/'
downloadStartPattern='<a href="'$downloadUrl
downloadEndPattern='.paf.exe'
downloadSubstituteModel='s/\/download//'
function defaultValue()
{
  echo $downloadUrl'7-ZipPortable_9.20_Rev_3.paf.exe' > $targetFilePath
}
# Download process
rm /root/Downloads/ind* > /dev/null 2>&1
wget $downloadUrl -P $targetDirectory -o $downloadTargetLog
if [ -f $downloadTargetFilePath ];
  then
    cat $downloadTargetFilePath | grep "$downloadStartPattern" | grep "$downloadEndPattern" > $ahrefLink
  else
    echo "$downloadPattern not found. Download failed !"
    defaultValue
    exit
fi
if [ -f $ahrefLink ];
  then
    cut -d '"' -f 2 $ahrefLink > $httpCompleteUrl
  else
    echo "$ahrefLink not found. Download failed !"
    defaultValue
    exit
fi
if [ -f $httpCompleteUrl ];
  then
    sed $downloadSubstituteModel $httpCompleteUrl > $targetFilePath
  else
    echo "$httpCompleteUrl not found. Download failed !"
    defaultValue
    exit
fi
cat $targetFilePath | sed 1q
rm /root/Downloads/ind* > /dev/null 2>&1
