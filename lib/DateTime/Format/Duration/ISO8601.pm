package DateTime::Format::Duration::ISO8601;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub format_duration {
    my ($self, $dtdur) = @_;

    my ($y, $m, $w, $d, $H, $M, $S, $ns) = (
        $dtdur->years,
        $dtdur->months,
        $dtdur->weeks,
        $dtdur->days,
        $dtdur->hours,
        $dtdur->minutes,
        $dtdur->seconds,
        $dtdur->nanoseconds,
    );

    $S += $ns / 1_000_000_000;

    my $has_time = $H || $M || $S;
    join(
        "",
        "P",
        ($y, "Y") x !!$y,
        ($m, "M") x !!$m,
        ($w, "W") x !!$w,
        ($d, "D") x !!$d,
        (
            "T",
            ($H, "H") x !!$H,
            ($M, "M") x !!$M,
            ($S, "S") x !!$S,
        ) x !!$has_time,
    );
}

1;
# ABSTRACT: Format DateTime::Duration object as ISO8601 duration string

=head1 SYNOPSIS

 use DateTime::Format::Duration::ISO8601;

 my $d = DateTime::Format::Duration::ISO8601->new;
 say $d->format_duration(
     DateTime::Duration->new(years=>3, months=>5, seconds=>10),
 ); # => P3Y5MT10S


=head1 DESCRIPTION


=head1 SEE ALSO

L<DateTime::Format::ISO8601> to format L<DateTime> object into ISO8601 date/time
string. At the time of this writing, there is no support to format
L<DateTime::Duration> object, hence this module.

L<DateTime::Format::Duration> to format DateTime::Duration object using
strftime-style formatting.

=cut