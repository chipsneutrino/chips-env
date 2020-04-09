# This is a Python version of the standard chipsStyle.C code

# To be used with Python3.X with ROOT libs
# Can be added to one's Python code by importing it:
# from /path/to/chipsStyle import *

import array
from ROOT import TColor, TLatex, TStyle, gROOT, TGaxis

def chipsplotstyle():
    print("\nLet's make it look cheap... \n")

    chips_style = TStyle("chips_style", "CHIPS Style")

    # Center title
    chips_style.SetTitleAlign(22)
    chips_style.SetTitleX(.5)
    chips_style.SetTitleY(.95)
    chips_style.SetTitleBorderSize(0)

    # Remove stats box
    chips_style.SetOptStat(0)

    # Set background color to white
    chips_style.SetFillColor(10)
    chips_style.SetFrameFillColor(10)
    chips_style.SetCanvasColor(10)
    chips_style.SetPadColor(10)
    chips_style.SetTitleFillColor(0)
    chips_style.SetStatColor(10)

    # No colored frames around plots
    chips_style.SetFrameBorderMode(0)
    chips_style.SetCanvasBorderMode(0)
    chips_style.SetPadBorderMode(0)

    # Set the default line color for a fit function to be red
    chips_style.SetFuncColor(2)

    # Marker settings
    chips_style.SetMarkerStyle(20)

    # No border on legends
    chips_style.SetLegendBorderSize(0)

    # Disabled for violating NOvA style guidelines
    # Scientific notation on axes
    TGaxis.SetMaxDigits(3)

    # Axis titles
    chips_style.SetTitleSize(.055, "xyz")
    chips_style.SetTitleOffset(.8, "xyz")
    chips_style.SetTitleOffset(.9, "y")
    chips_style.SetTitleSize(.055, "")
    chips_style.SetTitleOffset(.8, "")

    # Axis labels (numbering)
    chips_style.SetLabelSize(.04, "xyz")
    chips_style.SetLabelOffset(.005, "xyz")

    # Set histogram minimum to exactly zero
    chips_style.SetHistMinimumZero()