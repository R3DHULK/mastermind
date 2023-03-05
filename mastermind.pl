#!/usr/bin/perl

use strict;
use warnings;

# Set up the game variables
my $code_length = 4;
my @colors = qw(R G B Y O P);
my @code = ();
for (1..$code_length) {
    push(@code, $colors[int(rand(@colors))]);
}
my $guesses_left = 10;
my @guesses = ();

# Print game instructions
print "Welcome to Mastermind!\n";
print "The code is a sequence of $code_length colors, chosen from:\n";
print join(" ", @colors) . "\n";
print "You have $guesses_left guesses to crack the code.\n";
print "Each guess should be a sequence of $code_length colors, separated by spaces.\n";
print "After each guess, I'll give you some feedback:\n";
print "  X means a correct color in the correct position.\n";
print "  O means a correct color in the wrong position.\n";
print "  - means a color that is not in the code.\n\n";

# Main game loop
while ($guesses_left > 0) {
    # Get user input
    print "Guess: ";
    my $input = <STDIN>;
    chomp($input);

    # Validate user input
    my @guess = split(/\s+/, $input);
    if (@guess != $code_length) {
        print "Invalid guess: must be $code_length colors separated by spaces.\n";
        next;
    }
    my %colors_seen = ();
    foreach my $color (@guess) {
        if (!grep { $_ eq $color } @colors) {
            print "Invalid color: $color.\n";
            next;
        }
        if ($colors_seen{$color}) {
            print "Duplicate color: $color.\n";
            next;
        }
        $colors_seen{$color} = 1;
    }

    # Evaluate user guess
    my @feedback = ();
    for (my $i = 0; $i < $code_length; $i++) {
        if ($guess[$i] eq $code[$i]) {
            push(@feedback, "X");
        } elsif (grep { $_ eq $guess[$i] } @code) {
            push(@feedback, "O");
        } else {
            push(@feedback, "-");
        }
    }

    # Print feedback
    print "Feedback: " . join("", @feedback) . "\n\n";

    # Store guess
    push(@guesses, [$input, @feedback]);

    # Check for win
    if (join("", @feedback) eq "X" x $code_length) {
        print "Congratulations! You cracked the code: " . join(" ", @code) . "\n";
        exit;
    }

    # Decrement guesses left
    $guesses_left--;
}

# Game over
print "Game over. You ran out of guesses. The code was: " . join(" ", @code) . "\n";
