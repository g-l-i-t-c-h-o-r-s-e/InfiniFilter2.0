#FFMPREG Audio Filter Stacking Script <3
if [[ ${1} =~ ("-h"|"-help") ]]; then
clear
tput setaf 2;  echo "
                                   U S A G E: 
./InfiniFilter-af.sh input.wav alaw 00:00:25 10 5 atempo=0.9,asetrate=45k 45000"
tput setaf 4 && tput smul; echo "      source format source-start duration loop-amount filters sample-rate      "    
else 
if [[ ${1} =~ ("-x"|"-extra"|"-meme") ]]; then
cat InfiniFilter-halp.txt
else 
if [[ ${1} =~ ("-e"|"-edit") ]] && [[ ${2} =~ ("-l"|"-local") ]] ; then
file=$(cat InfiniFilter-halp.txt)
newline="$3"
echo -e "$file\n\n"$(printf "$newline")"" > InfiniFilter-halp.txt
else 
if [[ ${1} =~ ("-e"|"-edit") ]]; then
file=$(cat $2)
newline="$3"
echo -e "$file\n\n"$(printf "$newline")"" > $2
else

   rm *.$2
  FFMPREG -ss $3 -i $1 -c:a pcm_$2 -ar $7 -f $2 -ac 2 -t $4 -y out.$2
 wait
FILTERS="$6"
OUT=""
 for i in `seq 1 $5`;
  do
  OUT+=",$FILTERS";
   done;
   newstring="$OUT"
  newfilt=${newstring#","}
 newfilt=${newfilt%","}
 FFMPREG -ar $7  -c:a pcm_$2 -f $2 -ac 2 -i out.$2 -c:a pcm_$2 -ar $7 -f $2 -ac 2 -af $newfilt -y final.$2
FFPLEY -ar $7  -acodec  pcm_$2 -f $2 -ac 2 -i final.$2 -af volume=0.2
echo $3 ; fi fi fi fi
