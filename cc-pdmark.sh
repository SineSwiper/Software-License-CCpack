#!/bin/bash

### This code basically just generates the license PMs on-the-fly ###

for CODE in PDM; do
	VER=1.0
	PACKAGE=CC_`echo $CODE | tr '-' '_'`_1_0
	URL=http://creativecommons.org/publicdomain/mark/$VER/
	LNAME="Public Domain Mark 1.0"
	META_NAME=unrestricted
	
	echo "use strict;
use warnings;
package Software::License::$PACKAGE;
use base 'Software::License';
# ABSTRACT: Creative Commons $LNAME

sub name { 'Creative Commons $LNAME' }
sub url  { '$URL' }

sub version    { '$VER' }
sub meta_name  { '$META_NAME' }

1;
__DATA__
__LICENSE__" > $PACKAGE.pm
	curl -s $URL |
		html2text -style pretty -width 77 |
		perl -e '$_ = join("", <>); s/\*\s*\n\s+(\w)/\* $1/gms; s/\n\n(\* to )/\n$1/g; s/\n{2,}/\n\n/gms; 
         s/^\* o Non-binding.+(\* Other Information)/$1/ms; print $_;' |
		perl -pe 's/\&mdash;|—/--/g; s/--  /-- /g;' |
		head -n -62 | tail -n +5 >> $PACKAGE.pm
done

# .html2textrc:
#
# P.vspace.before = 1
# OL.vspace.between = 1
# UL.vspace.between = 1
# DIR.vspace.between = 1
# MENU.vspace.between = 1
# DL.vspace.between = 1
# A.attributes.internal_link = NONE
# A.attributes.external_link = NONE
