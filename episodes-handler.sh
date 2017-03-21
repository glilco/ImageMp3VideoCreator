
# Exit on error
set -e

# Builds the array with audio filenames and episode names
declare -a episodes
mapfile -t episodes < convertlist.txt

while [ ${#episodes[@]} -ne 0 ] ;
do
    # Ignore commented lines
    if [[ ${episodes[0]} = \#* ]] ;
    then
        unset episodes[0]
        episodes=( "${episodes[@]}" )
        continue
    fi    
    
    # Take the line as an audio filename
    AUDIO_NAME="${episodes[0]}"
    unset episodes[0]
    episodes=( "${episodes[@]}" )  
    
    if [ ! -f "$AUDIO_NAME" ]; then
        echo -e "\033[0;31mFile $AUDIO_NAME not found!\033[0m"
        continue
    fi
    
    
    # If the next line is not empty and is not a Mp3 file, it is an episode name
    if [[ ${episodes[0]} != *.mp3 ]] && ! [[ -z "${episodes[0]}" ]] ;
    then
        EPISODE_NAME="${episodes[0]}"
        unset episodes[0]
        episodes=( "${episodes[@]}" )
        ./create-video.sh $AUDIO_NAME "$EPISODE_NAME"
    else
        ./create-video.sh $AUDIO_NAME
    fi
done

