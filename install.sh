#!/bin/bash
#Downloads all the DAAL binaries necessary for daal-tk.
#Will install all the binaries to
#	$HOME/daal if local install is chosen 
#If maven is available on the path it will also install the daal-core jar to the local .m2 repository.

#This is not universal DAAL installation. The full DAAL install can be found here https://github.com/01org/daal/releases
INSTALL_DIR=$HOME/daal

DAAL_VERSION="2016.2.181"
DAAL_PACKAGE="https://github.com/trustedanalytics/daal-install/releases/download/v0.1.0-daal-2016.2.181/daal-2016.2.181.tar.gz"


TMP_DIR="/tmp/DAAL/$DAAL_VERSION"

#check for maven
if [ ! $(command -v mvn) != "" ]; then
	echo maven isn\'t installed.
fi

mkdir -p $TMP_DIR
#save daal artifacts to temp
if [ ! -f "$TMP_DIR/DAAL.tgz" ]; then
	echo "download DAAL binaries"
	wget $DAAL_PACKAGE -O $TMP_DIR/DAAL.tgz
fi

mkdir -p $INSTALL_DIR
#extract daal artifacts to home directory
if [ ! -d $INSTALL_DIR/daal-$DAAL_VERSION ]; then
	tar -xvf $TMP_DIR/DAAL.tgz -C $INSTALL_DIR
fi

#remove old link and create a new one
if [ -L $INSTALL_DIR/latest ]; then
	rm $INSTALL_DIR/latest
fi

ln -s $INSTALL_DIR/daal-$DAAL_VERSION $INSTALL_DIR/latest


#add ld library path to bashrc
if [ "$(cat ~/.bashrc | grep LD_LIBRARY_PATH.*daal.*)" == "" ]; then
	echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALL_DIR/latest/ >> $HOME/.bashrc
	source $HOME/.bashrc
fi

if [ $(command -v mvn) != "" ]; then
	mvn install:install-file -Dfile=$INSTALL_DIR/daal-$DAAL_VERSION/daal.jar -DgroupId=com.intel.daal -DartifactId=daal-core -Dversion=$DAAL_VERSION -Dpackaging=jar
else
	echo Couldn\'t install daal.jar maven isn\'t installed.
fi

