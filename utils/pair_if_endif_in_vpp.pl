#!/usr/bin/perl -w

use strict;
my $vppFileName = shift;

local @ARGV = ( $vppFileName );

my @groupIF;
my @groupEND;

while( <> ) {
   if ( m#^\s*`if# ) {
      push @groupIF, $.;
   } elsif ( m#^\s*`endif# ) {
      if ( @groupIF == 0 ) {
         print "At LINE$. found an unpaired endif\n";
         push @groupEND, $.;
      } else {
         pop @groupIF;
#         print "Pop a paired endif at LINE$.\n";
      }
   }
} # while ( <> )

print "FILE PARSING DONE!\n";
if ( @groupIF == 0 ) {
   print "No unpaired IF\n";
} else {
   print "Unpaired elements in Group IF: @groupIF\n";
}

if ( @groupEND == 0 ) {
   print "No unpaired END\n";
} else {
   print "Unpaired elements in Group END: @groupEND\n";
}

