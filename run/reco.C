void load_libs()
{
	gSystem->Load("libGeom");
	gSystem->Load("libEve");
	gSystem->Load("libMinuit");
	TString libWCSimRoot = TString::Format("%s%s", gSystem->Getenv("WCSIMHOME"), "/libWCSim.so");
	TString libWCSimAnalysis = TString::Format("%s%s", gSystem->Getenv("WCSIMANAHOME"), "/libWCSimAnalysis.so");
	gSystem->Load(libWCSimRoot.Data());
	gSystem->Load(libWCSimAnalysis.Data());	
}

void reco(const char * infile = "", int start = 0, int fit = 20) 
{
	load_libs();

	// Get a fitter interface...
	WCSimFitterInterface myFitter;

	// Set the input file, and say if you are modifying a WCSimAnalysis output file
	// This loads the data from the corresponding WCSim file appropriately
	myFitter.SetInputFileName(filename.Data(), false);

	// Set up the fit configuration you want to run...
	WCSimFitterConfig * config_el = new WCSimFitterConfig();
	config_el->SetNumTracks(1);
	config_el->SetTrackType(0, "ElectronLike");
	config_el->SetParameter(0, "kVtxX", -1200, 1200, 0.0, 10.0, false);
	config_el->SetParameter(0, "kVtxY", -1200, 1200, 0.0, 10.0, false);
	config_el->SetParameter(0, "kVtxZ", -600, 600, 0.0, 10.0, false);
	config_el->SetParameter(0, "kVtxT", -100, 10100, 5000, 1.0, false);
	config_el->SetParameter(0, "kDirTh", 0.0, TMath::Pi(), 0.5 * TMath::Pi(), 0.01, false);
	config_el->SetParameter(0, "kDirPhi", -1.0 * TMath::Pi(), 1.0 * TMath::Pi(), 0, 0.02, false);
	config_el->SetParameter(0, "kEnergy", 500, 5000, 1000, 250.0, false);
	config_el->SetParameter(0, "kConversionDistance", -50, 50, 0, 5.0, true);
	config_el->SetNumEventsToFit(fit);
	config_el->SetFirstEventToFit(start);

	WCSimFitterConfig * config_mu = new WCSimFitterConfig();
	config_mu->SetNumTracks(1);
	config_mu->SetTrackType(0, "MuonLike");
	config_mu->SetParameter(0, "kVtxX", -1200, 1200, 0.0, 10.0, false);
	config_mu->SetParameter(0, "kVtxY", -1200, 1200, 0.0, 10.0, false);
	config_mu->SetParameter(0, "kVtxZ", -600, 600, 0.0, 10.0, false);
	config_mu->SetParameter(0, "kVtxT", -100, 10100, 5000, 1.0, false);
	config_mu->SetParameter(0, "kDirTh", 0.0, TMath::Pi(), 0.5 * TMath::Pi(), 0.01, false);
	config_mu->SetParameter(0, "kDirPhi", -1.0 * TMath::Pi(), 1.0 * TMath::Pi(), 0, 0.02, false);
	config_mu->SetParameter(0, "kEnergy", 500, 5000, 1000, 250.0, false);
	config_mu->SetParameter(0, "kConversionDistance", -50, 50, 0, 5.0, true);
	config_mu->SetNumEventsToFit(fit);
	config_mu->SetFirstEventToFit(start);

	// Add the fitter configuration and plots, then run the fits...
	myFitter.AddFitterConfig(config_el);
	myFitter.AddFitterConfig(config_mu);
	myFitter.SetMakeFits(kTRUE);
	myFitter.Run();

	delete config_el;
	delete config_mu;
}
