package BFD;

$VERSION = 0.1;

=head1 NAME

  BFD - Impromptu dumping of data structures for debugging purposes

=head1 SYNOPSIS

   my $scary_structure1 = foo();
   my $scary_structure2 = bar();
   use BFD; d $scary_structure1, " hmmm ", $scary_structure2, ...;
   ....

=head1 DESCRIPTION

Allows for impromptu dumping of output to STDERR.  Useful when you want
to take a peek at a nest Perl data structure by emitting (relatively)
nicely formatted output.

Basically,

    use BFD;d $foo;

is shorthand for

    use Data::Dumper;
    local $Data::Dumper::Indent    = 1;
    local $Data::Dumper::Quotekeys = 0;
    local $Data::Dumper::Terse     = 1;
    local $Data::Dumper::Sortkeys  = 1;
    warn Dumper( $foo );

I use this incantation soooo often that a TLA version is warranted.
YMMV.

=cut

use strict;

sub import {
    no strict 'refs';
    *{caller() . "::d"} = \&d;
}


sub dump_ref {
    require Data::Dumper;
    local $Data::Dumper::Indent    = 1;
    local $Data::Dumper::Quotekeys = 0;
    local $Data::Dumper::Terse     = 1;
    local $Data::Dumper::Sortkeys  = 1;
    Data::Dumper::Dumper( @_ )
}


sub d {
    warn map
        ! defined $_ ? "undef"
        : ref $_     ? dump_ref $_
                     : $_,
    @_;
}

=head1 LIMITATIONS

Uses Data::Dumper, which has varying degrees of stability and usefulness
on different versions of perl.

=head1 AUTHOR

Barrie Slaymaker <barries@slaysys.com>

=head1 COPYRIGHT

Copyright (c) 2003, Barrie Slaymaker.  All Rights Reserved.

=head1 LICENSE

You may use this software under the terms of the GNU Pulic License, the
Artistic License, the BSD license, the MIT license, etc., etc., etc.

Good luck and God Speed.

=cut

1 ;
