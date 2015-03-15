#!/bin/bash
#DM*201412230Running after install_GoldenDictPortable.sh

#Specific alias Windows PortableApps registry
programName="7zip"
winProgramName="7-ZipPortable"
wineStartCommand="wine start 'C:\PortableApps\7-ZipPortable\7-ZipPortable.exe'"

#Common for all alias Windows PortableApps registry
aliasFileLog="/start$winProgramName.log.txt"
portableAppsDirectory=~/.wine/drive_c/PortableApps
targetDirectory=$portableAppsDirectory/$winProgramName
targetFilePath=$targetDirectory/$winProgramName.exe
function addBashAliases()
{
  echo alias $programName=$'"'$wineStartCommand' > '$targetDirectory''$aliasFileLog' 2>&1"' >> ~/.bash_aliases
}

#Common for all alias Windows PortableApps script
if [ -f $targetFilePath ];
  then
    #Rights for all users if you choose to use other than root
    chmod 777 $targetDirectory/*.exe
    if [ -x $targetFilePath ];
      then
        #Unalias if present
        if [ -n "$(grep "$programName" ~/.bash_aliases)" ];
          then
            sed -i '/^alias '$programName'/d' ~/.bash_aliases
            echo "Previous version of $programName alias deleted."
        fi
        #Alias
        addBashAliases
        `source ~/.bashrc`
        echo "Ready to launch with new $programName alias. If not able on your session, please type : source ~/.bashrc"
    fi
  else
    echo "Failed to find $targetFilePath"
fi
