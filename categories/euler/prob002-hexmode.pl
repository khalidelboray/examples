use v6;

=begin pod

=TITLE Even Fibonacci numbers

=AUTHOR Mark A. Hershberger

L<https://projecteuler.net/problem=2>

Each new term in the Fibonacci sequence is generated by adding the previous
two terms. By starting with 1 and 2, the first 10 terms will be:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

By considering the terms in the Fibonacci sequence whose values do not
exceed four million, find the sum of the even-valued terms.

=end pod

# code exposes a bug in r34733 rakudo, but works in pugs

class Fibonacci {
    has @!list = (0, 1);

    method next() {
        @!list[2] = [+] @!list;
        shift @!list;
        return @!list[1];
    }
}

my $fibber = Fibonacci.new;
my $f;

my @r = gather {
    $f = $fibber.next;
    while $f < 4000000 {
        take (0+$f) if $f % 2 == 0;
        $f = $fibber.next;
    }
}

say [+] @r;

# vim: expandtab shiftwidth=4 ft=perl6
