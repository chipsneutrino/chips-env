void load_libs()
{
	gSystem->Load("libGeom");
	gSystem->Load("libEve");
	gSystem->Load("libMinuit");
	TString libWCSimRoot = TString::Format("%s%s", gSystem->Getenv("WCSIMHOME"), "/lib/libWCSim.so");
	TString libWCSimAnalysis = TString::Format("%s%s", gSystem->Getenv("WCSIMANAHOME"), "/lib/libWCSimAnalysis.so");
	gSystem->Load(libWCSimRoot.Data());
	gSystem->Load(libWCSimAnalysis.Data());	
}

void map(const char * in_file = "", const char * out_file = "", int max_events=1000, bool save_extra) 
{
	load_libs();
	WCSimMapper mapper = WCSimMapper(in_file, out_file, max_events, save_extra);
	mapper.run();
}
