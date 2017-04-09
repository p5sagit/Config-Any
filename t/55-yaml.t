use strict;
use warnings;
no warnings 'once';

use Test::More;
use Config::Any;
use Config::Any::YAML;

if ( !Config::Any::YAML->is_supported && !$ENV{RELEASE_TESTING} ) {
    plan skip_all => 'YAML format not supported';
}
else {
    plan tests => 6;
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

    is $config, undef, 'config load failed';
    isnt $@, '', 'error thrown';
}

# parse error generated on invalid config
{
    my $file = 't/invalid/conf.yml';
    my $config = eval { Config::Any->load_files( { files => [$file], use_ext => 1} ) };

    is $config, undef, 'config load failed';
    isnt $@, '', 'error thrown';
}
