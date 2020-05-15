"""Python module to select events

Author: Josh Tingey
Email: j.tingey.16@ucl.ac.uk

This module provides the Selector class that is used to select
beam and cosmic events, plot summary plots and recombine into
files of a given size ready for simulation.
"""

import math
import random
import os
from os import listdir
import ROOT
ROOT.PyConfig.IgnoreCommandLineOptions = True

# Refractive index of water and charged particle masses
i_water = 1.33
m_electron = 0.511
m_muon = 105.658
m_pion = 139.570
m_proton = 938.272
m_kaon = 493.677
m_sigma = 1189.37
m_d = 1869.62

# Calculate all the Cherenkov thresholds we need to apply to charged particles
t_electron = math.sqrt((m_electron*m_electron)/(1-(1/(i_water*i_water))))
t_muon = math.sqrt((m_muon*m_muon)/(1-(1/(i_water*i_water))))
t_pion = math.sqrt((m_pion*m_pion)/(1-(1/(i_water*i_water))))
t_proton = math.sqrt((m_proton*m_proton)/(1-(1/(i_water*i_water))))
t_kaon = math.sqrt((m_kaon*m_kaon)/(1-(1/(i_water*i_water))))
t_sigma = math.sqrt((m_sigma*m_sigma)/(1-(1/(i_water*i_water))))
t_d = math.sqrt((m_d*m_d)/(1-(1/(i_water*i_water))))

# Interaction codes and corresponding names
event_int_codes = [
    0, 1, 2,
    3, 4, 5,
    6, 7, 8, 9,
    10, 11, 12,
    13, 14, 15, 16,
    17, 18, 19, 20, 21,
    91, 92, 96, 97, 98, 99,
    100
]
int_names = [
    "Other", "CCQE", "NCQE",
    "CCNuPtoLPPiPlus", "CCNuNtoLPPiZero", "CCNuNtoLNPiPlus", 
    "NCNuPtoNuPPiZero", "NCNuPtoNuNPiPlus", "NCNuNtoNuNPiZero", "NCNuNtoNuPPiMinus", 
    "CCNuBarNtoLNPiMinus", "CCNuBarPtoLNPiZero", "CCNuBarPtoLPPiMinus",
    "NCNuBarPtoNuBarPPiZero", "NCNuBarPtoNuBarNPiPlus", "NCNuBarNtoNuBarNPiZero", "NCNuBarNtoNuBarPPiMinus",
    "CCOtherResonant", "NCOtherResonant", "CCMEC", "NCMEC", "IMD",
    "CCDIS", "NCDIS", "NCCoh", "CCCoh", "ElasticScattering", "InverseMuDecay",
    "CosmicMuon"
]

# Particle types and names
par_codes = [
    11, -11, 12, -12, 13, -13, 14, -14,
    111, 211, -211, 2212, 2112, 22, 
    321, -321, 3112, 3222, 3212,
    130, 311, -311, 411, 421, 431,
    -2212, -2112, 3122, -3122,
    4212, 4122, 4222, 8016
]
par_names = [
    "e^{-}", "e^{+}", "#nu_{e}", "#bar{#nu}_{e}", "#mu^{-}", "#mu^{+}", "#nu_{#mu}", "#bar{#nu}_{#mu}",
    "#pi^{0}", "#pi^{+}", "#pi^{-}", "P", "N", "#gamma",
    "K^{+}", "K^{-}", "#Sigma^{-}", "#Sigma^{+}", "#Sigma^{0}",
    "K^{0}_{L}", "K^{0}", "#bar{K^{0}}", "D^{+}", "D^{0}", "K^{+}_{s}",
    "#bar{P}", "#bar{N}", "#Lambda", "#bar{#Lambda}",
    "#Sigma^{+}_{c}", "#Lambda^{+}_{c}", "#Sigma^{++}_{c}", "O16"
]

