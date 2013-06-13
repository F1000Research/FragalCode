#!/bin/csh -f

if($#argv != 2  ) then 
  echo "Usage : "
  exit 
endif 

set ref = $1
set listquery = $2

newfile.csh YY 
foreach i ( ` cat $listquery` )
    if(-e  $i/$i.$ref.pdb.out && !(-z $i/$i.$ref.pdb.out)) then 
		echo -n "$i " >> YY 
		head -1  $i/$i.$ref.pdb.out >> YY 
	endif 
end

sort.pl -idx 5 -in YY -out list.ordered.scores
makepdblistonly.pl -in list.ordered.scores -out list.ordered

#ANN list.ordered
