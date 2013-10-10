use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.033

use Test::More  tests => 7 + ($ENV{AUTHOR_TESTING} ? 1 : 0);



my @module_files = (
    'Software/License/CC_BY_3_0.pm',
    'Software/License/CC_BY_NC_3_0.pm',
    'Software/License/CC_BY_NC_ND_3_0.pm',
    'Software/License/CC_BY_NC_SA_3_0.pm',
    'Software/License/CC_BY_ND_3_0.pm',
    'Software/License/CC_BY_SA_3_0.pm',
    'Software/License/CC_PDM_1_0.pm'
);



# no fake home requested

use File::Spec;
use IPC::Open3;
use IO::Handle;

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, '-Mblib', '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($? >> 8, 0, "$lib loaded ok");

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



is(scalar(@warnings), 0, 'no warnings found') if $ENV{AUTHOR_TESTING};


