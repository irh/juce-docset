#!/bin/sh

git submodule update --init

cd juce/doxygen
sed -i.bak \
  -e 's/.*GENERATE_DOCSET.*= NO.*/GENERATE_DOCSET = YES/' \
  -e 's/.*DISABLE_INDEX.*= NO.*/DISABLE_INDEX = YES/' \
  -e 's/.*SEARCHENGINE.*= YES.*/SEARCHENGINE = NO/' \
  -e 's/.*GENERATE_TREEVIEW.*= YES.*/GENERATE_TREEVIEW = NO/' \
  -e 's/.*HTML_HEADER.*=.*/HTML_HEADER = ..\/..\/header.html/' \
  Doxyfile
doxygen
cd doc
make
cp -r org.doxygen.Project.docset ../../../JUCE.docset
cd ../../..

iconPath=JUCE/extras/Projucer/Source/BinaryData/juce_icon.png
convert $iconPath -resize 16x16 JUCE.docset/Icon.png
convert $iconPath -resize 32x32 JUCE.docset/Icon@2x.png

tar --exclude='.DS_Store' -cvzf JUCE.tgz JUCE.docset
