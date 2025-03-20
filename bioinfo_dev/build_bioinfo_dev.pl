#!/usr/bin/env perl

use warnings;
use strict;
use Cwd 'abs_path';
use File::Basename;
use FindBin qw($Bin);

die "\n Usage: perl $0 <base_image> <image_version> <github_token> \n\n" unless @ARGV == 3;

my $base_image = shift;
my $image_version = shift;
my $github_token = shift;

my ($image, $version) = split /:/, $base_image;

my $dockerfile = abs_path("$Bin/$image_version/Dockerfile");
my $wdir = abs_path($Bin);

system("DOCKER_BUILDKIT=0 docker build --file $dockerfile -t ycli1995/bioinfo_dev:$image_version --build-arg FROM_IMAGE=$image --build-arg FROM_VERSION=$version --build-arg GITHUB_TOKEN=$github_token $wdir");


