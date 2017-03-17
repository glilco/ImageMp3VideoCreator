#!/bin/bash

set -e

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Numero de parametros invalido"
    exit 1;
fi


NOME_AUDIO="$1"

ARRAY_EP=(${NOME_AUDIO//./ })
ARRAY_EP=(${ARRAY_EP[0]//-/ })

EP_NRO=${ARRAY_EP[0]}

unset ARRAY_EP[0]
EP_FILENAME=$(echo ${ARRAY_EP[@]})

echo "Episódio Número: $EP_NRO"

if [ $# -eq 2 ]; then
    EP_NOME="$2"
else
    EP_NOME="$EP_FILENAME"
fi

echo "Nome do episódio: $EP_NOME"


cp PadraoFilosofiaPop.svg "./convertidos/$EP_FILENAME.svg"
chmod 644 "./convertidos/$EP_FILENAME.svg"

sed -i "s/#NN/#$EP_NRO/g" "./convertidos/$EP_FILENAME.svg"
sed -i "s/TEMA/$EP_NOME/g" "./convertidos/$EP_FILENAME.svg"

#convert "$EP_FILENAME.svg" -density 400 "$EP_FILENAME.png"
inkscape -z -e "./convertidos/$EP_FILENAME.png" "./convertidos/$EP_FILENAME.svg" 


#ffmpeg -loop 1 -i "./convertidos/$EP_FILENAME.png" -i "$NOME_AUDIO" -c:a copy -c:v libx264 -shortest "./convertidos/Videos/$EP_FILENAME.mp4"

ffmpeg -loop 1 -framerate 1/25 -i "./convertidos/$EP_FILENAME.png" -i "$NOME_AUDIO" -vf "scale='min(1280,iw)':-2,format=yuv420p" -c:v libx264 -preset veryslow -crf 0 -c:a copy -shortest "./convertidos/Videos/$EP_NRO-$EP_FILENAME.mkv"


