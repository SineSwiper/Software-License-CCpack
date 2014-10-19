package Software::License::CCpack;

# AUTHORITY
# VERSION
# ABSTRACT: Software::License pack for Creative Commons' licenses

42;

__END__

=encoding utf8

=begin wikidoc

= SYNOPSIS

   use Software::License::CC_BY_4_0;

   my $license = Software::License::CC_BY_4_0->new({
      holder => 'Brendan Byrd',
   });

   print $license->fulltext;

= DESCRIPTION

This "license pack" contains all of the licenses from Creative Commons,
except for CC0, which is already included in L<Software::License>.

Note that I don't recommend using these licenses for your own CPAN
modules.  (Most of the licenses aren't even compatible with CPAN.)
However, S:L modules are useful for more than mere L<CPAN::Meta::license>
declaration, so these modules exist for those other purposes.

=end wikidoc
