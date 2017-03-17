#!/bin/bash
declare -a episodios
#episodios=(`cat "convertlist.txt"`)
mapfile -t episodios < convertlist.txt

while [ ${#episodios[@]} -ne 0 ] ;
do
    if [[ ${episodios[0]} = \#* ]] ;
    then
        unset episodios[0]
        episodios=( "${episodios[@]}" )
        continue
    fi    
    
    AUDIO_NOME="${episodios[0]}"
    unset episodios[0]
    episodios=( "${episodios[@]}" )  
    
    
    
    if [[ ${episodios[0]} != *.mp3 ]] && ![[ -z "${episodios[0]}" ]] ;
    then
        EPISODIO_NOME="${episodios[0]}"
        unset episodios[0]
        episodios=( "${episodios[@]}" )
        ./create-video.sh $AUDIO_NOME "$EPISODIO_NOME"
    else
        ./create-video.sh $AUDIO_NOME
    fi
done

