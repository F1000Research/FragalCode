$retval = add(3,3);

print STDOUT "sum = $retval\n";



sub add{
	my ($a,$b) = @_ ; 
	my $sum = $a + $b;
	return $sum ; 
}
