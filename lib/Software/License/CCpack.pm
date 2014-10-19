package Software::License::CCpack;

use strict;
use warnings;

1;

# PODNAME: Software::License::CCpack
# ABSTRACT: Software::License pack for Creative Commons' licenses
=head1 SYNOPSIS

   my $license = Software::License::CC_BY_4_0->new({
      holder => 'Brendan Byrd',
   });

   say $license->fulltext;

=head1 DESCRIPTION

This "license pack" contains all of the licenses from Creative Commons,
except for CC0, which is already included in L<Software::License>.

Note that I don't recommend using these licenses for your own CPAN
modules.  (Most of the licenses aren't even compatible with CPAN.)
However, S:L modules are useful for more than mere L<CPAN::Meta::license>
declaration, so these modules exist for those other purposes.

=cut