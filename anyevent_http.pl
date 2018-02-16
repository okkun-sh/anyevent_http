#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

use AnyEvent;
use AnyEvent::HTTP;

my $urls = [
    'http://search.cpan.org',
    'http://okkun-sh.hatenablog.com',
];

for my $url (@$urls) {
    my $cv = AE::cv;
    $cv->begin;
    http_request(
        'GET' => $url,
        headers => {
            timeout => 10,
        },
        body => {},
        sub {
            my($content, $header) = @_;
            say $header->{Status};  
            $cv->end;
        }   
    );
    $cv->recv;
}