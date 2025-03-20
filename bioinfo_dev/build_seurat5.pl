#!/usr/bin/env perl

use warnings;
use strict;
use Cwd 'abs_path';
use File::Basename;
use FindBin qw($Bin);

die "\n Usage: perl $0 <base_image> <github_token> \n\n" unless @ARGV == 2;

my $base_image = shift;
my $github_token = shift;

my ($image, $version) = split /:/, $base_image;

my $dockerfile = abs_path("$Bin/seurat5/Dockerfile");
my $wdir = dirname($dockerfile);

system("DOCKER_BUILDKIT=0 docker build --file $dockerfile -t ycli1995/${image}:${version}_seurat5 --build-arg FROM_IMAGE=${image} --build-arg FROM_VERSION=${version} --build-arg GITHUB_TOKEN=${github_token} $wdir");

