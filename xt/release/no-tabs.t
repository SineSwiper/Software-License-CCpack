use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.04

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Software/License/CC_BY_3_0.pm',
    'lib/Software/License/CC_BY_NC_3_0.pm',
    'lib/Software/License/CC_BY_NC_ND_3_0.pm',
    'lib/Software/License/CC_BY_NC_SA_3_0.pm',
    'lib/Software/License/CC_BY_ND_3_0.pm',
    'lib/Software/License/CC_BY_SA_3_0.pm',
    'lib/Software/License/CC_PDM_1_0.pm',
    'lib/Software/License/CCpack.pod'
);

notabs_ok($_) foreach @files;
done_testing;
