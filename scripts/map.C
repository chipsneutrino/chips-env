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

void map(const char * in_file = "", const char * out_file = "", int max_events=1000, int category=0, int pdg=11) 
{
	load_libs();
	WCSimMapper mapper = WCSimMapper(in_file, out_file, max_events, category, pdg);
	mapper.run();
}
