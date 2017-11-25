#!/usr/bin/perl

# It executes top linux command on the list of distributed machines 
# @Author: Juan Fumero <jjfumero@gmail.com>
# Taking ideas from course: http://nereida.deioc.ull.es/~lhp/lhp0506/  

use strict;
use GRID::Machine; 

# List of machines
my @machines = qw/ avus suzuka /;
my %m = {};

for (@machines) {
    print "Setting connection for: $_\n";
    my $gm = GRID::Machine->new(host=>$_, uses=>[qw(Sys::Hostname)]);

    # We install the following perl subrutine 
    $gm->sub(hostname=> q{
        print "-------------- Machine: ".hostname()." -------------\n";
    });
    $m{$_} = $gm;
}

# Now, we run ps command for all machines
for (@machines) {
    print "\n";
    print $m{$_}->hostname();
    print $m{$_}->system("ps --sort -pcpu aux  | head -n 15");  
	print $m{$_}->system("nvidia-smi");
	print $m{$_}->system("finger");
}

