/*
    ROOT Macro to generate plots from the output of WCSim
    Author: Josh Tingey
    Email: j.tingey.16@ucl.ac.uk
*/

void sim_plots(const char* in_dir, const char* out_name="test.root", int pdg=11, 
               bool all_plots=false, int max_events=20000, double d_height=1200)
{
    gStyle->SetOptStat(1101); // We want to plot all the info about the histograms

	// Load the WCSim we need...
    TString libWCSimRoot = TString::Format("%s%s",gSystem->Getenv("WCSIMHOME"), "/libWCSimRoot.so");
    gSystem->Load(libWCSimRoot.Data());

    // Parameter Distribution Histograms
    TH1D* hVtxX = new TH1D("vtxX", "vtxX", 50, -1200, 1200); 
    hVtxX->GetXaxis()->SetTitle("vtxX [cm]"); 
    hVtxX->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hVtxY = new TH1D("vtxY", "vtxY", 50, -1200, 1200); 
    hVtxY->GetXaxis()->SetTitle("vtxY [cm]"); 
    hVtxY->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hVtxZ = new TH1D("vtxZ", "vtxZ", 50, -(d_height/2), (d_height/2)); 
    hVtxZ->GetXaxis()->SetTitle("vtxZ [cm]"); 
    hVtxZ->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hVtxT = new TH1D("vtxT", "vtxT", 50, -100, 10100); 
    hVtxT->GetXaxis()->SetTitle("vtxT [ns]"); 
    hVtxT->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hDirX = new TH1D("dirX", "dirX", 50, -1, 1); 
    hDirX->GetXaxis()->SetTitle("dirX"); 
    hDirX->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hDirY = new TH1D("dirY", "dirY", 50, -1, 1); 
    hDirY->GetXaxis()->SetTitle("dirY"); 
    hDirY->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hDirZ = new TH1D("dirZ", "dirZ", 50, -1, 1); 
    hDirZ->GetXaxis()->SetTitle("dirZ"); 
    hDirZ->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hDirTheta = new TH1D("dirTheta", "dirTheta", 50, 0, TMath::Pi()); 
    hDirTheta->GetXaxis()->SetTitle("dirTheta [sin(theta)]"); 
    hDirTheta->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hDirPhi = new TH1D("dirPhi", "dirPhi", 50, -TMath::Pi(), TMath::Pi()); 
    hDirPhi->GetXaxis()->SetTitle("dirPhi [degrees]"); 
    hDirPhi->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hNuEnergy = new TH1D("nuEnergy", "nuEnergy", 50, 500, 5000); 
    hNuEnergy->GetXaxis()->SetTitle("nuEnergy [MeV]"); 
    hNuEnergy->GetYaxis()->SetTitle("Fraction of Events");
    TH1D* hLepEnergy = new TH1D("lepEnergy", "lepEnergy", 50, 500, 5000); 
    hLepEnergy->GetXaxis()->SetTitle("lepEnergy [MeV]"); 
    hLepEnergy->GetYaxis()->SetTitle("Fraction of Events");

    // Hit and Charge Histograms
    TH1D *hHits = new TH1D("hits", "hits", 50, 0, 5000); 
    hHits->GetXaxis()->SetTitle("Hits"); 
    hHits->GetYaxis()->SetTitle("Fraction of Events");
    TH1D *hDigiHits = new TH1D("digiHits", "digiHits", 50, 0, 5000); 
    hDigiHits->GetXaxis()->SetTitle("Digitised Hits"); 
    hDigiHits->GetYaxis()->SetTitle("Fraction of Events");
    TH1D *hCharge = new TH1D("charge", "charge", 50, 0, 10000); 
    hCharge->GetXaxis()->SetTitle("Charge"); 
    hCharge->GetYaxis()->SetTitle("Fraction of Events");

    // Particle PDG Histogram
    TH1D *hpdg = new TH1D("pdg", "pdg", 20000, -10000, 10000); 
    hpdg->GetXaxis()->SetTitle("pdg"); 
    hpdg->GetYaxis()->SetTitle("Fraction of Events");

    // Hit Position Histograms
    TH1D *hHitX = new TH1D("hitX", "hitX", 50, -1300, 1300); 
    hHitX->SetTitle("hit x-position [cm]"); 
    hHitX->GetYaxis()->SetTitle("Fraction of Hits");
    TH1D *hHitY = new TH1D("hitY", "hitY", 50, -1300, 1300); 
    hHitY->SetTitle("hit y-position [cm]"); 
    hHitY->GetYaxis()->SetTitle("Fraction of Hits");
    TH1D *hHitZ = new TH1D("hitZ", "hitZ", 50, -610, 610); 
    hHitZ->SetTitle("hit z-position [cm]"); 
    hHitZ->GetYaxis()->SetTitle("Fraction of Hits");
    TH2D *hHitBarrel = new TH2D("hitBarrel", "hitBarrel", 50, -TMath::Pi(), TMath::Pi(), 50, -(d_height/2), (d_height/2)); 
    hHitBarrel->SetTitle("hit phi-position [rad]"); 
    hHitBarrel->SetTitle("hit z-position [cm]");
    TH2D *hHitEndcap = new TH2D("hitEndcap", "hitEndcap", 50, -1300, 1300, 50, -1300, 1300); 
    hHitEndcap->GetXaxis()->SetTitle("hit x-position [cm]");
    hHitEndcap->GetYaxis()->SetTitle("hit y-position [cm]");

    // Loop through all the files in the input directory
    char* directory = gSystem->ExpandPathName(in_dir);
    void* dirp = gSystem->OpenDirectory(directory);
    TString str;
    int n=0;
    while((str = gSystem->GetDirEntry(dirp)))
    {
        if(n>=max_events) break;
        if(str.EndsWith(".root"))
        {
            std::cout << "Processing File " << str << " ..." << std::endl;
            TFile * inputFile = new TFile(gSystem->ConcatFileName(directory, str), "READ");

            if(!inputFile->GetListOfKeys()->Contains("wcsimT"))
            { 
                std::cout << "Skipping File" << std::endl; continue;
            }

            // Get main tree
            TTree *mainTree = (TTree*)inputFile->Get("wcsimT");
            int nevent = mainTree->GetEntries();
            WCSimRootEvent* wcsimrootsuperevent = new WCSimRootEvent();
            TBranch *branch = mainTree->GetBranch("wcsimrootevent");
            branch->SetAddress(&wcsimrootsuperevent);
            mainTree->GetBranch("wcsimrootevent")->SetAutoDelete(kTRUE);
            WCSimRootTrigger* wcsimrootevent;

            // Get the geometry tree
            TTree *gtree = (TTree*)inputFile->Get("wcsimGeoT");
            WCSimRootGeom* wcsimrootgeom = new WCSimRootGeom();
            TBranch *geoBranch = gtree->GetBranch("wcsimrootgeom");
            geoBranch->SetAddress(&wcsimrootgeom);
            gtree->GetEntry(0);

            WCSimTruthSummary truthSum;
            for(int evt=0; evt<nevent; evt++)
            {
                if (n % 100 == 0) std::cout << n << std::endl;
                n++;
                if(n>=max_events) break;
            	mainTree->GetEntry(evt);
            	wcsimrootevent = wcsimrootsuperevent->GetTrigger(0);

                truthSum = wcsimrootsuperevent->GetTruthSummary(); // Get truth summary

                // Loop through primaries to find the desired particle...
                for(int p=0; p < truthSum.GetNPrimaries(); p++)
                {
                    int code = truthSum.GetPrimaryPDG(p);
                    hpdg->Fill(code);
                    if (code == pdg) 
                    {
                        hVtxX->Fill(truthSum.GetVertexX()/10);
                        hVtxY->Fill(truthSum.GetVertexY()/10);
                        hVtxZ->Fill(truthSum.GetVertexZ()/10);
                        hVtxT->Fill(truthSum.GetVertexT());

                        TVector3 dir = truthSum.GetPrimaryDir(p);
                        hDirX->Fill(dir.X());
                        hDirY->Fill(dir.Y());
                        hDirZ->Fill(dir.Z());

                        double dirPhi, dirTheta;
                        if (dir.X() > 0 && dir.Y() < 0)      { dirPhi = TMath::ATan(dir.Y()/dir.X()); }
                        else if (dir.X() < 0 && dir.Y() < 0) { dirPhi = TMath::ATan(dir.Y()/dir.X()) - TMath::Pi(); }
                        else if (dir.X() < 0 && dir.Y() > 0) { dirPhi = TMath::ATan(dir.Y()/dir.X()) + TMath::Pi(); }
                        else if (dir.X() > 0 && dir.Y() > 0) { dirPhi = TMath::ATan(dir.Y()/dir.X()); }  
                        else { std::cout << "Error: Can't find barrel phi dir angle!" << std::endl; }

                        dirTheta = TMath::ATan(dir.Z()/(sqrt(pow(dir.X(),2) + pow(dir.Y(),2))));

                        hDirTheta->Fill(TMath::ACos(dir.Z()));
                        hDirPhi->Fill(TMath::ATan(dir.Y()/dir.X()));
                        hLepEnergy->Fill(truthSum.GetPrimaryEnergy(p));                        
                    }
                }

                int ncherenkovhits = wcsimrootevent->GetNcherenkovhits();
                int ncherenkovdigihits = wcsimrootevent->GetNcherenkovdigihits();
                int totalQ = 0;
                // Loop through the digi hits...
                for(int h=0; h<ncherenkovdigihits; h++)
                {
                    TObject *element = (wcsimrootevent->GetCherenkovDigiHits())->At(h);
                    WCSimRootCherenkovDigiHit *wcsimrootcherenkovdigihit = dynamic_cast<WCSimRootCherenkovDigiHit*>(element);

                    totalQ += wcsimrootcherenkovdigihit->GetQ();

                    if (all_plots) 
                    {
                        WCSimRootPMT pmt = wcsimrootgeom->GetPMTFromArray(wcsimrootcherenkovdigihit->GetTubeId());
 
                        double hitX = pmt.GetPosition(0);
                        double hitY = pmt.GetPosition(1);
                        double hitZ = pmt.GetPosition(2);
                        if (hitX == 0.0) {continue;}

                        hHitX->Fill(hitX);
                        hHitY->Fill(hitY);
                        hHitZ->Fill(hitZ);
    
                        if (hitZ>((d_height/2)-10) || hitZ<-((d_height/2)-10) ) 
                        {
                            hHitEndcap->Fill(hitX,hitY);
                        } 
                        else 
                        {
                            double hitPhi;
                            if (hitX > 0 && hitY < 0) {hitPhi = TMath::ATan(hitY/hitX);}
                            if (hitX < 0 && hitY < 0) {hitPhi = TMath::ATan(hitY/hitX) - TMath::Pi();}
                            if (hitX < 0 && hitY > 0) {hitPhi = TMath::ATan(hitY/hitX) + TMath::Pi();}
                            if (hitX > 0 && hitY > 0) {hitPhi = TMath::ATan(hitY/hitX);}
                            hHitBarrel->Fill(hitPhi,hitZ);
                        }
                    }
                }   
                hHits->Fill(ncherenkovhits);
                hDigiHits->Fill(ncherenkovdigihits);
                hCharge->Fill(totalQ);
                        
                wcsimrootsuperevent->ReInitialize();
            }




        } 
    }

    // Normalise all the histograms to account for the different number of events included in each...
    if (hVtxX->GetEntries()>0) {hVtxX->Scale( 1/(hVtxX->GetEntries()) );}
    if (hVtxY->GetEntries()>0) {hVtxY->Scale( 1/(hVtxY->GetEntries()) );}
    if (hVtxZ->GetEntries()>0) {hVtxZ->Scale( 1/(hVtxZ->GetEntries()) );}
    if (hVtxT->GetEntries()>0) {hVtxT->Scale( 1/(hVtxT->GetEntries()) );}
    if (hDirX->GetEntries()>0) {hDirX->Scale( 1/(hDirX->GetEntries()) );}
    if (hDirY->GetEntries()>0) {hDirY->Scale( 1/(hDirY->GetEntries()) );}
    if (hDirZ->GetEntries()>0) {hDirZ->Scale( 1/(hDirZ->GetEntries()) );}
    if (hDirTheta->GetEntries()>0) {hDirTheta->Scale( 1/(hDirTheta->GetEntries()) );}
    if (hDirPhi->GetEntries()>0) {hDirPhi->Scale( 1/(hDirPhi->GetEntries()) );}
    if (hLepEnergy->GetEntries()>0) {hLepEnergy->Scale( 1/(hLepEnergy->GetEntries()) );}

    if (hHits->GetEntries()>0) {hHits->Scale( 1/(hHits->GetEntries()) );}
    if (hDigiHits->GetEntries()>0) {hDigiHits->Scale( 1/(hDigiHits->GetEntries()) );}
    if (hCharge->GetEntries()>0) {hCharge->Scale( 1/(hCharge->GetEntries()) );}

    if (hpdg->GetEntries()>0) {hpdg->Scale( 1/(hpdg->GetEntries()) );}

    if (all_plots) {
        if (hHitX->GetEntries()>0) {hHitX->Scale( 1/(hHitX->GetEntries()) );}
        if (hHitY->GetEntries()>0) {hHitY->Scale( 1/(hHitY->GetEntries()) );}
        if (hHitZ->GetEntries()>0) {hHitZ->Scale( 1/(hHitZ->GetEntries()) );}
        if (hHitBarrel->GetEntries()>0) {hHitBarrel->Scale( 1/(hHitBarrel->GetEntries()) );}
        if (hHitEndcap->GetEntries()>0) {hHitEndcap->Scale( 1/(hHitEndcap->GetEntries()) );}
    }

    TFile * mainOutput = new TFile(out_name,"RECREATE");

    hVtxX->Write();
    hVtxY->Write();
    hVtxZ->Write();
    hVtxT->Write();
    hDirX->Write();
    hDirY->Write();
    hDirZ->Write();
    hDirTheta->Write();
    hDirPhi->Write();
    hLepEnergy->Write();

    hHits->Write();
    hDigiHits->Write();
    hCharge->Write();

    hpdg->Write();

    if (all_plots) {
        hHitX->Write();
        hHitY->Write();
        hHitZ->Write();
        hHitBarrel->Write();
        hHitEndcap->Write();
    }

    mainOutput->Close();
}
