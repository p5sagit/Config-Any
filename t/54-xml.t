use strict;
use warnings;

use Test::More;
use Config::Any::XML;

if ( !Config::Any::XML->is_supported ) {
    plan skip_all => 'XML format not supported';
}
else {
    plan tests => 4;
}

{
    my $config = Config::Any::XML->load( 't/conf/conf.xml' );
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}

# test invalid config
{
    my $file   = 't/invalid/conf.xml';
    my $config = eval { Config::Any::XML->load( $file ) };

    ok( !$config, 'config load failed' );
    ok( $@, "error thrown ($@)" ); 
}
