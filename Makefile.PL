use inc::Module::Install 0.91;

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Config/Any.pm > README' );
}

perl_version '5.006';
name 'Config-Any';

all_from 'lib/Config/Any.pm';

requires 'Module::Pluggable' => '3.01';

if (can_use('Config::General') && !can_use('Config::General', '2.47')) {
    requires 'Config::General' => '2.47';
}

test_requires 'Test::More';

if ($Module::Install::AUTHOR) {
    Meta->{values}{requires} = [ grep {
        $_->[0] ne 'Config::General'
    } @{ Meta->{values}{requires} } ];
}

resources repository => 'http://dev.catalyst.perl.org/repos/Catalyst/trunk/Config-Any/';

WriteAll;
