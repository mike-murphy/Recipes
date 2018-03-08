package Recipe;

use strict;
use warnings;
use Data::Dumper;


sub new {
	my $class = shift; $class = ref($class) || $class;

	my @args = grep { /title|ingredients|href/ } @_;

	my $self =
		bless (
			{
				@_
			} => $class
		);

	unless (scalar @args == 3) {
		$self->fault = "ERROR: $class must contain title, ingredients, and href"
	}

	$self->_trim;

	return $self;
}

sub print {
	my ($self) = @_;

	print $self->{title}, "\n";
	print $self->{ingredients}, "\n";
	print $self->{href}, "\n";
	print $self->{thumbnail}, "\n" if $self->{thumbnail};
}

sub _trim {
	my ($self) = @_;

	$self->{title} =~ s/^\s+|\s+$//g;
	$self->{ingredients} =~ s/^\s+|\s+$//g;
	$self->{href} =~ s/^\s+|\s+$//g;
	$self->{thumbnail} =~ s/^\s+|\s+$//g;
}

1;
