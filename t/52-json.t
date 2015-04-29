use strict;
use warnings;

use Test::More;
use Config::Any;
use Config::Any::JSON;

if ( !Config::Any::JSON->is_supported ) {
    plan skip_all => 'JSON format not supported';
}
else {
    plan tests => 6;
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

# parse error generated on invalid config
{
    my $file = 't/invalid/conf.json';
    my $config = eval { Config::Any->load_files( { files => [$file], use_ext => 1} ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}
