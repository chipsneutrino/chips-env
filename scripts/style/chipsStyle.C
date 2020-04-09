// To set this as default, you need a .rootrc file in your home directory,
// containing the following line:
// Rint.Logon: /full/path/to/chipsStyle.C

#ifndef CHIPSSTYLE_C
#define CHIPSSTYLE_C

#include "TColor.h"
#include "TH1.h"
#include "TLatex.h"
#include "TROOT.h"
#include "TStyle.h"

void chipsStyle()
{
    printf("Let's make it look cheap... \n");

    TStyle* chips_style = new TStyle("chips_style", "CHIPS Style");

    // Centre title
    chips_style->SetTitleAlign(22);
    chips_style->SetTitleX(.5);
    chips_style->SetTitleY(.95);
    chips_style->SetTitleBorderSize(0);

    // No info box
    chips_style->SetOptStat(0);

    //set the background color to white
    chips_style->SetFillColor(10);
    chips_style->SetFrameFillColor(10);
    chips_style->SetCanvasColor(10);
    chips_style->SetPadColor(10);
    chips_style->SetTitleFillColor(0);
    chips_style->SetStatColor(10);

    // Don't put a colored frame around the plots
    chips_style->SetFrameBorderMode(0);
    chips_style->SetCanvasBorderMode(0);
    chips_style->SetPadBorderMode(0);

    // Set the default line color for a fit function to be red
    chips_style->SetFuncColor(kRed);

    // Marker settings
    chips_style->SetMarkerStyle(kFullCircle);

    // No border on legends
    chips_style->SetLegendBorderSize(0);

    // Disabled for violating CHIPS style guidelines
    // Scientific notation on axes
    //TGaxis::SetMaxDigits(3);

    // Axis titles
    chips_style->SetTitleSize(.055, "xyz");
    chips_style->SetTitleOffset(.8, "xyz");
    // More space for y-axis to avoid clashing with big numbers
    chips_style->SetTitleOffset(.9, "y");
    // This applies the same settings to the overall plot title
    chips_style->SetTitleSize(.055, "");
    chips_style->SetTitleOffset(.8, "");
    // Axis labels (numbering)
    chips_style->SetLabelSize(.04, "xyz");
    chips_style->SetLabelOffset(.005, "xyz");

    // Prevent ROOT from occasionally automatically zero-suppressing
    chips_style->SetHistMinimumZero();

    // Thicker lines
    chips_style->SetHistLineWidth(2);
    chips_style->SetFrameLineWidth(2);
    chips_style->SetFuncWidth(2);

    // Set the number of tick marks to show
    chips_style->SetNdivisions(506, "xyz");

    // Set the tick mark style
    chips_style->SetPadTickX(1);
    chips_style->SetPadTickY(1);

    // Fonts
    const int kCHIPSFont = 42;
    chips_style->SetStatFont(kCHIPSFont);
    chips_style->SetLabelFont(kCHIPSFont, "xyz");
    chips_style->SetTitleFont(kCHIPSFont, "xyz");
    chips_style->SetTitleFont(kCHIPSFont, ""); // Apply same setting to plot titles
    chips_style->SetTextFont(kCHIPSFont);
    chips_style->SetLegendFont(kCHIPSFont);

    // Get moodier colours for colz
    const Int_t NRGBs = 5;
    const Int_t NCont = 255;
    Double_t stops[NRGBs] = { 0.00, 0.34, 0.61, 0.84, 1.00 };
    Double_t red[NRGBs]   = { 0.00, 0.00, 0.87, 1.00, 0.51 };
    Double_t green[NRGBs] = { 0.00, 0.81, 1.00, 0.20, 0.00 };
    Double_t blue[NRGBs]  = { 0.51, 1.00, 0.12, 0.00, 0.00 };
    TColor::CreateGradientColorTable(NRGBs, stops, red, green, blue, NCont);
    chips_style->SetNumberContours(NCont);

    gROOT->SetStyle("chips_style");

    // Uncomment this line if you want to force all plots loaded from files
    // to use this same style
    //gROOT->ForceStyle();
}

// Put a "CHIPS Preliminary" tag in the corner
void Preliminary()
{
    TLatex* prelim = new TLatex(.9, .95, "CHIPS Preliminary");
    prelim->SetTextColor(kBlue);
    prelim->SetNDC();
    prelim->SetTextSize(2/30.);
    prelim->SetTextAlign(32);
    prelim->Draw();
}

// Put a "CHIPS Preliminary" tag on the right
void PreliminarySide()
{
    TLatex* prelim = new TLatex(.93, .9, "CHIPS Preliminary");
    prelim->SetTextColor(kBlue);
    prelim->SetNDC();
    prelim->SetTextSize(2/30.);
    prelim->SetTextAngle(270);
    prelim->SetTextAlign(12);
    prelim->Draw();
}

// Put a "CHIPS Simulation" tag in the corner
void Simulation()
{
    TLatex* prelim = new TLatex(.9, .95, "CHIPS Simulation");
    prelim->SetTextColor(kGray+1);
    prelim->SetNDC();
    prelim->SetTextSize(2/30.);
    prelim->SetTextAlign(32);
    prelim->Draw();
}

// Put a "CHIPS Simulation" tag on the right
void SimulationSide()
{
    TLatex* prelim = new TLatex(.93, .9, "CHIPS Simulation");
    prelim->SetTextColor(kGray+1);
    prelim->SetNDC();
    prelim->SetTextSize(2/30.);
    prelim->SetTextAngle(270);
    prelim->SetTextAlign(12);
    prelim->Draw();
}

// Put a "CHIPS Fake Data" tag in the corner
void FakeData()
{
    TLatex* prelim = new TLatex(.9, .95, "CHIPS Fake Data");
    prelim->SetTextColor(kBlue);
    prelim->SetNDC();
    prelim->SetTextSize(2/30.);
    prelim->SetTextAlign(32);
    prelim->Draw();
}

// Add a label in top left corner
// Especially useful for "Neutrino Beam" and "Antineutrino Beam" labels
void CornerLabel(std::string Str) {
    TLatex* CornLab = new TLatex(.1, .93, Str.c_str());
    CornLab->SetTextColor(kGray+1);
    CornLab->SetNDC();
    CornLab->SetTextSize (2/30.);
    CornLab->SetTextAlign(11);
    CornLab->Draw();
}

void CenterTitles(TH1* histo)
{
    histo->GetXaxis()->CenterTitle();
    histo->GetYaxis()->CenterTitle();
    histo->GetZaxis()->CenterTitle();  
}

#endif
