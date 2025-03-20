#!/usr/bin/env perl

use warnings;
use strict;
use Cwd 'abs_path';
use File::Basename;

die "\n Usage: perl $0 <dockerfile> <ubuntu_version> \n\n" unless @ARGV == 2;

my $dockerfile = shift;
my $version = shift;

$dockerfile = abs_path($dockerfile);

my $wdir = dirname($dockerfile);

my $base_url = "https://ftp.heanet.ie/mirrors/ubuntu-cdimage/ubuntu-base/releases/";

my $dl_url = "${base_url}/${version}/release/ubuntu-base-${version}-base-amd64.tar.gz";

print $dl_url . "\n";

system("curl $dl_url --output ${wdir}/ubuntu-base.tar.gz && DOCKER_BUILDKIT=0 docker build --file $dockerfile -t ycli1995/ubuntu:$version $wdir && rm -f ${wdir}/ubuntu-base.tar.gz");

