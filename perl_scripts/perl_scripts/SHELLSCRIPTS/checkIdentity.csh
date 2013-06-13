#!/bin/csh -fv

if($#argv != 3  ) then 
  echo "Usage : "
  exit 
endif 

set listref = $1
set listquery = $2
set out = $3

\rm -f KKKK
touch KKKK 
echo $1 >> KKKK
echo $2 >> KKKK

checkIdentity.pl -out ooo -list KKKK -simi 60 -save
echo mv -f needle.out $1.$2.needle.out
mv -f needle.out $out



