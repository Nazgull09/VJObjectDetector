for f in $* ;do
 if echo "$f" | grep -i "ppm$" > /dev/null ; then
   gif=`echo "$f" | sed 's/ppm$/bmp/i'`
   echo "преобразовывается  $f в $bmp ..."
   convert 24x24 $f $bmp
 else
   echo echo "$f не ppm файл, пропущен"
 fi
done
