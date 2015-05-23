#!/bin/sh
for f in $* ;do
 convert -geometry 24x24 $f t_$f
 echo "<a href=\"$f\"><img src=\"t_$f\" width=\"24\" height=\"24\"></a>"
done
# end of script


