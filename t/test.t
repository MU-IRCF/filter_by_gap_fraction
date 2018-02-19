#!/usr/bin/env perl6

use Test;

sub MAIN ($DEBUG=False) {

    # create test files
    my %moved = (
        too_many_gaps() => False,        # It's not been moved
        dummy()         => True,       # It's been moved
    );
    
    for %moved.kv -> $file, $expected {
        shell "perl filter_by_alignment_quality $file 0.50"; 
        my $has_moved = ! $file.IO.e;
        is $has_moved, $expected, "Filter by ortho group worked for '$file'";
    }
    
    unlink %moved.keys unless $DEBUG;
    
    shell 'rm -rf AlignmentsFilteredByQuality' unless $DEBUG;
    
    done-testing;
}

sub too_many_gaps {
    spurt 'too_many_gaps.fa', q:to/END/;
>First_line_trinity
AAA
---
---
AAA
---
---
---
>First_line_trinity
---
---
A-A
A-A
>Second_line_trinity
---
A-A
GGG
>Third_line_trinity
GGG
---
A-A
>Fourth_line_trinity
GGG
---
A-A
>Fifth_line_trinity
GGG
---
A-A
END
    return 'too_many_gaps.fa';
}

sub dummy {
    spurt 'dummy.fa', q:to/END/;
>First_line_trinity
AAA
>Second_line_trinity
GGG
>Third_line_trinity
GGG
>Fourth_line_trinity
GGG
>Fifth_line_trinity
GGG
>Sixth_line_trinity
GGG
>Seventh_line_trinity
GGG
>Eigth_line_trinity
GGG
>Nine_line_trinity
GGG
>Ten_line_trinity
GGG
END
    return 'dummy.fa';
}
