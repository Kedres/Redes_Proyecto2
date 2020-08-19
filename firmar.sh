#!/bin/bash

#NOMBRE=$1
DIRECTORY=$1

if [ -d "$DIRECTORY" ]; then
	tar -cvzf $DIRECTORY.tar.gz $DIRECTORY
	DIRECTORY=$1.tar.gz
fi
# Firma GPG del archivo, haciendo constar que la persona que lo firma es quien lo envía.
gpg --sign --armor $DIRECTORY

# Cifrado del archivo.
openssl ts -query -data $DIRECTORY -cert -sha256 -no_nonce -out request.tsq

# Sellado temporal provisto por el servicio de SINPE.
cat request.tsq | curl -s -S -H 'Content-Type: application/timestamp-query' --data-binary @- http://tsa.sinpe.fi.cr/tsaHttp/ -o $DIRECTORY.tsr

rm -f request.tsq

openssl sha1 -out $DIRECTORY.sha1 $DIRECTORY
