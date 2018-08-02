#!/user/bin/perl -w
@files = split '\n',`ls *.txt`;

foreach (@files) {
   ($new=$_) =~ s/\.txt$//;
   rename $_, $new;
}
