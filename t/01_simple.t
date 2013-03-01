use strict;
use warnings;
use utf8;
use Test::More;
use POSIX;
use Time::Strftime;

my @case = (
    A => 'Friday',
    a => 'Fri',
    B => 'March',
    h => 'Mar',
    b => 'Mar',
    C => '20',
    c => '2013-03-01T12:25:56',
    D => '03/01/13',
    d => '01',
    e => ' 1',
    F => '2013-03-01',
    G => '2013',
    g => '13',
    H => '12',
    I => '12',
    j => '060',
    k => '12',
    l => '12',
    M => '25',
    m => '03',
    n => "\n",
    p => 'PM',
    R => '12:25',
    r => '12:25:56 PM',
    S => '56',
    s => '1362108356',
    T => '12:25:56',
    t => "\t",
    U => '08',
    u => '5',
    V => '09',
    v => ' 1-Mar-2013',
    W => '08',
    w => '5',
    X => '12:25:56',
    x => '03/01/2013',
    Y => '2013',
    y => '13',
    Z => 'GMT',
    z => '+0000',
    '%' => '%',
);

my $t = 1362140756;
while (my ($c, $expected) = splice(@case, 0, 2)) {
    my $format = "%" . $c;
    is(strftime($format, gmtime($t)), $expected, "$format => $expected");
    note sprintf("*%s*", POSIX::strftime($format, gmtime($t)));
}

done_testing;

