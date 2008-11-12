use strict;
use warnings;

use Test::More;
use Config::Any::General;

if ( !Config::Any::General->is_supported ) {
    plan skip_all => 'Config::General format not supported';
}
else {
    plan tests => 6;
}

{
    my $config = Config::Any::General->load( 't/conf/conf.conf' );
    ok( $config );
    is( $config->{ name }, 'TestApp' );
    ok( exists $config->{ Component } );
}

{
    my $config = Config::Any::General->load( 't/conf/conf.conf',
        { -LowerCaseNames => 1 } );
    ok( exists $config->{ component } );
}

# test invalid config
{
    my $file = 't/invalid/conf.conf';
    my $config = eval { Config::Any::General->load( $file ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}
