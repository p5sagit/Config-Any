use strict;
use warnings;

use Test::More;
use Config::Any::XML;

if ( !Config::Any::XML->is_supported ) {
    plan skip_all => 'XML format not supported';
}
else {
    plan tests => 6;
}

{
    my $config = Config::Any::XML->load( 't/conf/conf.xml' );
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}

# test invalid config
SKIP: {
    my $broken_libxml
        = eval { require XML::LibXML; XML::LibXML->VERSION lt '1.59'; };
    skip 'XML::LibXML < 1.58 has issues', 2 if $broken_libxml;

    local $SIG{ __WARN__ } = sub { };    # squash warnings from XML::Simple
    my $file = 't/invalid/conf.xml';
    my $config = eval { Config::Any::XML->load( $file ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}

# test conf file with array ref
{
    my $file = 't/conf/conf_arrayref.xml';
    my $config = eval { Config::Any::XML->load( $file ) };

    ok( $config, 'config loaded' );
    ok( !$@,     'no error thrown' );
}
