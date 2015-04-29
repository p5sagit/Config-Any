use strict;
use warnings;

use Test::More tests => 7;
use Config::Any;
use Config::Any::Perl;

{
    my $file   = 't/conf/conf.pl';
    my $config = Config::Any::Perl->load( $file );

    ok( $config );
    is( $config->{ name }, 'TestApp' );

    my $config_load2 = Config::Any::Perl->load( $file );
    is_deeply( $config_load2, $config, 'multiple loads of the same file' );
}

# test invalid config
{
    my $file = 't/invalid/conf.pl';
    my $config = eval { Config::Any::Perl->load( $file ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}

# parse error generated on invalid config
{
    my $file = 't/invalid/conf.pl';
    my $config = eval { Config::Any->load_files( { files => [$file], use_ext => 1} ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}
