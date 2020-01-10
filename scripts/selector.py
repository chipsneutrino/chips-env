import getopt
import math
import os
import sys
from os import listdir
from ROOT import TFile, TH1F

# Constants
refracWater 		= 1.33
chargedPionMass 	= 139.570
chargedKaonMass 	= 493.677
protonMass 			= 938.27231
chargedSigmaMass 	= 1189.37
electronMass 		= 0.511
muonMass 			= 105.658

# Calculate all the thresholds we need to apply to charged particles
chargedPionThreshold = math.sqrt((chargedPionMass*chargedPionMass)/(1-(1/(refracWater*refracWater))));
chargedKaonThreshold = math.sqrt((chargedKaonMass*chargedKaonMass)/(1-(1/(refracWater*refracWater))));
protonThreshold = math.sqrt((protonMass*protonMass)/(1-(1/(refracWater*refracWater))));
chargedSigmaThreshold = math.sqrt((chargedSigmaMass*chargedSigmaMass)/(1-(1/(refracWater*refracWater))));
electronThreshold = math.sqrt((electronMass*electronMass)/(1-(1/(refracWater*refracWater))));
muonThreshold = math.sqrt((muonMass*muonMass)/(1-(1/(refracWater*refracWater))));

class Selector:
	def __init__(self, inputDir, outputDir, plotPath, outputSize, requireParticles, requireTypes):
		self.m_inputDir = inputDir
		self.m_outputDir = outputDir
		self.m_plotPath = plotPath
		self.m_outputSize = outputSize 
		self.m_requireParticles = requireParticles
		self.m_requireTypes = requireTypes

	def Run(self):
		self.ApplyFilter()	# Applies detection thresholds and selection
		self.MakePlots()	# Make ROOT plots of the filtered events
		self.Recombine()	# Recombine the passed events into .vec files for simulation
		self.Cleanup()		# Cleanup temporary file created

	def ApplyFilter(self):
		temp = open(os.path.join(self.m_outputDir, "temp.temp"),'w') # Open a temporary file to hold the passed events

		# Event counters    
		events = 0
		passed_events = 0
		threshold_cut_events = 0
		particles_cut_events = 0
		types_cut_events = 0

		# Loop through all files in the input directory
		for inFile in listdir(self.m_inputDir):
			if inFile.endswith(".vec"):
				print("Filtering %s" % inFile)

				# Open file and fill lines with its content
				lines = []
				with open(os.path.join(self.m_inputDir, inFile)) as f:
					lines = f.readlines()

				event = [] # Define array to hold the events for a specific event we find
				for line in lines:
					if line.startswith("$ begin"): # Find the start of an event
						event = [line]
					else: # Add lines including the end of the event
						event.append(line)

					if line.startswith("$ end"): # We now filter the event
						# Set the filter flags
						typePass = False
						if len(self.m_requireTypes) == 0:
							typePass = True

						particlePass = False
						if len(self.m_requireParticles) == 0:
							particlePass = True

						thresholdPass = False
						
						# Loop through event lines
						for evtLine in event:
							# Apply the event type filter
							if evtLine.startswith("$ nuance") and int(evtLine.split(' ')[2]) in self.m_requireTypes:
								typePass = True
								
							# Apply the detection thresholds and required particles filters
							if evtLine.startswith("$ track") and evtLine.endswith(" 0\n"): # Select final state tracks
								particle = int(evtLine.split(' ')[2])
								energy = float(evtLine.split(' ')[3])
								if particle in [11, -11] and energy > electronThreshold: 		# Electron
									thresholdPass = True
								if particle in [13, -13] and energy > muonThreshold: 			# Muon
									thresholdPass = True
								if particle in [211, -211] and energy > chargedPionThreshold: 	# Charged Pion
									thresholdPass = True
								if particle in [321, -321] and energy > chargedKaonThreshold: 	# Charged Kaon
									thresholdPass = True
								if particle in [2212] and energy > protonThreshold: 			# Proton
									thresholdPass = True
								if particle in [3112] and energy > chargedSigmaThreshold: 		# Charged Sigma
									thresholdPass = True
								if particle in [22] and energy > (20*electronMass): 			# Photon, a few pair productions
									thresholdPass = True
								if particle in [111] and energy > (20*electronMass): 			# Neutral Pion, a few pair productions
									thresholdPass += 1

								if particle in self.m_requireParticles:
									particlePass = True

						events += 1 # Increment the total event counter
						if typePass and particlePass and thresholdPass: # Does the event pass the filtering?
							passed_events += 1
							for line in event: # Write event to the temporary file
								temp.write(line) 

						if not typePass:
							types_cut_events += 1
						if not particlePass:
							particles_cut_events += 1
						if not thresholdPass:
							threshold_cut_events += 1

		temp.close() # Close the temporary file of passed events

		name, ext = os.path.splitext(self.m_plotPath)
		name += ".txt"
		with open(name, "w") as file: 
			file.write("Events: " + str(events)) 
			file.write("\nPassed: " + str(passed_events)) 
			file.write("\nType Cut: " + str(types_cut_events)) 
			file.write("\nParticle Cut: " + str(particles_cut_events)) 
			file.write("\nThreshold Cut: " + str(threshold_cut_events)) 

		print("Saved filter summary to " + name)     

	def MakePlots(self):
		print("Making Plots...") 
		# Open the file to hold the plots
		plotsFile = TFile(self.m_plotPath, "RECREATE")

		# Interaction types and names
		# There are many different categories of event
		# 0 	= kOther
		# QE
		# 1 	= kCCQE 
		# 2 	= kNCQE 
		# Resonance states
		# 3 	= kCCNuPtoLPPiPlus 
		# 4 	= kCCNuNtoLPPiZero 
		# 5 	= kCCNuNtoLNPiPlus 
		# 6 	= kNCNuPtoNuPPiZero 
		# 7 	= kNCNuPtoNuNPiPlus 
		# 8 	= kNCNuNtoNuNPiZero 
		# 9 	= kNCNuNtoNuPPiMinus 
		# Other
		# 91 	= kCCDIS 
		# 92 	= kNCDIS 
		# 97 	= kCCCoh 
		# 98 	= kElastic 
		# 100   = Cosmic Muon
		evtTypes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 91, 92, 96, 97, 98, 100]
		evtNames = ["Other", "CCQE", "NCQE", 
					"CCNuPtoLPPiPlus", "CCNuNtoLPPiZero",
					"CCNuNtoLNPiPlus", "NCNuPtoNuPPiZero", 
					"NCNuPtoNuNPiPlus","NCNuNtoNuNPiZero", 
					"NCNuNtoNuPPiMinus", "CCDIS", 
					"NCDIS", "NCCoh", "CCCoh", "ElasticScattering",
					"CosmicMuon"]

		# Particle types and names
		parTypes = [11,    -11,   12,     13,    -13,   14,     111,   211,   -211,  2212,     2112,      22,       -1]
		parNames = ["el-", "el+", "nuel", "mu-", "mu+", "numu", "pi0", "pi+", "pi-", "Proton", "Neutron", "photon", "Other"]

		# Search for all iteraction types
		h_intTypeSearch = TH1F("h_intTypeSearch", "h_intTypeSearch", 200, -100, 100)

		# Make hist of interaction types
		h_intType = TH1F("h_intType", "Interaction Type", len(evtTypes), 0, len(evtTypes))
		h_intType.SetFillColor(38)
		h_intType.SetBarWidth(0.5)
		h_intType.SetBarOffset(0.25)
		h_intType.SetStats(0)
		for i in range(1, len(evtTypes)+1):
			h_intType.GetXaxis().SetBinLabel(i, evtNames[i-1])

		# Make histograms for each interaction type
		h_nuEnergy = []
		h_parNum = []
		h_parType = []
		h_parTypePassed = []
		for i in range(len(evtTypes)):
			h_nuEnergy.append(TH1F(("h_nuEnergy_"+evtNames[i]), ("Neutrino Energy for type "+evtNames[i]), 150, 0, 15000))
			h_parNum.append(TH1F(("h_parNum_"+evtNames[i]), ("Number of particles for type "+evtNames[i]), 20, 0, 20))
			h_parType.append(TH1F(("h_parType_"+evtNames[i]), ("Number of particles for type "+evtNames[i]), len(parTypes), 0, len(parTypes)))
			h_parTypePassed.append(TH1F(("h_parTypePassed_"+evtNames[i]), ("Number of particles Passed for type "+evtNames[i]), len(parTypes), 0, len(parTypes)))
			for j in range(1, len(parTypes)+1):
				h_parType[i].GetXaxis().SetBinLabel(j, parNames[j-1])
				h_parTypePassed[i].GetXaxis().SetBinLabel(j, parNames[j-1])

		temp = open(os.path.join(self.m_outputDir, "temp.temp"), 'r') # Open the temporary file holding the passed events
		lines = temp.readlines()
		event = [] # Define array to hold the events for a specific event we find
		for line in lines:
			if line.startswith("$ begin"): # Find the start of an event
				event = [line]
			else: # Add lines including the end of the event
				event.append(line)
			if line.startswith("$ end"): # We now inspect the event
				evtType = -1
				numParticles = 0
				for evtLine in event: # Loop through event lines
					if evtLine.startswith("$ nuance"):
						h_intTypeSearch.Fill(int(evtLine.split(' ')[2]))
						h_intType.Fill(evtTypes.index(int(evtLine.split(' ')[2])))
						evtType = int(evtLine.split(' ')[2])
					if (evtLine.startswith("$ track 12") or evtLine.startswith("$ track 14")) and evtLine.endswith(" -1\n"):
						h_nuEnergy[evtTypes.index(evtType)].Fill(float(evtLine.split(' ')[3]))

					# Record particles over the detection thresholds
					if evtLine.startswith("$ track") and evtLine.endswith(" 0\n"): # Select final state tracks
						particle = int(evtLine.split(' ')[2])
						energy = float(evtLine.split(' ')[3])

						if particle in [-12, 130, 311, -311, 321, -321, 411, 421, 431, -2212, -2112, 3122, 3112, -3122, 3222, 3212, 8016, 4212, 4122, 4222]:
							particle = -1

						h_parType[evtTypes.index(evtType)].Fill(parTypes.index(particle))
						
						if particle in [11, -11] and energy > electronThreshold: 		# Electron
							numParticles += 1
							h_parTypePassed[evtTypes.index(evtType)].Fill(parTypes.index(particle))
						if particle in [13, -13] and energy > muonThreshold: 			# Muon
							numParticles += 1
							h_parTypePassed[evtTypes.index(evtType)].Fill(parTypes.index(particle))
						if particle in [211, -211] and energy > chargedPionThreshold: 	# Charged Pion
							numParticles += 1
							h_parTypePassed[evtTypes.index(evtType)].Fill(parTypes.index(particle))
						if particle in [321, -321] and energy > chargedKaonThreshold: 	# Charged Kaon
							numParticles += 1
							h_parTypePassed[evtTypes.index(evtType)].Fill(parTypes.index(particle))
						if particle in [2212] and energy > protonThreshold: 			# Proton
							numParticles += 1
							h_parTypePassed[evtTypes.index(evtType)].Fill(parTypes.index(particle))
						if particle in [3112] and energy > chargedSigmaThreshold: 		# Charged Sigma
							numParticles += 1
							h_parTypePassed[evtTypes.index(evtType)].Fill(parTypes.index(particle))
						if particle in [22] and energy > (20*electronMass): 			# Photon, a few pair productions
							numParticles += 1
							h_parTypePassed[evtTypes.index(evtType)].Fill(parTypes.index(particle))
						if particle in [111] and energy > (20*electronMass): 			# Neutral Pion, a few pair productions
							numParticles += 1
							h_parTypePassed[evtTypes.index(evtType)].Fill(parTypes.index(particle))
					
				h_parNum[evtTypes.index(evtType)].Fill(numParticles)

		h_intTypeSearch.GetXaxis().SetTitle("Interaction Type Code")
		h_intTypeSearch.GetYaxis().SetTitle("Frequency")
		h_intTypeSearch.Write()
		h_intType.GetXaxis().SetTitle("Interaction Type")
		h_intType.GetYaxis().SetTitle("Frequency")
		h_intType.Write()
		for i in range(len(evtTypes)):
			h_nuEnergy[i].GetXaxis().SetTitle("Neutrino Energy [GeV]")
			h_nuEnergy[i].GetYaxis().SetTitle("Frequency")
			h_nuEnergy[i].Write()
			h_parNum[i].GetXaxis().SetTitle("Number of Particles Above Threshold")
			h_parNum[i].GetYaxis().SetTitle("Frequency")
			h_parNum[i].Write()
			h_parType[i].GetXaxis().SetTitle("Particle Type")
			h_parType[i].GetYaxis().SetTitle("Frequency")
			h_parType[i].Write()
			h_parTypePassed[i].GetXaxis().SetTitle("Particle Type Above Threshold")
			h_parTypePassed[i].GetYaxis().SetTitle("Frequency")
			h_parTypePassed[i].Write()
		temp.close()
		plotsFile.Close()

	def Recombine(self):
		print("Recombining Files") 
		lines = []
		thisfile = []
		eventCounter = 0
		fileCount = 0
		with open(os.path.join(self.m_outputDir, "temp.temp")) as f:
			lines = f.readlines()
			for line in lines:
				thisfile.append(line)
				if line.startswith("$ end"):
					eventCounter += 1
				if (eventCounter == self.m_outputSize): 

					# Reached the number of events for a sim file, therefore, close and open a new one
					outputName = "filtered_" + str(fileCount).zfill(3) + ".vec"
					with open(os.path.join(self.m_outputDir, outputName),'w') as fout:
						for line in thisfile:
							fout.write(line)
					eventCounter = 0
					fileCount += 1
					thisfile[:] = []
					
		print("Total files created -> %s" % fileCount)
				
	def Cleanup(self):
		os.remove(os.path.join(self.m_outputDir, "temp.temp"))
		print("Deleted temp file %s" % os.path.join(self.m_outputDir, "temp.temp"))