#!/usr/bin/env perl

use warnings;
use strict;
use Cwd 'abs_path';
use File::Basename;
use FindBin qw($Bin);

die "\n Usage: perl $0 <base_image> \n\n" unless @ARGV == 1;

my $base_image = shift;

my ($image, $version) = split /:/, $base_image;

my $dockerfile = abs_path("$Bin/jupyter/Dockerfile");
my $wdir = dirname($dockerfile);

system("DOCKER_BUILDKIT=0 docker build --file $dockerfile -t ycli1995/${image}:${version}_jupyter --build-arg FROM_IMAGE=${image} --build-arg FROM_VERSION=${version} $wdir");

