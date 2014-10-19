#!/bin/bash

### This code basically just generates the license PMs on-the-fly ###

LYNX='lynx -dump -width 77 -display_charset UTF-8 -nolist -nonumbers'

for VER in 1.0 2.0 3.0 4.0; do
   for CODE in BY BY-SA BY-NC BY-ND BY-NC-SA BY-NC-ND; do
      PACKAGE=CC_`echo $CODE"_"$VER | tr '.-' '__'`

      # V1.0 has this flipped
      if [ $PACKAGE == "CC_BY_NC_ND_1_0" ]; then
         CODE="BY-ND-NC"
         PACKAGE="CC_BY_ND_NC_1_0"
      fi

      URL=http://creativecommons.org/licenses/${CODE,,}/$VER/
      LNAME=`$LYNX $URL'legalcode' | head -20 | perl -pe 's/^\s+|\s+$//g; $_ = "" unless /'$VER'/'`
      META_NAME=restricted
      [ $CODE == "BY-SA" -o $CODE == "BY" ] && META_NAME=unrestricted

      echo "$PACKAGE.pm - $LNAME"

      echo "package Software::License::$PACKAGE;

use strict;
use warnings;

use base 'Software::License';

# AUTHORITY
# VERSION
# ABSTRACT: Creative Commons $LNAME License (CC $CODE $VER)

### NOTE: This file was auto-generated using cc-license.sh.  Do not edit this file!

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
      $LYNX $URL | perl -e '
         $_ = join("", <>);
         s/.+(?=You are free to:)//s;  # garbage above
         s/\s*(?:A new version of this license is available|The applicable mediation rules will be designated).+/\n/s;  # garbage below
         s/^\s+\*\s*\n\s*\n//m;  # weird blank bullet point
         s/^\s+Attribute this work:.+?\n\n(?=^\s+\*)//ms;  # more garbage
         print $_;
      ' >> $PACKAGE.pm
      echo "__LICENSE__" >> $PACKAGE.pm
      $LYNX $URL'legalcode' | head --lines='-2' | perl -e '
         $_ = join("", <>);
         s/^\s+(Creative Commons)\n\n\s+CC/$1/;  # garbage header on 4.0 licenses
         print $_;
      ' >> $PACKAGE.pm
   done
done
