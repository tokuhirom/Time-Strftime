package Time::Strftime;
use strict;
use warnings;
use 5.008005;
our $VERSION = '0.01';
use POSIX ();

use parent qw(Exporter);

our @EXPORT = qw(strftime);

our @WEEKDAY = ("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
our @WDAY = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
our @MONTH = ( "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
our @MON = ( "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" );
our $TZOFFSET = '+0000';
our $TZNAME   = 'GMT';

sub _02d {
    sprintf('%02d', $_[0])
}

sub _2d {
    sprintf('%2d', $_[0])
}

sub strftime {
    my $format = shift;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = @_;

    $format =~ s!%(.)|(.)!
        if ($1) {
            if ($1 eq 'A') {
                $WEEKDAY[$wday]
            } elsif ($1 eq 'a') {
                $WDAY[$wday]
            } elsif ($1 eq 'B') {
                $MONTH[$mon]
            } elsif ($1 eq 'b') {
                $MON[$mon]
            } elsif ($1 eq 'C') {
                _02d(($year+1900)/100)
            } elsif ($1 eq 'c') {
                strftime('%Y-%m-%dT%H:%M:%S', @_);
            } elsif ($1 eq 'D') {
                strftime('%m/%d/%y', @_);
            } elsif ($1 eq 'd') {
                _02d($mday)
            } elsif ($1 eq 'e') {
                _2d($mday)
            } elsif ($1 eq 'F') {
                strftime('%Y-%m-%d', @_)
            } elsif ($1 eq 'G') {
                # Not quite right.
                sprintf('%04d', $year+1900);
            } elsif ($1 eq 'g') {
                # Not quite right.
                my $s = strftime('%G', @_);
                $s =~ s(^..)();
                $s;
            } elsif ($1 eq 'H') {
                _02d($hour)
            } elsif ($1 eq 'h') {
                $MON[$mon]
            } elsif ($1 eq 'I') {
                _02d(($hour+11)%12 +1)
            } elsif ($1 eq 'j') {
                sprintf('%03d', $yday+1)
            } elsif ($1 eq 'k') {
                _02d($hour)
            } elsif ($1 eq 'l') {
                _02d(($hour+11)%12+1)
            } elsif ($1 eq 'M') {
                _02d($min)
            } elsif ($1 eq 'm') {
                _02d($mon+1)
            } elsif ($1 eq 'n') {
                "\n"
            } elsif ($1 eq 'p') {
                if ($hour < 12) {
                    'am'
                } else {
                    'PM'
                }
            } elsif ($1 eq 'R') {
                strftime('%H:%M', @_)
            } elsif ($1 eq 'r') {
                strftime('%I:%M:%S %p', @_)
            } elsif ($1 eq 'S') {
                _02d($sec)
            } elsif ($1 eq 's') {
                POSIX::mktime(@_)
            } elsif ($1 eq 'T') {
                strftime('%H:%M:%S', @_)
            } elsif ($1 eq 't') {
                "\t"
            } elsif ($1 eq 'U') {
                _02d($yday/7) # Not quite right
            } elsif ($1 eq 'u') {
                $wday ? $wday : 7
            } elsif ($1 eq 'V') {
                _02d(1+$yday/7); # Not quite right
            } elsif ($1 eq 'v') {
                strftime('%e-%b-%Y', @_)
            } elsif ($1 eq 'W') {
                _02d($yday/7) # Not quite right
            } elsif ($1 eq 'w') {
                0+$wday
            } elsif ($1 eq 'X') {
                sprintf('%02d:%02d:%02d', $hour, $min, $sec)
            } elsif ($1 eq 'x') {
                sprintf('%02d/%02d/%04d', $mon+1, $mday, $year+1900)
            } elsif ($1 eq 'Y') {
                1900+$year
            } elsif ($1 eq 'y') {
                (1900+$year)%100
            } elsif ($1 eq 'Z') {
                $TZNAME
            } elsif ($1 eq 'z') {
                $TZOFFSET
            } elsif ($1 eq '%') {
                '%'
            } else {
                $1; # no work.
            }
        } else {
            $2;
        }
    !ge;
    return $format;
}

1;
__END__

=encoding utf8

=head1 NAME

Time::Strftime - ...

=head1 SYNOPSIS

  use Time::Strftime;

=head1 DESCRIPTION

Time::Strftime is

B<THIS IS A DEVELOPMENT RELEASE. API MAY CHANGE WITHOUT NOTICE>.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF@ GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
