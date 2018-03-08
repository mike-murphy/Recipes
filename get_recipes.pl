#!/usr/bin/perl
use strict;
use warnings;

use LWP;
use JSON;
use JSON::Parse 'parse_json';
use URI::Escape;
use Data::Dumper;

use Recipe;


if (!$ARGV[0]) {
	print qq|usage: $0 enter params seperated by spaces
			enclose multi-word parms in quotes.  ie: steak potatoes 'lime juice'\n\n|;
	exit(0);
}

use constant API => 'http://www.recipepuppy.com/api/?i=';

print "\nSearching for recipes containing ingredients: ", join (', ', @ARGV), "\n\n";

my $agent = LWP::UserAgent->new;

my $response = $agent->get( API . uri_escape(substr(join (',', @ARGV), 0)) );

unless ($response and $response = $response->{_content}) {
	die();
}

my $recipes = (parse_json $response)->{results};

foreach my $recipe (@$recipes) {
	my $obj = new Recipe(title =>$recipe->{title},
						 ingredients => $recipe->{ingredients},
						 href => $recipe->{href},
						 thumbnail => $recipe->{thumbnail} || '' );

	$obj->print;
	print "~~~~~~~~~~~~~~~~~~~~~~~~~\n";
}