# Final state types and corresponding names
final_codes = [ # Electron, Muon, charged pion, neutral pion, proton, gamma
    [0, 0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0, 0], [0, 1, 0, 0, 0, 0], [0, 0, 1, 0, 0, 0], [0, 0, 0, 1, 0, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 1],
    [1, 0, 1, 0, 0, 0], [1, 0, 0, 1, 0, 0], [1, 0, 0, 0, 1, 0], [1, 0, 0, 0, 0, 1],
    [0, 1, 1, 0, 0, 0], [0, 1, 0, 1, 0, 0], [0, 1, 0, 0, 1, 0], [0, 1, 0, 0, 0, 1],
    [0, 0, 1, 1, 0, 0], [0, 0, 1, 0, 1, 0], [0, 0, 1, 0, 0, 1], [0, 0, 0, 1, 1, 0], [0, 0, 0, 1, 0, 1], [0, 0, 0, 0, 1, 1],
    [1, 0, 1, 1, 0, 0], [1, 0, 1, 0, 1, 0], [1, 0, 1, 0, 0, 1], [1, 0, 0, 1, 1, 0], [1, 0, 0, 1, 0, 1], [1, 0, 0, 0, 1, 1],
    [0, 1, 1, 1, 0, 0], [0, 1, 1, 0, 1, 0], [0, 1, 1, 0, 0, 1], [0, 1, 0, 1, 1, 0], [0, 1, 0, 1, 0, 1], [0, 1, 0, 0, 1, 1]
]
final_names = [
    "None"
    "1e", "1#mu", "1#pi^{#pm}", "1#pi^{0}", "1P", "1#gamma",
    "1e1#pi^{#pm}", "1e1#pi^{0}", "1e1P", "1e1#gamma",
    "1#mu1#pi^{#pm}", "1#mu1#pi^{0}", "1#mu1P", "1#mu1#gamma",
    "1#pi^{#pm}1#pi^{0}", "1#pi^{#pm}1P", "1#pi^{#pm}1#gamma", "1#pi^{0}1P", "1#pi^{0}1#gamma", "1P1#gamma",
    "1e1#pi^{#pm}1#pi^{0}", "1e1#pi^{#pm}1P", "1e1#pi^{#pm}1#gamma", "1e1#pi^{0}1P", "1e1#pi^{0}1#gamma", "1e1P1#gamma",
    "1#mu1#pi^{#pm}1#pi^{0}", "1#mu1#pi^{#pm}1P", "1#mu1#pi^{#pm}1#gamma", "1#mu1#pi^{0}1P", "1#mu1#pi^{0}1#gamma", "1#mu1P1#gamma",
    "Other"
]


