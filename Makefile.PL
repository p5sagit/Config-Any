use inc::Module::Install 1.00;

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Config/Any.pm > README' );
}

perl_version '5.006';
name 'Config-Any';

all_from 'lib/Config/Any.pm';

requires 'Module::Pluggable' => '3.01';

# Upgrade Config::General is necessary
if ( can_use( 'Config::General' ) && !can_use( 'Config::General', '2.47' ) ) {
    requires 'Config::General' => '2.47';
}

test_requires 'Test::More';

# Scrub requires() for META output
if ( $Module::Install::AUTHOR ) {
    Meta->{ values }{ requires } = [ grep { $_->[ 0 ] ne 'Config::General' }
            @{ Meta->{ values }{ requires } } ];
}

resources repository =>
    'git://git.shadowcat.co.uk/p5sagit/Config-Any.git';

WriteAll;
