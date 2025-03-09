DP0=$( cd "$(dirname "$0")" ; pwd -P )
pushd "$DP0/../burn" >/dev/null

ss=stylesheet-not-found-designSVG2burnFiles.xsl
if [ -f ../../designSVG2burnFiles/designSVG2burnFiles.xsl ]; then ss=../../designSVG2burnFiles/designSVG2burnFiles.xsl ; fi
if [ -f ../utilities/designSVG2burnFiles/designSVG2burnFiles.xsl ]; then ss=../utilities/designSVG2burnFiles/designSVG2burnFiles.xsl ; fi

java -jar ../utilities/saxon9he/saxon9he.jar -s:../design/design-$1.svg -xsl:$ss -o:svg2svgpdfpng.sh path2svg=svg/ path2png=png/ path2pdf=pdf/ name-suffix=-$1 minimum-stroke-width=.003in cut-colour=ff00ff cut-width=.001in

errorReturn=$?
if [ $errorReturn -ne 0 ]; then exit $errorReturn ; fi
if [ -f svg2svgpdfpng.sh ]; then sh svg2svgpdfpng.sh ; fi
popd >/dev/null
