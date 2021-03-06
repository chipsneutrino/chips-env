R__LOAD_LIBRARY(libGeom.so)
R__LOAD_LIBRARY(libEve.so)
R__LOAD_LIBRARY(libMinuit.so)
R__LOAD_LIBRARY(libEG.so)
R__LOAD_LIBRARY(libGui.so)
R__LOAD_LIBRARY(libSpectrum.so)
R__LOAD_LIBRARY(libWCSimRoot.so)
R__LOAD_LIBRARY(libWCSimAnalysisRoot.so)

void hitmapper(const char * in_file = "", const char * out_file = "", int max_events=1000, bool save_extra=false,
			   float detector_height=1200, float detector_radius=1250)
{
	WCSimMapper mapper = WCSimMapper(in_file, out_file, max_events, save_extra, detector_height, detector_radius);
	mapper.run();
}