class Selector:
    """Class controlling the selection of events."""
    def __init__(self, inputDir, outputDir, plotPath, outputSize, requireParticles, requireTypes):
        self.input_dir = inputDir
        self.output_dir = outputDir
        self.plot_path = plotPath
        self.output_size = outputSize
        self.required_particles = requireParticles
        self.required_types = requireTypes

    def Run(self):
        """Runs the full selection pipeline."""

        # Counters
        events = 0
        passed_events = 0
        threshold_cut_events = 0
        particles_cut_events = 0
        types_cut_events = 0

        # Create histograms
        h_int_types_all = ROOT.TH1F("int_types_all", "Interaction Types All", len(int_names), 0, len(int_names))
        h_int_types_all.SetFillColor(38)
        h_int_types_all.SetBarWidth(0.5)
        h_int_types_all.SetBarOffset(0.25)
        h_int_types_all.SetStats(0)
        for i in range(1, len(int_names)+1):
            h_int_types_all.GetXaxis().SetBinLabel(i, int_names[i-1])

        h_int_types_passed = ROOT.TH1F("int_types_passed", "Interaction Types Passed", len(int_names), 0, len(int_names))
        h_int_types_passed.SetFillColor(38)
        h_int_types_passed.SetBarWidth(0.5)
        h_int_types_passed.SetBarOffset(0.25)
        h_int_types_passed.SetStats(0)
        for i in range(1, len(int_names)+1):
            h_int_types_passed.GetXaxis().SetBinLabel(i, int_names[i-1])

        h_nu_energy_all, h_par_num_all, h_par_type_all  = [], [], []
        h_nu_energy_passed, h_par_num_passed, h_par_type_passed, h_final_codes_passed = [], [], [], []
        for i in range(len(int_names)):
            h_nu_energy_all.append(ROOT.TH1F(
                    ("nu_energy_all_" + int_names[i]),
                    ("Neutrino Energy for type " + int_names[i]),
                    150, 0, 15000))
            h_par_num_all.append(ROOT.TH1F(
                    ("par_num_all_" + int_names[i]),
                    ("Number of particles for type " + int_names[i]),
                    20, 0, 20))
            h_par_type_all.append(ROOT.TH1F(
                    ("par_type_all_" + int_names[i]),
                    ("Type of particles for type " + int_names[i]),
                    len(par_codes), 0, len(par_codes)))
            for j in range(1, len(par_codes)+1):
                h_par_type_all[i].GetXaxis().SetBinLabel(j, par_names[j-1])

            h_nu_energy_passed.append(ROOT.TH1F(
                    ("nu_energy_passed_" + int_names[i]),
                    ("Neutrino Energy for type " + int_names[i]),
                    150, 0, 15000))
            h_par_num_passed.append(ROOT.TH1F(
                    ("par_num_passed_" + int_names[i]),
                    ("Number of particles for type " + int_names[i]),
                    20, 0, 20))
            h_par_type_passed.append(ROOT.TH1F(
                    ("par_type_passed_" + int_names[i]),
                    ("Type of particles for type " + int_names[i]),
                    len(par_codes), 0, len(par_codes)))
            for j in range(1, len(par_codes)+1):
                h_par_type_passed[i].GetXaxis().SetBinLabel(j, par_names[j-1])
            h_final_codes_passed.append(ROOT.TH1F(
                    ("final_codes_passed_" + int_names[i]),
                    ("Final states for type" + int_names[i]),
                    len(final_names), 0, len(final_names)))
            for j in range(1, len(final_names)+1):
                h_final_codes_passed[i].GetXaxis().SetBinLabel(j, final_names[j-1])

        # Loop through all files in the input directory
        files = listdir(self.input_dir)
        random.shuffle(files)
        event_list = []
        for file in files:
            if not file.endswith(".vec"):
                continue
            print("Selecting from {}".format(file))

            # Open file and fill lines with its content
            lines = []
            with open(os.path.join(self.input_dir, file)) as f:
                lines = f.readlines()

            event = []  # Define array to hold an event
            for line in lines:
                if line.startswith("$ begin"):  # Find the event start
                    event = [line]
                else:  # Add lines including the end of the event
                    event.append(line)

                if line.startswith("$ end"):  # We now see if we want the the event
                    # Set the selection flags
                    required_type_event = True if len(self.required_types) == 0 else False
                    required_particle_event = True if len(self.required_particles) == 0 else False

                    events += 1  # Increment the total event counter

                    event_int_code = -1
                    event_nu_energy = 0.0
                    final_state = [0, 0, 0, 0, 0, 0]
                    num_particles = 0
                    num_particles_passed = 0

                    for event_line in event:
                        # See if event has required interaction type code
                        if event_line.startswith("$ nuance"):
                            event_int_code = int(event_line.split(' ')[2])
                            if event_int_code in self.required_types:
                                required_type_event = True

                        if (event_line.startswith("$ track 12") or
                            event_line.startswith("$ track -12") or
                            event_line.startswith("$ track 14") or
                            event_line.startswith("$ track -14") or
                            event_line.startswith("$ track 13")) and event_line.endswith(" -1\n"):
                            event_nu_energy = float(event_line.split(' ')[3])
                            
                        # See if final state particle pass Cherenkov threshold
                        if event_line.startswith("$ track") and (event_line.endswith(" 0\n")):
                            num_particles += 1
                            particle = int(event_line.split(' ')[2])
                            energy = float(event_line.split(' ')[3])
                            temp_passed = num_particles_passed
                            # Electron
                            if particle in [11, -11] and energy > t_electron:
                                num_particles_passed += 1
                                final_state[0] += 1
                            # Muon
                            elif particle in [13, -13] and energy > t_muon:
                                num_particles_passed += 1
                                final_state[1] += 1
                            # Charged Pion
                            elif particle in [211, -211] and energy > t_pion:
                                num_particles_passed += 1
                                final_state[2] += 1
                            # Neutral Pion, a few pair productions
                            elif particle in [111] and energy > (20*m_electron):
                                num_particles_passed += 1
                                final_state[3] += 1
                            # Proton    
                            elif particle in [2212, -2212] and energy > t_proton:
                                num_particles_passed += 1
                                final_state[4] += 1
                            # Photon, a few pair productions
                            elif particle in [22] and energy > (20*m_electron):
                                num_particles_passed += 1
                                final_state[5] += 1
                            # Charged Kaon
                            elif particle in [321, -321] and energy > t_kaon:
                                num_particles_passed += 1
                            # Charged Sigma
                            elif particle in [3112, 3222] and energy > t_sigma:
                                num_particles_passed += 1
                            # Charged D-Meson
                            elif particle in [411] and energy > t_d:
                                num_particles_passed += 1
                            # Check we know any other particle
                            elif particle not in [11, -11, 13, -13, 211, -211, 111, 2212, 22, 321, -321, 3112,
                                                  12, -12, 14, -14, 130, 311, -311, 411,
                                                  421, 431, -2212, -2112, 2112, 3122, 3112, -3122, 3222, 
                                                  3212, 8016, 4212, 4122, 4222]:
                                print("Don't know particle {}".format(particle))

                            if temp_passed < num_particles_passed:  # This particle has passed
                                h_par_type_passed[event_int_codes.index(event_int_code)].Fill(par_codes.index(particle))
                                if particle in self.required_particles:
                                    required_particle_event = True

                            h_par_type_all[event_int_codes.index(event_int_code)].Fill(par_codes.index(particle))

                    # Fill histograms
                    h_int_types_all.Fill(event_int_codes.index(event_int_code))
                    h_nu_energy_all[event_int_codes.index(event_int_code)].Fill(event_nu_energy)
                    h_par_num_all[event_int_codes.index(event_int_code)].Fill(num_particles)
                    h_par_num_passed[event_int_codes.index(event_int_code)].Fill(num_particles_passed)

                    try:
                        state = final_codes.index(final_state)
                    except Exception:
                        state = len(final_names)-1
                    h_final_codes_passed[event_int_codes.index(event_int_code)].Fill(state)

                    if required_type_event and required_particle_event and (num_particles_passed > 0):
                        h_int_types_passed.Fill(event_int_codes.index(event_int_code))
                        h_nu_energy_passed[event_int_codes.index(event_int_code)].Fill(event_nu_energy)
                        passed_events += 1
                        event_list.append(event)
                    
                    if not required_type_event:
                        types_cut_events += 1
                    if not required_particle_event:
                        particles_cut_events += 1
                    if num_particles_passed == 0:
                        threshold_cut_events += 1

        print("Creating output files for total Events: {}, passed: {}...".format(events, len(event_list)))

        # Write plots to file
        plots_file = ROOT.TFile(self.plot_path, "RECREATE")
        h_int_types_all.Write()
        h_int_types_passed.Write()
        for i in range(len(event_int_codes)):
            h_nu_energy_all[i].Write()
            h_par_num_all[i].Write()
            h_par_type_all[i].Write()
            h_nu_energy_passed[i].Write()
            h_par_num_passed[i].Write()
            h_par_type_passed[i].Write()
            h_final_codes_passed[i].Write()
        plots_file.Close()

        summary_name, ext = os.path.splitext(self.plot_path)
        summary_name += ".txt"
        with open(summary_name, "w") as file:
            file.write("Events: " + str(events))
            file.write("\nPassed: " + str(passed_events))
            file.write("\nType Cut: " + str(types_cut_events))
            file.write("\nParticle Cut: " + str(particles_cut_events))
            file.write("\nThreshold Cut: " + str(threshold_cut_events))

        random.shuffle(event_list)
        for file_num, file_event_num in enumerate(range(0, len(event_list), self.output_size)):
            output_name = "selected_" + str(file_num).zfill(3) + ".vec"
            with open(os.path.join(self.output_dir, output_name),'w') as output_file:
                for event_num in range(self.output_size):
                    try:
                        for event in event_list[file_event_num+event_num]:
                            output_file.write(event)
                    except Exception:
                        pass