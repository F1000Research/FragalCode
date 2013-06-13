#!/bin/csh -f

if($#argv != 1  ) then 
  echo "Usage : "
  exit 
endif 

set listref = list.ref
set dir = $1
set PWD = ` pwd ` 
set distances = $PWD/distances
set potentials = $PWD/potentials
set scores = $PWD/scores
set residues = $PWD/residues

newfile.csh $distances
newfile.csh $potentials
newfile.csh $scores
newfile.csh $residues

foreach ref ( ` cat $listref` )
  cd $dir
  if(-e $dir.$ref.distance.diff.txt ) then 
      echo -n DIST $ref >> $distances 
      cat $dir.$ref.distance.diff.txt  >> $distances 
  else 
  	    echo -n DIST $ref - - - >> $distances
  echo  >> $distances 
  endif 

  if(-e $dir.$ref.potential.diff.txt ) then 
        $SRC/MISC/potdiff.pl -in $dir.$ref.potential.diff.txt -protein $ref >> $potentials
  else
  	    echo -n $ref - - - >> $potentials
  echo  >> $potentials 
  endif 

  echo -n SCORES $ref - - - >> $scores
  if(-e $dir.$ref.pdb.out ) then
       head -1 $dir.$ref.pdb.out >> $scores 
  else
      echo >> $scores
  endif

  echo -n "$ref " >> $residues
  if(-e $dir.$ref.pdb.out ) then
       head -2 $dir.$ref.pdb.out | grep -v SCORE >> $residues 
  else
      echo >> $residues
  endif


  cd -
end

