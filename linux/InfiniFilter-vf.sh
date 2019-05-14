#FFMPREG Video Filter Stacking Script <3

if [[ ${1} =~ ("-h"|"-help") ]]; then
 clear
  tput setaf 2;  echo "
                                   U S A G E: 
./InfiniFilter.sh input.mp4 bmp rgb565le 640x360 50 unsharp,format=xyz12le"
  tput setaf 4 && tput smul; echo "    source format colorspace/pix_fmt vid-resolution loop-amount filters    "    
else 
 if [[ ${1} =~ ("-x"|"-extra"|"-meme") ]]; then
 cat InfiniFilter-halp.txt
else 
 if [[ ${1} =~ ("-e"|"-edit") ]] && [[ ${2} =~ ("-l"|"-local") ]] ; then
  file=$(cat InfiniFilter-vf-halp.txt)
  newline="$3"
 echo -e "$file\n\n"$(printf "$newline")"" > InfiniFilter-vf-halp.txt
else 
 if [[ ${1} =~ ("-e"|"-edit") ]]; then
  file=$(cat $2)
  newline="$3"
 echo -e "$file\n\n"$(printf "$newline")"" > $2
else
#Where The Magic Begins#

mkdir frames
 mkdir ./frames/result
  FFMPREG -i $1 -pix_fmt $3 -s $4 -frames 30 -y ./frames/frame%d.$2
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

cd ./frames
 for p in *.$2; do 
 FFMPREG -i $p  -pix_fmt $3 -vf $newfilt -y ./result/"${p%}" ; done

cd result
 FFPLEY frame%d.$2 -loop 9001
 wait
 rm *.$2
rm ../*.$2

clear
echo $newfilt 
echo "Is what you used."; fi fi fi fi
