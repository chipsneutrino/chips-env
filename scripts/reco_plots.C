void testReco(){
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Change this section...
    //

	// Cut parameters ////////////////
	bool useEscapes = false;
	double cutLowEnergy = 550;
    double cutHighEnergy = 4950;
    double cutRadius = 12000;
	double cutLowVtxX = -13000;
	double cutHighVtxX = 13000;

	// Default Cuts: E<550, E>4950, vtx<50cm from edge, Escapes

	bool makeFits = true;
	int maxNumFiles = 500;

	gStyle->SetOptStat(1101);
    //gStyle->SetOptStat(0);

	std::string inputDir = "/unix/chips/jtingey/CHIPS/data/CVN/data/nuel_cc_qe/NuMI/wc_Chips_1200_el_mu";
	double cutHeight = 7000;
	double detectorHeight = 1200;

	std::string outputDir = "/unix/chips/jtingey/CHIPS/data/CVN/outputPlots/wcsimAnalysisOutput/";
    //
    // End of user changes!
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

	std::cout << "#### START ####" << std::endl;

	// Load the libraries we need...
	std::cout << "Loading libraries..." << std::endl;
    gSystem->Load("libGeom");
    gSystem->Load("libEve");
    gSystem->Load("libMinuit");
    TString libWCSimRoot = TString::Format("%s%s",gSystem->Getenv("WCSIMHOME"), "/libWCSimRoot.so");
    TString libWCSimAnalysis = TString::Format("%s%s",gSystem->Getenv("WCSIMANAHOME"), "/lib/libWCSimAnalysis.so");
    gSystem->Load(libWCSimRoot.Data());
    gSystem->Load(libWCSimAnalysis.Data());

	// Find what type of events we are looking at...
	std::size_t pos;
	std::string name;
	int PDGcode;
	std::string macName = inputDir.substr(inputDir.find("wc"));
	if ((pos = inputDir.find("nue_cc_flux")) != string::npos) {
    	name = macName + "_" + inputDir.substr (pos,6);  
		PDGcode = 11;
	} else if ((pos = inputDir.find("nuel_cc_flux")) != string::npos) {
    	name = macName + "_" + inputDir.substr (pos,7);  
		PDGcode = 11;
	} else if ((pos = inputDir.find("nuel_cc_qe")) != string::npos) {
    	name = macName + "_" + inputDir.substr (pos,10);  
		PDGcode = 11;
	} else if ((pos = inputDir.find("nuel_cc_nonqe")) != string::npos) {
    	name = macName + "_" + inputDir.substr (pos,13);  
		PDGcode = 11;
	} else if ((pos = inputDir.find("numu_cc_flux")) != string::npos) {
    	name = macName + "_" + inputDir.substr (pos,7);  
		PDGcode = 13;
	} else if ((pos = inputDir.find("numu_cc_qe")) != string::npos) {
    	name = macName + "_" + inputDir.substr (pos,10);  
		PDGcode = 13;
	} else if ((pos = inputDir.find("numu_cc_nonqe")) != string::npos) {
    	name = macName + "_" + inputDir.substr (pos,13);  
		PDGcode = 13;
	} else if ((pos = inputDir.find("nue_all_flux")) != string::npos) {
    	name = macName + "_" + inputDir.substr (pos,7); 
		PDGcode = 11; 
	} else if ((pos = inputDir.find("numu_all_flux")) != string::npos) {
    	name = macName + "_" + inputDir.substr (pos,8);  
		PDGcode = 13;
	} else {
		std::cout << "Error: Don't recognise event type!" << std::endl;
		return;
	}

	std::string outputFileString = outputDir + name + ".root";
	const char * outputFile = outputFileString.c_str();

	std::cout << "Processing files from directory ->" << inputDir << std::endl;
	std::cout << "Will save output to file -> " << outputFile << std::endl << std::endl;

	std::cout << "Making Histograms..." << std::endl;
	// How many different types of event are there? CC, NC, CCQE etc...
    const int numTypes = 2;
	std::string types[numTypes] = {"CCQE", "CCNQE"};

    // (Truth - Reconstructed) Parameter Resolution Histograms
    TH1D **hVtxPos_tr = new TH1D*[numTypes];
    TH1D **hVtxX_tr = new TH1D*[numTypes];
    TH1D **hVtxY_tr = new TH1D*[numTypes];
    TH1D **hVtxZ_tr = new TH1D*[numTypes];
    TH1D **hVtxT_tr = new TH1D*[numTypes];
    TH1D **hDirX_tr = new TH1D*[numTypes];
    TH1D **hDirY_tr = new TH1D*[numTypes];
    TH1D **hDirZ_tr = new TH1D*[numTypes];
	TH1D **hDirTheta_tr = new TH1D*[numTypes];
	TH1D **hDirPhi_tr = new TH1D*[numTypes];
	TH1D **hAngle_tr = new TH1D*[numTypes];
    TH1D **hEnergy_tr = new TH1D*[numTypes];

	// Included Parameter Histograms
    TH1D **hVtxX_inc = new TH1D*[numTypes];
    TH1D **hVtxY_inc = new TH1D*[numTypes];
    TH1D **hVtxZ_inc = new TH1D*[numTypes];
    TH1D **hVtxT_inc = new TH1D*[numTypes];
    TH1D **hDirX_inc = new TH1D*[numTypes];
    TH1D **hDirY_inc = new TH1D*[numTypes];
    TH1D **hDirZ_inc = new TH1D*[numTypes];
	TH1D **hDirTheta_inc = new TH1D*[numTypes];
	TH1D **hDirPhi_inc = new TH1D*[numTypes];
	TH1D **hAngle_inc = new TH1D*[numTypes];
    TH1D **hEnergy_inc = new TH1D*[numTypes];

	// Cut Parameter Histograms
	TH1D **hVtxX_cut = new TH1D*[numTypes];
    TH1D **hVtxY_cut = new TH1D*[numTypes];
    TH1D **hVtxZ_cut = new TH1D*[numTypes];
    TH1D **hVtxT_cut = new TH1D*[numTypes];
    TH1D **hDirX_cut = new TH1D*[numTypes];
    TH1D **hDirY_cut = new TH1D*[numTypes];
    TH1D **hDirZ_cut = new TH1D*[numTypes];
	TH1D **hDirTheta_cut = new TH1D*[numTypes];
	TH1D **hDirPhi_cut = new TH1D*[numTypes];
	TH1D **hAngle_cut = new TH1D*[numTypes];
    TH1D **hEnergy_cut = new TH1D*[numTypes];

    for (int type = 0; type < numTypes; type ++) {
		std::cout << std::endl << "For type -> " << types[type] <<  std::endl;

		std::string nameString;
		const char * histName;

        // (Truth - Reconstructed) Parameter Resolution Histograms
		nameString = "hVtxPos_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxPos_tr[type] = new TH1D(histName, histName, 50, 0, 5000); 
		hVtxPos_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Vertex Position [mm]");
		hVtxPos_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
		//hVtxPos_tr[type]->GetSumw2()->Set(1);

		nameString = "hVtxX_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxX_tr[type] = new TH1D(histName, histName, 50, -2000, 2000);
    	hVtxX_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Vertex X-Position [mm]");
    	hVtxX_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hVtxX_tr[type]->GetSumw2()->Set(1);

		nameString = "hVtxY_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxY_tr[type] = new TH1D(histName, histName, 50, -2000, 2000);
    	hVtxY_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Vertex Y-Position [mm]");
    	hVtxY_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hVtxY_tr[type]->GetSumw2()->Set(1);

		nameString = "hVtxZ_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxZ_tr[type] = new TH1D(histName, histName, 50, -2000, 2000);
    	hVtxZ_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Vertex Z-Position [mm]");
    	hVtxZ_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hVtxZ_tr[type]->GetSumw2()->Set(1);

		nameString = "hVtxT_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxT_tr[type] = new TH1D(histName, histName, 50, -10, 10);
    	hVtxT_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Vertex Time [ns]");
    	hVtxT_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hVtxT_tr[type]->GetSumw2()->Set(1);

		nameString = "hDirX_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirX_tr[type] = new TH1D(histName, histName, 50, -0.30, 0.30);
    	hDirX_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track X-Direction");
    	hDirX_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hDirX_tr[type]->GetSumw2()->Set(1);

		nameString = "hDirY_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirY_tr[type] = new TH1D(histName, histName, 50, -0.30, 0.30);
    	hDirY_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Y-Direction");
    	hDirY_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hDirY_tr[type]->GetSumw2()->Set(1);

		nameString = "hDirZ_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirZ_tr[type] = new TH1D(histName, histName, 50, -0.30, 0.30);
    	hDirZ_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Z-Direction");
    	hDirZ_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hDirZ_tr[type]->GetSumw2()->Set(1);

		nameString = "hDirTheta_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirTheta_tr[type] = new TH1D(histName, histName, 50, -1, 1);
    	hDirTheta_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Theta-Direction [radians]");
    	hDirTheta_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hDirTheta_tr[type]->GetSumw2()->Set(1);

		nameString = "hDirPhi_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirPhi_tr[type] = new TH1D(histName, histName, 50, -1, 1);
    	hDirPhi_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Phi-Direction [radians]");
    	hDirPhi_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hDirPhi_tr[type]->GetSumw2()->Set(1);

		nameString = "hAngle_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hAngle_tr[type] = new TH1D(histName, histName, 50, 0, 10);
    	hAngle_tr[type]->GetXaxis()->SetTitle("(Truth - Reconstructed) Track Direction [degrees]");
    	hAngle_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hAngle_tr[type]->GetSumw2()->Set(1);

		nameString = "hEnergy_tr_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hEnergy_tr[type] = new TH1D(histName, histName, 50, -1, 1);
    	hEnergy_tr[type]->GetXaxis()->SetTitle("(Truth-Reconstructed)/Truth Track Energy [MeV]");
    	hEnergy_tr[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hEnergy_tr[type]->GetSumw2()->Set(1);

		// Included Parameter Histograms
		nameString = "hVtxX_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxX_inc[type] = new TH1D(histName, histName, 100, -13000, 13000);
    	hVtxX_inc[type]->GetXaxis()->SetTitle("(Included) Track Vertex X-Position [cm]");
    	hVtxX_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hVtxY_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxY_inc[type] = new TH1D(histName, histName, 100, -13000, 13000);
    	hVtxY_inc[type]->GetXaxis()->SetTitle("(Included) Track Vertex Y-Position [cm]");
    	hVtxY_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hVtxZ_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxZ_inc[type] = new TH1D(histName, histName, 100, -13000, 13000);
    	hVtxZ_inc[type]->GetXaxis()->SetTitle("(Included) Track Vertex Z-Position [cm]");
    	hVtxZ_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hVtxT_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxT_inc[type] = new TH1D(histName, histName, 100, 0, 10000);
    	hVtxT_inc[type]->GetXaxis()->SetTitle("(Included) Track Vertex Time [ns]");
    	hVtxT_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirX_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirX_inc[type] = new TH1D(histName, histName, 60, -1, 1);
    	hDirX_inc[type]->GetXaxis()->SetTitle("(Included) Track X-Direction");
    	hDirX_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirY_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirY_inc[type] = new TH1D(histName, histName, 60, -1, 1);
    	hDirY_inc[type]->GetXaxis()->SetTitle("(Included) Track Y-Direction");
    	hDirY_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirZ_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirZ_inc[type] = new TH1D(histName, histName, 60, -1, 1);
    	hDirZ_inc[type]->GetXaxis()->SetTitle("(Included) Track Z-Direction");
    	hDirZ_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirTheta_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirTheta_inc[type] = new TH1D(histName, histName, 60, -3.5, 3.5);
    	hDirTheta_inc[type]->GetXaxis()->SetTitle("(Included) Track Theta-Direction [radians]");
    	hDirTheta_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirPhi_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirPhi_inc[type] = new TH1D(histName, histName, 60, -3.5, 3.5);
    	hDirPhi_inc[type]->GetXaxis()->SetTitle("(Included) Track Phi-Direction [radians]");
    	hDirPhi_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hAngle_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hAngle_inc[type] = new TH1D(histName, histName, 50, 0, 10);
    	hAngle_inc[type]->GetXaxis()->SetTitle("(Included) Track Direction [degrees]");
    	hAngle_inc[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hAngle_inc[type]->GetSumw2()->Set(1);

		nameString = "hEnergy_inc_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hEnergy_inc[type] = new TH1D(histName, histName, 60, 0, 5500);
    	hEnergy_inc[type]->GetXaxis()->SetTitle("(Included) Track Energy [MeV]");
    	hEnergy_inc[type]->GetYaxis()->SetTitle("Fraction of Events");

		// Cut Parameter Histograms
		nameString = "hVtxX_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxX_cut[type] = new TH1D(histName, histName, 100, -13000, 13000);
    	hVtxX_cut[type]->GetXaxis()->SetTitle("(Cut) Track Vertex X-Position [cm]");
    	hVtxX_cut[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hVtxY_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxY_cut[type] = new TH1D(histName, histName, 100, -13000, 13000);
    	hVtxY_cut[type]->GetXaxis()->SetTitle("(Cut) Track Vertex Y-Position [cm]");
    	hVtxY_cut[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hVtxZ_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxZ_cut[type] = new TH1D(histName, histName, 100, -13000, 13000);
    	hVtxZ_cut[type]->GetXaxis()->SetTitle("(Cut) Track Vertex Z-Position [cm]");
    	hVtxZ_cut[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hVtxT_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hVtxT_cut[type] = new TH1D(histName, histName, 100, 0, 10000);
    	hVtxT_cut[type]->GetXaxis()->SetTitle("(Cut) Track Vertex Time [ns]");
    	hVtxT_cut[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirX_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirX_cut[type] = new TH1D(histName, histName, 60, -1, 1);
    	hDirX_cut[type]->GetXaxis()->SetTitle("(Cut) Track X-Direction");
    	hDirX_cut[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirY_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirY_cut[type] = new TH1D(histName, histName, 60, -1, 1);
    	hDirY_cut[type]->GetXaxis()->SetTitle("(Cut) Track Y-Direction");
    	hDirY_cut[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirZ_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirZ_cut[type] = new TH1D(histName, histName, 60, -1, 1);
    	hDirZ_cut[type]->GetXaxis()->SetTitle("(Cut) Track Z-Direction");
    	hDirZ_cut[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirTheta_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirTheta_cut[type] = new TH1D(histName, histName, 60, -3.5, 3.5);
    	hDirTheta_cut[type]->GetXaxis()->SetTitle("(Cut) Track Theta-Direction [radians]");
    	hDirTheta_cut[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hDirPhi_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hDirPhi_cut[type] = new TH1D(histName, histName, 60, -3.5, 3.5);
    	hDirPhi_cut[type]->GetXaxis()->SetTitle("(Cut) Track Phi-Direction [radians]");
    	hDirPhi_cut[type]->GetYaxis()->SetTitle("Fraction of Events");

		nameString = "hAngle_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hAngle_cut[type] = new TH1D(histName, histName, 50, 0, 10);
    	hAngle_cut[type]->GetXaxis()->SetTitle("(Cut) Track Direction [degrees]");
    	hAngle_cut[type]->GetYaxis()->SetTitle("Fraction of Events");
    	//hAngle_cut[type]->GetSumw2()->Set(1);

		nameString = "hEnergy_cut_" + name + "_" + types[type]; histName = nameString.c_str();
		std::cout << histName <<  std::endl;
    	hEnergy_cut[type] = new TH1D(histName, histName, 60, 0, 5500);
    	hEnergy_cut[type]->GetXaxis()->SetTitle("(Cut) Track Energy [MeV]");
    	hEnergy_cut[type]->GetYaxis()->SetTitle("Fraction of Events");
    }
	std::cout << "Finished Making Histograms..." << std::endl << std::endl;

	// Make emission profile manager if we need it...
	WCSimEmissionProfileManager * fEmissionProfileManager = new WCSimEmissionProfileManager();

	std::cout << "Running through files..." << std::endl;
    char* dir = gSystem->ExpandPathName(inputDir.c_str());
    void* dirp = gSystem->OpenDirectory(dir);
    const char* entry;
    TString str;
    int n=1;
    int totalEvents = 0;
    int totalCut = 0;
    while((entry = (char*)gSystem->GetDirEntry(dirp)) && n<maxNumFiles){
        str = entry;
        if(str.EndsWith("_tree.root")){
            std::cout << "Processing File [" << n << "] -> " << entry;
            TFile * inputFile = new TFile(gSystem->ConcatFileName(dir, entry), "READ");

            if(!inputFile->GetListOfKeys()->Contains("fResultsTree")){ std::cout << "Skipping File" << std::endl; continue;}
            TTree * resultsTree = (TTree*) (inputFile->Get("fResultsTree"));

            //Set up the TruthInfo...
            TruthInfo *truthInfo = new TruthInfo();
            TBranch *b_ti = resultsTree->GetBranch("TruthInfo");
            b_ti->SetAddress(&truthInfo);

            //Set up the RecoSummary...
            WCSimRecoSummary *recoSummary = new WCSimRecoSummary();
			TBranch *recoData;
			if (PDGcode == 11) {
				recoData = resultsTree->GetBranch("RecoSummary_ElectronLike");
			} else if (PDGcode == 13) {
				recoData = resultsTree->GetBranch("RecoSummary_MuonLike");
			} else { 
				std::cout << "Error: Don't recognise PDGcode!" << std::endl;
				return; 
			}
			if (recoData==0) {
				std::cout << "BOOM" << std::endl;
				continue;
			}
			recoData->SetAddress(&recoSummary);

			//Set up the PidInfo...
            PidInfo *pidInfo = new PidInfo();
			TBranch *pidData;
			if (PDGcode == 11) {
				pidData = resultsTree->GetBranch("PidInfo_ElectronLike");
			} else if (PDGcode == 13) {
				pidData = resultsTree->GetBranch("PidInfo_MuonLike");
			} else { 
				std::cout << "Error: Don't recognise PDGcode!" << std::endl;
				return; 
			}
			pidData->SetAddress(&pidInfo);

			std::cout << ", Events = " << resultsTree->GetEntries() << " ..." << std::endl;
            for(int evt = 0; evt < resultsTree->GetEntries(); evt++){
            	b_ti->GetEntry(evt);
            	recoData->GetEntry(evt);
                pidData->GetEntry(evt);

				// What is the event type?
				int eventType = -1;
				if (truthInfo->IsCC() && truthInfo->IsQE()) {
					eventType = 0;
				} else if (truthInfo->IsCC() && !truthInfo->IsQE()) {
					eventType = 1;
				} else if (truthInfo->IsNC()) {
					eventType = 2;
				} else {
					//std::cout << "Error: Don't know eventType!" << std::endl;
					continue;
				}
				if (eventType == 2) { continue; }

            	// Need to check which codes in truth and reco info correspond to the electron...
				bool foundTrue = false;
				bool foundReco = false;
                for (int truthNum=0; truthNum < truthInfo->GetNPrimaries(); truthNum++) {
					if (truthInfo->GetPrimaryPDG(truthNum) == PDGcode) {
						foundTrue = true;
						break; 
					}
				}

				for (int recoNum=0; recoNum < recoSummary->GetNPrimaries(); recoNum++) { 
					if(recoSummary->GetPrimaryPDG(recoNum) == PDGcode) {
						foundReco = true;
						break; 
					}
				}
				if (!foundTrue || ! foundReco) { std::cout << "Error: Could not match primary particles!" << std::endl; continue; }

				totalEvents++;

				// Get Event info...
				bool eventEscapes = pidInfo->Escapes();
				int nHits = pidInfo->GetNHits();

				// Get Stuff From Truth Info...
				double trueVtxX = truthInfo->GetVtxX();
				double trueVtxY = truthInfo->GetVtxY();
				double trueVtxZ = truthInfo->GetVtxZ();
				double trueVtxT = truthInfo->GetVtxTime();
				TVector3 trueDir = truthInfo->GetPrimaryDir(truthNum);
				double trueE = truthInfo->GetPrimaryEnergy(truthNum);

				// Get Stuff From Reco Info...
				double recoVtxX = recoSummary->GetVertexX(recoNum);
				double recoVtxY = recoSummary->GetVertexY(recoNum);
				double recoVtxZ = recoSummary->GetVertexZ(recoNum);
				double recoVtxT = recoSummary->GetVertexT(recoNum);
				TVector3 recoDir = recoSummary->GetPrimaryDir(recoNum);
				double recoE = recoSummary->GetPrimaryEnergy(recoNum);

				// Calculate a few Additional Things...
				double recoVtxR = TMath::Sqrt((recoVtxX*recoVtxX) + (recoVtxY*recoVtxY));
				TVector3 magVector( (trueVtxX-recoVtxX), (trueVtxY-recoVtxY), (trueVtxZ-recoVtxZ));
				double trueTheta = TMath::ACos(trueDir.Z());
				double truePhi = TMath::ATan(trueDir.Y()/trueDir.X()); // Test swapping these over!!!
				double recoTheta = TMath::ACos(recoDir.Z());
				double recoPhi = TMath::ATan(recoDir.Y()/recoDir.X()); // Test swapping these over!!!

				double angle = TMath::ACos(trueDir.Dot(recoDir)) * TMath::RadToDeg();

				bool cutEvent = false;
				if(useEscapes) {
					
					if (eventEscapes) {
						cutEvent = true;
					}

					/*
					WCSimLikelihoodTrackBase* track;
					if (PDGcode = 11) {
						track = WCSimLikelihoodTrackFactory::MakeTrack(TrackType::ElectronLike, recoVtxX, recoVtxY, recoVtxZ, 
																	recoVtxT, recoTheta, recoPhi, recoE);
					} else if (PDGcode = 13) {
						track = WCSimLikelihoodTrackFactory::MakeTrack(TrackType::MuonLike, recoVtxX, recoVtxY, recoVtxZ, 
																		recoVtxT, recoTheta, recoPhi, recoE);						
					} else {
						std::cout << "Error: Don't recognise PDGcode!" << std::endl;
						return; 
					}

					//track->Print();

					// Get the stopping distance from emission profile...
					double stoppingDistance = fEmissionProfileManager->GetEmissionProfile(track)->GetTrackLengthForPercentile(0.95);
					//std::cout << "Stopping Distance -> " << stoppingDistance << std::endl;

					// Get the distance to the edge using gutted function...
					double distanceToEdge = DistanceToEdge(recoVtxX, recoVtxY, recoVtxZ, recoDir.X(), recoDir.Y(), recoDir.Z(), detectorHeight);
					//std::cout << "Distance To Edge -> " << distanceToEdge << std::endl;

					if(stoppingDistance>distanceToEdge) {
						cutEvent = true;
					}
					*/
				}

				if ((nHits < 100) || (recoVtxX > cutHighVtxX) || (recoVtxX < cutLowVtxX) || (recoE < cutLowEnergy) || (recoE > cutHighEnergy) || (recoVtxR > cutRadius) || (recoVtxZ > cutHeight) || (recoVtxZ < -cutHeight)) {
					cutEvent = true;
				}
				

				if (cutEvent) {
					totalCut++;
					hVtxX_cut[eventType]->Fill(recoVtxX);
					hVtxY_cut[eventType]->Fill(recoVtxY);
					hVtxZ_cut[eventType]->Fill(recoVtxZ);
					hVtxT_cut[eventType]->Fill(recoVtxT);
					hDirX_cut[eventType]->Fill(recoDir.X());
					hDirY_cut[eventType]->Fill(recoDir.Y());
					hDirZ_cut[eventType]->Fill(recoDir.Z());
					hDirTheta_cut[eventType]->Fill(recoTheta);
					hDirPhi_cut[eventType]->Fill(recoPhi);
					hEnergy_cut[eventType]->Fill(recoE);
				} else {
					hVtxPos_tr[eventType]->Fill(magVector.Mag());
					hVtxX_tr[eventType]->Fill(trueVtxX - recoVtxX);
					hVtxY_tr[eventType]->Fill(trueVtxY - recoVtxY);
					hVtxZ_tr[eventType]->Fill(trueVtxZ - recoVtxZ);
					hVtxT_tr[eventType]->Fill(trueVtxT - recoVtxT);
					hDirX_tr[eventType]->Fill(trueDir.X()-recoDir.X());
					hDirY_tr[eventType]->Fill(trueDir.Y()-recoDir.Y());
					hDirZ_tr[eventType]->Fill(trueDir.Z()-recoDir.Z());
					hDirTheta_tr[eventType]->Fill(trueTheta - recoTheta);
					hDirPhi_tr[eventType]->Fill(truePhi - recoPhi);
					hEnergy_tr[eventType]->Fill((trueE - recoE)/trueE);		

					hVtxX_inc[eventType]->Fill(recoVtxX);
					hVtxY_inc[eventType]->Fill(recoVtxY);
					hVtxZ_inc[eventType]->Fill(recoVtxZ);
					hVtxT_inc[eventType]->Fill(recoVtxT);
					hDirX_inc[eventType]->Fill(recoDir.X());
					hDirY_inc[eventType]->Fill(recoDir.Y());
					hDirZ_inc[eventType]->Fill(recoDir.Z());
					hDirTheta_inc[eventType]->Fill(recoTheta);
					hDirPhi_inc[eventType]->Fill(recoPhi);
					hEnergy_inc[eventType]->Fill(recoE);			
				}

            	truthInfo->Clear();
            	recoSummary->Clear();
                pidInfo->Clear();
            }
            inputFile->Close();
			n++;
        }
    }
	std::cout << "Finished Processing Files..." << std::endl << std::endl;

	int totalUsed = totalEvents - totalCut;

	// Normalise all the histograms to account for the different number of events included in each...
	for (int type = 0; type < numTypes; type ++) {
	    hVtxPos_tr[type]->Scale( 1/(hVtxPos_tr[type]->GetEntries()) );
		hVtxX_tr[type]->Scale( 1/(hVtxX_tr[type]->GetEntries()) );
		hVtxY_tr[type]->Scale( 1/(hVtxY_tr[type]->GetEntries()) );
		hVtxZ_tr[type]->Scale( 1/(hVtxZ_tr[type]->GetEntries()) );
		hVtxT_tr[type]->Scale( 1/(hVtxT_tr[type]->GetEntries()) );
		hDirX_tr[type]->Scale( 1/(hDirX_tr[type]->GetEntries()) );
		hDirY_tr[type]->Scale( 1/(hDirY_tr[type]->GetEntries()) );
		hDirZ_tr[type]->Scale( 1/(hDirZ_tr[type]->GetEntries()) );
		hDirTheta_tr[type]->Scale( 1/(hDirTheta_tr[type]->GetEntries()) );
		hDirPhi_tr[type]->Scale( 1/(hDirPhi_tr[type]->GetEntries()) );
		hEnergy_tr[type]->Scale( 1/(hEnergy_tr[type]->GetEntries()) );	

		hVtxX_cut[type]->Scale( 1/(hVtxX_cut[type]->GetEntries()) );
		hVtxY_cut[type]->Scale( 1/(hVtxY_cut[type]->GetEntries()) );
		hVtxZ_cut[type]->Scale( 1/(hVtxZ_cut[type]->GetEntries()) );
		hVtxT_cut[type]->Scale( 1/(hVtxT_cut[type]->GetEntries()) );
		hDirX_cut[type]->Scale( 1/(hDirX_cut[type]->GetEntries()) );
		hDirY_cut[type]->Scale( 1/(hDirY_cut[type]->GetEntries()) );
		hDirZ_cut[type]->Scale( 1/(hDirZ_cut[type]->GetEntries()) );
		hDirTheta_cut[type]->Scale( 1/(hDirTheta_cut[type]->GetEntries()) );
		hDirPhi_cut[type]->Scale( 1/(hDirPhi_cut[type]->GetEntries()) );
		hEnergy_cut[type]->Scale( 1/(hEnergy_cut[type]->GetEntries()) );

		hVtxX_inc[type]->Scale( 1/(hVtxX_inc[type]->GetEntries()) );
		hVtxY_inc[type]->Scale( 1/(hVtxY_inc[type]->GetEntries()) );
		hVtxZ_inc[type]->Scale( 1/(hVtxZ_inc[type]->GetEntries()) );
		hVtxT_inc[type]->Scale( 1/(hVtxT_inc[type]->GetEntries()) );
		hDirX_inc[type]->Scale( 1/(hDirX_inc[type]->GetEntries()) );
		hDirY_inc[type]->Scale( 1/(hDirY_inc[type]->GetEntries()) );
		hDirZ_inc[type]->Scale( 1/(hDirZ_inc[type]->GetEntries()) );
		hDirTheta_inc[type]->Scale( 1/(hDirTheta_inc[type]->GetEntries()) );
		hDirPhi_inc[type]->Scale( 1/(hDirPhi_inc[type]->GetEntries()) );
		hEnergy_inc[type]->Scale( 1/(hEnergy_inc[type]->GetEntries()) );
	}
	
    double sigmaArray[numTypes][11];
    double sigmaErrArray[numTypes][11];

	outputTree = new TTree("outputTree", "outputTree");
	outputTree->Branch("totalEvents", &totalEvents);
	outputTree->Branch("totalCut", &totalCut);
	outputTree->Branch("totalUsed", &totalUsed);

	if (makeFits) {
		for(int type=0; type<numTypes; type++){
			if (hVtxX_tr[type]->GetEntries()>50) {
				hVtxX_tr[type]->Fit("gaus");
				TF1 *fitFun = hVtxX_tr[type]->GetFunction("gaus");
				sigmaArray[type][0] = fitFun->GetParameter(2);
				sigmaErrArray[type][0] = fitFun->GetParError(2);
				std::cout << "VtxX Fit -> " << sigmaArray[type][0] << "+-" << sigmaErrArray[type][0] << std::endl;
				std::string sigmaName = "sigma_vtxX_" + types[type];
				std::string errName = "err_vtxX_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][0]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][0]);
			} else { sigmaArray[type][0] = 0.0; sigmaErrArray[type][0] = 0.0; }

			if (hVtxY_tr[type]->GetEntries()>50) {
				hVtxY_tr[type]->Fit("gaus");
				TF1 *fitFun = hVtxY_tr[type]->GetFunction("gaus");
				sigmaArray[type][1] = fitFun->GetParameter(2);
				sigmaErrArray[type][1] = fitFun->GetParError(2);
				std::cout << "VtxY Fit -> " << sigmaArray[type][1] << "+-" << sigmaErrArray[type][1] << std::endl;
				std::string sigmaName = "sigma_vtxY_" + types[type];
				std::string errName = "err_vtxY_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][1]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][1]);
			} else { sigmaArray[type][1] = 0.0; sigmaErrArray[type][1] = 0.0; }

			if (hVtxZ_tr[type]->GetEntries()>50) {
				hVtxZ_tr[type]->Fit("gaus");
				TF1 *fitFun = hVtxZ_tr[type]->GetFunction("gaus");
				sigmaArray[type][2] = fitFun->GetParameter(2);
				sigmaErrArray[type][2] = fitFun->GetParError(2);
				std::cout << "VtxZ Fit -> " << sigmaArray[type][2] << "+-" << sigmaErrArray[type][2] << std::endl;
				std::string sigmaName = "sigma_vtxZ_" + types[type];
				std::string errName = "err_vtxZ_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][2]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][2]);
			} else { sigmaArray[type][2] = 0.0; sigmaErrArray[type][2] = 0.0; }

			if (hVtxT_tr[type]->GetEntries()>50) {
				hVtxT_tr[type]->Fit("gaus");
				TF1 *fitFun = hVtxT_tr[type]->GetFunction("gaus");
				sigmaArray[type][3] = fitFun->GetParameter(2);
				sigmaErrArray[type][3] = fitFun->GetParError(2);
				std::cout << "VtxT Fit -> " << sigmaArray[type][3] << "+-" << sigmaErrArray[type][3] << std::endl;
				std::string sigmaName = "sigma_vtxT_" + types[type];
				std::string errName = "err_vtxT_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][3]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][3]);
			} else { sigmaArray[type][3] = 0.0; sigmaErrArray[type][3] = 0.0; }

			if (hDirX_tr[type]->GetEntries()>50) {
				hDirX_tr[type]->Fit("gaus");
				TF1 *fitFun = hDirX_tr[type]->GetFunction("gaus");
				sigmaArray[type][4] = fitFun->GetParameter(2);
				sigmaErrArray[type][4] = fitFun->GetParError(2);
				std::cout << "DirX Fit -> " << sigmaArray[type][4] << "+-" << sigmaErrArray[type][4] << std::endl;
				std::string sigmaName = "sigma_dirX_" + types[type];
				std::string errName = "err_dirX_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][4]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][4]);
			} else { sigmaArray[type][4] = 0.0; sigmaErrArray[type][4] = 0.0; }

			if (hDirY_tr[type]->GetEntries()>50) {
				hDirY_tr[type]->Fit("gaus");
				TF1 *fitFun = hDirY_tr[type]->GetFunction("gaus");
				sigmaArray[type][5] = fitFun->GetParameter(2);
				sigmaErrArray[type][5] = fitFun->GetParError(2);
				std::cout << "DirY Fit -> " << sigmaArray[type][5] << "+-" << sigmaErrArray[type][5] << std::endl;
				std::string sigmaName = "sigma_dirY_" + types[type];
				std::string errName = "err_dirY_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][5]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][5]);
			} else { sigmaArray[type][5] = 0.0; sigmaErrArray[type][5] = 0.0; }

			if (hDirZ_tr[type]->GetEntries()>50) {
				hDirZ_tr[type]->Fit("gaus");
				TF1 *fitFun = hDirZ_tr[type]->GetFunction("gaus");
				sigmaArray[type][6] = fitFun->GetParameter(2);
				sigmaErrArray[type][6] = fitFun->GetParError(2);
				std::cout << "DirZ Fit -> " << sigmaArray[type][6] << "+-" << sigmaErrArray[type][6] << std::endl;
				std::string sigmaName = "sigma_dirZ_" + types[type];
				std::string errName = "err_dirZ_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][6]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][6]);
			} else { sigmaArray[type][6] = 0.0; sigmaErrArray[type][6] = 0.0; }

			if (hDirTheta_tr[type]->GetEntries()>50) {
				hDirTheta_tr[type]->Fit("gaus");
				TF1 *fitFun = hDirTheta_tr[type]->GetFunction("gaus");
				sigmaArray[type][7] = fitFun->GetParameter(2);
				sigmaErrArray[type][7] = fitFun->GetParError(2);
				std::cout << "DirTheta Fit -> " << sigmaArray[type][7] << "+-" << sigmaErrArray[type][7] << std::endl;
				std::string sigmaName = "sigma_dirTheta_" + types[type];
				std::string errName = "err_dirTheta_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][7]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][7]);
			} else { sigmaArray[type][7] = 0.0; sigmaErrArray[type][7] = 0.0; }

			if (hDirPhi_tr[type]->GetEntries()>50) {
				hDirPhi_tr[type]->Fit("gaus");
				TF1 *fitFun = hDirPhi_tr[type]->GetFunction("gaus");
				sigmaArray[type][8] = fitFun->GetParameter(2);
				sigmaErrArray[type][8] = fitFun->GetParError(2);
				std::cout << "DirPhi Fit -> " << sigmaArray[type][8] << "+-" << sigmaErrArray[type][8] << std::endl;
				std::string sigmaName = "sigma_dirPhi_" + types[type];
				std::string errName = "err_dirPhi_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][8]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][8]);
			} else { sigmaArray[type][8] = 0.0; sigmaErrArray[type][8] = 0.0; }

			if (hEnergy_tr[type]->GetEntries()>50) {
				hEnergy_tr[type]->Fit("gaus");
				TF1 *fitFun = hEnergy_tr[type]->GetFunction("gaus");
				sigmaArray[type][9] = fitFun->GetParameter(2);
				sigmaErrArray[type][9] = fitFun->GetParError(2);
				std::cout << "Energy Fit -> " << sigmaArray[type][9] << "+-" << sigmaErrArray[type][9] << std::endl;
				std::string sigmaName = "sigma_energy_" + types[type];
				std::string errName = "err_energy_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][9]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][9]);
			} else { sigmaArray[type][9] = 0.0; sigmaErrArray[type][9] = 0.0; }

			if (hVtxPos_tr[type]->GetEntries()>50) {
				const Int_t nq = 1;
				Double_t xq[nq];  // position where to compute the quantiles in [0,1]
				Double_t yq[nq];  // array to contain the quantiles
				xq[0] = 0.68;
				hVtxPos_tr[type]->GetQuantiles(nq,yq,xq);
				sigmaArray[type][10] = yq[0];
				sigmaErrArray[type][10] = 0.0;
				std::cout << "VtxPos Fit -> " << sigmaArray[type][10] << "+-" << sigmaErrArray[type][10] << std::endl;
				std::string sigmaName = "sigma_vtxPos_" + types[type];
				std::string errName = "err_vtxPos_" + types[type];
				outputTree->Branch(sigmaName.c_str(), &sigmaArray[type][10]);
				outputTree->Branch(errName.c_str(), &sigmaErrArray[type][10]);
			} else { sigmaArray[type][10] = 0.0; sigmaErrArray[type][10] = 0.0; }		
		}
	}

	TFile * mainOutput = new TFile(outputFile,"RECREATE");
	std::cout << "Saving plots to " << outputFile << std::endl;
	mainOutput->cd();

	outputTree->Fill();
	outputTree->Write();

	for (int type = 0; type < numTypes; type ++) {
		if (mainOutput->GetDirectory(types[type].c_str()) == 0) {
			mainOutput->mkdir(types[type].c_str());
		}
		mainOutput->cd(types[type].c_str());		

		if (hVtxPos_tr[type]->GetEntries()>50) {hVtxPos_tr[type]->Write();}
		if (hVtxX_tr[type]->GetEntries()>50) {hVtxX_tr[type]->Write();}
		if (hVtxY_tr[type]->GetEntries()>50) {hVtxY_tr[type]->Write();}
		if (hVtxZ_tr[type]->GetEntries()>50) {hVtxZ_tr[type]->Write();}
		if (hVtxT_tr[type]->GetEntries()>50) {hVtxT_tr[type]->Write();}
		if (hDirX_tr[type]->GetEntries()>50) {hDirX_tr[type]->Write();}
		if (hDirY_tr[type]->GetEntries()>50) {hDirY_tr[type]->Write();}
		if (hDirZ_tr[type]->GetEntries()>50) {hDirZ_tr[type]->Write();}
		if (hDirTheta_tr[type]->GetEntries()>50) {hDirTheta_tr[type]->Write();}
		if (hDirPhi_tr[type]->GetEntries()>50) {hDirPhi_tr[type]->Write();}
		if (hEnergy_tr[type]->GetEntries()>50) {hEnergy_tr[type]->Write();}

		if (hVtxX_cut[type]->GetEntries()>50) {hVtxX_cut[type]->Write();}
		if (hVtxY_cut[type]->GetEntries()>50) {hVtxY_cut[type]->Write();}
		if (hVtxZ_cut[type]->GetEntries()>50) {hVtxZ_cut[type]->Write();}
		if (hVtxT_cut[type]->GetEntries()>50) {hVtxT_cut[type]->Write();}
		if (hDirX_cut[type]->GetEntries()>50) {hDirX_cut[type]->Write();}
		if (hDirY_cut[type]->GetEntries()>50) {hDirY_cut[type]->Write();}
		if (hDirZ_cut[type]->GetEntries()>50) {hDirZ_cut[type]->Write();}
		if (hDirTheta_cut[type]->GetEntries()>50) {hDirTheta_cut[type]->Write();}
		if (hDirPhi_cut[type]->GetEntries()>50) {hDirPhi_cut[type]->Write();}
		if (hEnergy_cut[type]->GetEntries()>50) {hEnergy_cut[type]->Write();}

		if (hVtxX_inc[type]->GetEntries()>50) {hVtxX_inc[type]->Write();}
		if (hVtxY_inc[type]->GetEntries()>50) {hVtxY_inc[type]->Write();}
		if (hVtxZ_inc[type]->GetEntries()>50) {hVtxZ_inc[type]->Write();}
		if (hVtxT_inc[type]->GetEntries()>50) {hVtxT_inc[type]->Write();}
		if (hDirX_inc[type]->GetEntries()>50) {hDirX_inc[type]->Write();}
		if (hDirY_inc[type]->GetEntries()>50) {hDirY_inc[type]->Write();}
		if (hDirZ_inc[type]->GetEntries()>50) {hDirZ_inc[type]->Write();}
		if (hDirTheta_inc[type]->GetEntries()>50) {hDirTheta_inc[type]->Write();}
		if (hDirPhi_inc[type]->GetEntries()>50) {hDirPhi_inc[type]->Write();}
		if (hEnergy_inc[type]->GetEntries()>50) {hEnergy_inc[type]->Write();}
	}

	mainOutput->Close();

    std::cout << "Total Events -> " << totalEvents << ", numUsed -> " << (totalEvents - totalCut) << ", numCut -> " << totalCut << std::endl;
	std::cout << "#### END ####" << std::endl;
}

double DistanceToEdge(Double_t x0, Double_t y0, Double_t z0, Double_t px, Double_t py, Double_t pz, Double_t height) {

	Double_t xNear = -99999.9;
	Double_t yNear = -99999.9;
	Double_t zNear = -99999.9;
	Int_t regionNear = WCSimGeometry::kUnknown;

	Double_t xFar = -99999.9;
	Double_t yFar = -99999.9;
	Double_t zFar = -99999.9;
	Int_t regionFar = WCSimGeometry::kUnknown;

	Double_t r = 1200;
	Double_t L = height;

	Bool_t foundProjectionXY = 0;
	Bool_t foundProjectionZ = 0;

	Double_t t1 = 0.0;
	Double_t x1 = 0.0;
	Double_t y1 = 0.0;
	Double_t z1 = 0.0;
	Int_t region1 = -1;

	Double_t t2 = 0.0;
	Double_t x2 = 0.0;
	Double_t y2 = 0.0;
	Double_t z2 = 0.0;
	Int_t region2 = -1;

	Double_t rSq = r * r;
	Double_t r0r0 = x0 * x0 + y0 * y0;
	Double_t r0p = x0 * px + y0 * py;
	Double_t pSq = px * px + py * py;

	// calculate intersection in XY
	if (pSq > 0.0) {
		if (r0p * r0p - pSq * (r0r0 - rSq) > 0.0) {
			t1 = (-r0p - sqrt(r0p * r0p - pSq * (r0r0 - rSq))) / pSq;
			t2 = (-r0p + sqrt(r0p * r0p - pSq * (r0r0 - rSq))) / pSq;
			foundProjectionXY = 1;
		}
	}

	// propagation along z-axis
	else if (r0r0 <= rSq) {
		if (pz > 0) {
			t1 = -L / 2.0 - z0;
			t2 = +L / 2.0 - z0;
		} else {
			t1 = -L / 2.0 + z0;
			t2 = +L / 2.0 + z0;
		}
		foundProjectionXY = 1;
	}

	// found intersection in XY
	if (foundProjectionXY) {
		z1 = z0 + t1 * pz;
		z2 = z0 + t2 * pz;
		if ((z1 >= -L / 2.0 && z2 <= +L / 2.0) || (z2 >= -L / 2.0 && z1 <= +L / 2.0)) {
			foundProjectionZ = 1;
		}
	}
		

	// found intersection in Z
	if (foundProjectionZ) {
		// first intersection
		if (z1 > -L / 2.0 && z1 < +L / 2.0) {
			region1 = WCSimGeometry::kSide;
		}
		if (z1 >= +L / 2.0) {
			region1 = WCSimGeometry::kTop;
			if (z1 > +L / 2.0) {
				z1 = +L / 2.0;
				t1 = (+L / 2.0 - z0) / pz;
			}
		}
		if (z1 <= -L / 2.0) {
			region1 = WCSimGeometry::kBottom;
			if (z1 < -L / 2.0) {
				z1 = -L / 2.0;
				t1 = (-L / 2.0 - z0) / pz;
			}
		}

		x1 = x0 + t1 * px;
		y1 = y0 + t1 * py;

		// second intersection
		if (z2 > -L / 2.0 && z2 < +L / 2.0) {
			region2 = WCSimGeometry::kSide;
		}
		if (z2 >= +L / 2.0) {
			region2 = WCSimGeometry::kTop;
			if (z2 > +L / 2.0) {
				z2 = +L / 2.0;
				t2 = (+L / 2.0 - z0) / pz;
			}
		}
		if (z2 <= -L / 2.0) {
			region2 = WCSimGeometry::kBottom;
			if (z2 < -L / 2.0) {
				z2 = -L / 2.0;
				t2 = (-L / 2.0 - z0) / pz;
			}
		}

		x2 = x0 + t2 * px;
		y2 = y0 + t2 * py;

		// near/far projection
		if (t1 >= 0) {
			xNear = x1;
			yNear = y1;
			zNear = z1;
			regionNear = region1;

			xFar = x2;
			yFar = y2;
			zFar = z2;
			regionFar = region2;
		} else if (t2 > 0) {
			xNear = x2;
			yNear = y2;
			zNear = z2;
			regionNear = region2;

			xFar = x1;
			yFar = y1;
			zFar = z1;
			regionFar = region1;
		}
	}

	double xproj = xNear;
	double yproj = yNear;
	double zproj = zNear;
	Int_t regionproj = regionNear;

	if (regionproj > WCSimGeometry::kUnknown) {
		return sqrt((xproj - x0) * (xproj - x0) + (yproj - y0) * (yproj - y0) + (zproj - z0) * (zproj - z0));
	} else {
		return -999.99;
	}

	return -999.99;
}
