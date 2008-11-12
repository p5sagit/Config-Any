use strict;
use warnings;

use Test::More;
use Config::Any::JSON;

if ( !Config::Any::JSON->is_supported ) {
    plan skip_all => 'JSON format not supported';
}
else {
    plan tests => 4;
}

{
    my $config = Config::Any::JSON->load( 't/conf/conf.json' );
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}

# test invalid config
{
    my $file = 't/invalid/conf.json';
    my $config = eval { Config::Any::JSON->load( $file ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}
