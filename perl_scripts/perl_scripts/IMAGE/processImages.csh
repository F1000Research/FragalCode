#!/bin/csh -f

if($#argv != 2  ) then 
  echo "Usage : "
  exit 
endif 

set PWD = ` pwd`
set listref = $PWD/$1
set dir = $PWD/$2
set csv = $PWD/out.csv


mkdir -p $dir
\rm -rf $csv
touch $csv
echo " Name, blue , red, others , blue , red, others , blue , red, others , blue , red, others , blue , red, others , blue , red, others ,  " >> $csv 

foreach ref ( ` cat $listref` )
  echo PROCESSING $ref 
  mkdir -p $dir/$ref.dir 	
  cd $dir/$ref.dir 	
  if(! -e $ref.csv) then 
       cp -r  $PWD/$ref . 
       $SRC/IMAGE/changeColor.pl -in $ref -from red -to white
       $SRC/IMAGE/changeColor.pl -in $ref -from blue -to white
       $SRC/IMAGE/changeColor.pl -in $ref -from black -to white
       $SRC/IMAGE/getContour.pl -out out.contour.png -in $ref -color blue -color red -csv $ref.csv  -contourcolo
       $SRC/IMAGE/getContour.pl -out out.contour.png -in $ref -color blue -color red -csv $ref.csv  
  endif 
  cat $ref.csv >> $csv
  cd $PWD 
end

