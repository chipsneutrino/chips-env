#! /bin/bash

DATA=scripts/gen/*.o*

rm -rf $PRODDIR/beam_all/nuel/$DATA
rm -rf $PRODDIR/beam_all/anuel/$DATA
rm -rf $PRODDIR/beam_all/numu/$DATA
rm -rf $PRODDIR/beam_all/anumu/$DATA

rm -rf $PRODDIR/beam_nuel/cccoh/$DATA
rm -rf $PRODDIR/beam_nuel/nccoh/$DATA
rm -rf $PRODDIR/beam_nuel/ccdis/$DATA
rm -rf $PRODDIR/beam_nuel/ncdis/$DATA
rm -rf $PRODDIR/beam_nuel/ccqel/$DATA
rm -rf $PRODDIR/beam_nuel/ncqel/$DATA
rm -rf $PRODDIR/beam_nuel/ccres/$DATA
rm -rf $PRODDIR/beam_nuel/ncres/$DATA
rm -rf $PRODDIR/beam_nuel/charmccqel/$DATA
rm -rf $PRODDIR/beam_nuel/nueelastic/$DATA
rm -rf $PRODDIR/beam_nuel/imd/$DATA
rm -rf $PRODDIR/beam_nuel/ccmec/$DATA
rm -rf $PRODDIR/beam_nuel/ncmec/$DATA

rm -rf $PRODDIR/beam_numu/cccoh/$DATA
rm -rf $PRODDIR/beam_numu/nccoh/$DATA
rm -rf $PRODDIR/beam_numu/ccdis/$DATA
rm -rf $PRODDIR/beam_numu/ncdis/$DATA
rm -rf $PRODDIR/beam_numu/ccqel/$DATA
rm -rf $PRODDIR/beam_numu/ncqel/$DATA
rm -rf $PRODDIR/beam_numu/ccres/$DATA
rm -rf $PRODDIR/beam_numu/ncres/$DATA
rm -rf $PRODDIR/beam_numu/charmccqel/$DATA
rm -rf $PRODDIR/beam_numu/nueelastic/$DATA
rm -rf $PRODDIR/beam_numu/imd/$DATA
rm -rf $PRODDIR/beam_numu/ccmec/$DATA
rm -rf $PRODDIR/beam_numu/ncmec/$DATA

rm -rf $PRODDIR/cosmic_all/$DATA