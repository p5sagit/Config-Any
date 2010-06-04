use strict;
use warnings;

use Test::More;
use Config::Any;

eval { require Test::LeakTrace; };

if( $@ ) {
    plan skip_all => 'Test::LeakTrace required for this test';
}
else {
    plan tests => 1;
}

Test::LeakTrace::no_leaks_ok( sub { 
    Config::Any->load_files( {
        files           => [ qw( t/conf/conf.pl ) ],
        use_ext         => 1,
        flatten_to_hash => 1,
        force_plugins   => [ 'Config::Any::Perl' ],
    } );
} );

1;

__END__
t/70-leak.t .. 
1..1
not ok 1 - leaks 1 == 0

#   Failed test 'leaks 1 == 0'
#   at t/70-leak.t line 23.
#          got: 1
#     expected: 0
# leaked SCALAR(0x95049d8) from /usr/lib/perl/5.10/XSLoader.pm line 94.
#   93:    push(@DynaLoader::dl_shared_objects, $file); # record files loaded
#   94:    return &$xs(@_);
#   95:
# SV = PV(0x94d6f88) at 0x95049d8
#   REFCNT = 1
#   FLAGS = (POK,pPOK)
#   PV = 0x95035e8 "t/conf/conf.pl"\0
#   CUR = 14
#   LEN = 16
# Looks like you failed 1 test of 1.
Dubious, test returned 1 (wstat 256, 0x100)
Failed 1/1 subtests 

Test Summary Report
-------------------
t/70-leak.t (Wstat: 256 Tests: 1 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
Files=1, Tests=1,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.04 cusr  0.00 csys =  0.07 CPU)
Result: FAIL

