#!/bin/bash

### This code basically just generates the license PMs on-the-fly ###

PMDIR='lib/Software/License'
LYNX='lynx -dump -width 85 -display_charset US-ASCII -nolist -nonumbers'

for VER in 1.0; do
   for CODE in PDM; do
      PACKAGE=CC_`echo $CODE"_"$VER | tr '.-' '__'`
      URL=http://creativecommons.org/publicdomain/mark/$VER/
      LNAME="Public Domain Mark 1.0"
      META_NAME=unrestricted

      echo "$PACKAGE.pm - $LNAME"

      echo "package Software::License::$PACKAGE;

use strict;
use warnings;

use base 'Software::License';

# AUTHORITY
# VERSION
# ABSTRACT: Creative Commons $LNAME

### NOTE: This file was auto-generated using cc-pdmark.sh.  Do not edit this file!

sub name { 'Creative Commons $LNAME' }
sub url  { '$URL' }

sub version    { '$VER' }
sub meta_name  { '$META_NAME' }

1;
__DATA__
__LICENSE__" > $PMDIR/$PACKAGE.pm
      $LYNX $URL | perl -e '
         $_ = join("", <>);
         s/.+?\n(?=Public Domain Mark)//sm;                       # garbage above
         s/\n\s*Endorsement.+/\n/gs;                              # garbage below
         s/ ( You can copy, modify, distribute)/\*$1/;            # missing bullet point
         s/^\s+\*\n//ms;                                          #   extra bullet point
         s/^\s+\+ Non-binding use guidelines.+?\n(?=^\s+\*)//ms;  # more garbage
         s/^[ ]{5}(?=\*)/   /gm;                                  # reduce to 3 spaces per bullet point
         s/^[ ]{10}(?=\+)/      /gm;                              # reduce to 6 spaces per plus point
         s/^[ ]{7}(?=\w)/     /gm;                                # adjust bullet word indents (star)
         s/^[ ]{12}(?=\w)/        /gm;                            # adjust bullet word indents (plus)
         s/\S+\n\K(?=[ ]+[*+])/\n/g;                              # add blank lines before each bullet point
         print $_;
      ' >> $PMDIR/$PACKAGE.pm
   done
done
