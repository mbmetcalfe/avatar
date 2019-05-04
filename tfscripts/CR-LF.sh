echo "*** Converting CR-LF to LF ***"

for file in `find . -type f -print`; do
	echo "Converting $file ..."
	perl -i -pe 's:\r$::g' $file
done

echo " *** Done! ***"
