#!/bin/bash

exec > >(tee make-all.log.txt) 2>&1

date -u +"%Y-%m-%d %H:%Mz"
echo

DP0=$( cd "$(dirname "$0")" ; pwd -P )

pushd "$DP0" >/dev/null

pushd "$DP0/burn" >/dev/null
if [ -f svg2svgpdfpng.bat ]; then rm svg2svgpdfpng.bat ; fi
if [ -f svg2svgpdfpng.sh  ]; then rm svg2svgpdfpng.sh  ; fi
if [ -d svg               ]; then find svg -mindepth 1 ! -name "README.md" -exec rm -rf {} +  ; fi
if [ -d pdf               ]; then find pdf -mindepth 1 ! -name "README.md" -exec rm -rf {} +  ; fi
if [ -d png               ]; then find png -mindepth 1 ! -name "README.md" -exec rm -rf {} +  ; fi
popd >/dev/null

# The error output is filtered for Inkscape warnings that appear innocuous
bash build/design2burn.sh $1 2>&1 | grep --line-buffered -v org.inkscape | grep --line-buffered -v "^\s*$" | grep --line-buffered -v "Could not parse:"
errorReturn=$?
if [ $errorReturn -ne 0 ]; then exit $errorReturn ; fi

# Any post-processing goes here:
#if [ -f burn/png/print/Print-10x10-PROFORMA.png ]
#then
#convert burn/png/print/Print-10x10-PROFORMA.png -rotate 225 -strip shared/PROFORMA.png
#fi 

popd >/dev/null
