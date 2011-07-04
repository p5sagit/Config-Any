use strict;
use warnings;
no warnings 'once';

use Test::More;
use Config::Any::YAML;

$Config::Any::YAML::NO_YAML_XS_WARNING = 1;

if ( !Config::Any::YAML->is_supported ) {
    plan skip_all => 'YAML format not supported';
}
else {
    plan tests => 4;
}

{
    my $config = Config::Any::YAML->load( 't/conf/conf.yml' );
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}

# test invalid config
{
    my $file = 't/invalid/conf.yml';
    my $config = eval { Config::Any::YAML->load( $file ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}
