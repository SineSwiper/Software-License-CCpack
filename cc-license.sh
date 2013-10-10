#!/bin/bash

### This code basically just generates the license PMs on-the-fly ###

for CODE in BY BY-SA BY-NC BY-ND BY-NC-SA BY-NC-ND; do
	VER=3.0
	PACKAGE=CC_`echo $CODE | tr '-' '_'`_3_0
	URL=http://creativecommons.org/licenses/${CODE,,}/$VER/
	LNAME=`curl -s $URL'legalcode' | html2text -style pretty | head -14 | tail -1 | perl -pe 's/\n//g;'`
	META_NAME=restricted
	[ $CODE == "BY-SA" -o $CODE == "BY" ] && META_NAME=unrestricted
	
	echo "use strict;
use warnings;
package Software::License::$PACKAGE;
use base 'Software::License';
# ABSTRACT: Creative Commons $LNAME License (CC $CODE $VER)

sub name { 'Creative Commons $LNAME License (CC $CODE $VER)' }
sub url  { '$URL' }

sub version    { '$VER' }
sub meta_name  { '$META_NAME' }

1;
__DATA__
__NOTICE__
This work, created by {{\$self->holder}}, is licensed under a
Creative Commons $LNAME License.
" > $PACKAGE.pm
	curl -s $URL |
		html2text -style pretty -width 77 |
		perl -e '$_ = join("", <>); s/  Attribute this work:.+^  others can find the original work as well.\n//ms;
		s/\*\s*\n\s+(\w)/\* $1/gms; s/(You are free:)/$1\n/g; s/\n\n(\* to )/\n$1/g; s/\n{2,}/\n\n/gms; print $_;' |
		perl -pe 's/\&mdash;|—/--/g; s/--  /-- /g;' |
		head -n -54 | tail -n +29 >> $PACKAGE.pm
	echo "__LICENSE__" >> $PACKAGE.pm
	curl -s $URL'legalcode' | 
		html2text -style pretty -width 77 | 
		perl -e '$_ = join("", <>); s/\n{2,}/\n\n/gms; s/(\*|^  \w\.)\s*\n\s+(\w)/$1 $2/gms; print $_;' |
		perl -pe 's/\&mdash;|—/--/g; s/--  /-- /g;' |
		head -n -25 | tail -n +5 >> $PACKAGE.pm
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
