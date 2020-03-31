#!/usr/bin/env perl

use strict;
use Getopt::Long;
use FileHandle;

my $opt_sakila_dir = "./test_db";
my $opt_output_dir = ".";

sub parse_data_line($) {
    my ($line) = @_;
    my ($values, $dataline) = $line =~ /(VALUES )?\((.*)\)/;
    # print "values: $values, dataline: $dataline\n";
    if ( $dataline) {
        $dataline =~ s/'(\d\d\d\d-\d\d-\d\d)'/$1/g;
    }
    # print "values: $values, converted dataline: $dataline\n";
    return $dataline;
}

sub process_file($$) {
    my ($infile, $outfile) = @_;
    my $infh = new FileHandle;
    $infh->open("< $infile") or die "could not open $infile: $!";
    my $outfh = new FileHandle;
    $outfh->open(">$outfile") or die "could not open output file $outfile: $!";
    while (my $line = <$infh>) {
        if ( $line =~ /^\s*$/) { next; }
        my $dataline = parse_data_line($line);
        if ( $dataline ) {
            $outfh->print($dataline, "\n")
        }
    }
    $infh->close();
    $outfh->close();
}

GetOptions("sakila-dir=s", \$opt_sakila_dir,
            "output-dir=s", \$opt_output_dir)
or die "invalid options";

if ( ! -d $opt_sakila_dir ) {
    die "cannot find input directory $opt_sakila_dir";
}

if ( ! -d $opt_output_dir ) {
    die "cannot find output directory $opt_output_dir";
}

print("converting data from $opt_sakila_dir to $opt_output_dir\n");

process_file("$opt_sakila_dir/load_titles.dump", "$opt_output_dir/titles.csv");
process_file("$opt_sakila_dir/load_departments.dump", "$opt_output_dir/departments.csv");
process_file("$opt_sakila_dir/load_dept_emp.dump", "$opt_output_dir/dept_emp.csv");
process_file("$opt_sakila_dir/load_dept_manager.dump", "$opt_output_dir/dept_manager.csv");

process_file("$opt_sakila_dir/load_salaries1.dump", "$opt_output_dir/salaries1.csv");
process_file("$opt_sakila_dir/load_salaries2.dump", "$opt_output_dir/salaries2.csv");
process_file("$opt_sakila_dir/load_salaries3.dump", "$opt_output_dir/salaries3.csv");

print "done\n";
