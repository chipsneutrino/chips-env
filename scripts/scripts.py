# -*- coding: utf-8 -*-

"""Python script to generate scripts for running gen/sim/map/reco

Author: Josh Tingey
Email: j.tingey.16@ucl.ac.uk
"""

import os
import os.path as path
import sys
from selector import Selector
import argparse
import json


class ScriptMaker:
    """Class controlling all the stages of script production.
    """
    
    def __init__(self, host_prod, host_env):
        """Initialise the ScriptMaker.
        Args:
            prod_dir (str): Event type production directory in PRODDIR
        """
        # Host paths
        self.host_prod = host_prod
        self.host_setup = path.join(host_env, 'setup.sh')

        # Container path
        self.container_env = '/opt/chips-env'
        self.container_prod = '/opt/prod'

        # Job settings
        self.gen_size = 10
        self.sim_size = 2000
        self.exec = (
            "singularity exec -B " +
            host_env + ":" + self.container_env + "," +
            host_env + "/chips/chips-sim/config/geant4:/opt/data/geant4," +
            host_prod + ":" + self.container_prod + " " +
            host_env + "/env/chips-env.sif "
        )
        print self.exec

    # Make all the directories in the production directory path
    def make_dir(self):
        """Generates the required directory structure.
        """
        try:
            os.mkdir(path.join(self.container_prod, "gen/"))
            os.mkdir(path.join(self.container_prod, "gen/all/"))
            os.mkdir(path.join(self.container_prod, "gen/selected/"))
            os.mkdir(path.join(self.container_prod, "sim/"))
            os.mkdir(path.join(self.container_prod, "map/"))
            os.mkdir(path.join(self.container_prod, "tf/"))
            os.mkdir(path.join(self.container_prod, "reco/"))
            os.mkdir(path.join(self.container_prod, "plots/"))
            os.mkdir(path.join(self.container_prod, "scripts/"))
            os.mkdir(path.join(self.container_prod, "scripts/gen/"))
            os.mkdir(path.join(self.container_prod, "scripts/sim/"))
            os.mkdir(path.join(self.container_prod, "scripts/map/"))
            os.mkdir(path.join(self.container_prod, "scripts/reco/"))
        except Exception:
            pass

    def blank_job_script(self, name):
        """Creates a blank bash script.
        Args:
            name (str): Script path name
        """
        script = open(name, "w")
        script.write("#!/bin/bash")
        return script

    def gen_beam(self, num_events, particle, event_type):
        """Creates the scripts required for beam event generation.
        Args:
            num_events (int): Number of events to generate
            particle (int): Particle PDG code
            event_type (str): Type of event generation
        """
        jobs = open(path.join(self.host_prod, "scripts/gen.sh"), "w")
        jobs.write("#!/bin/sh")
        jobs.write("\nchmod +x " + path.join(self.host_prod, "scripts/gen/") + "*gen*.sh")

        # Loop through all the generation scripts we need to make
        for i in range(int(int(num_events)/int(self.gen_size))):
            # Create the options required
            script_name = path.join(self.host_prod, "scripts/gen/", "gen_" + "{:03d}".format(i) + ".sh")
            output_name = "gen_" + "{:03d}".format(i) + ".vec"
            output_root = "gen_" + "{:03d}".format(i) + ".root"
            flux_file = path.join(self.container_env, 'chips/chips-gen/config/flux.root')
            xsec_file = path.join(self.container_env, 'chips/chips-gen/config/xsecs.xml')
            if particle == "numu":
                spec = flux_file + ",enufullfine_numu_allpar_NoXSec_CHIPSoffAXIS"
                pid = 14
            if particle == "anumu":
                spec = flux_file + ",enufullfine_anumu_allpar_NoXSec_CHIPSoffAXIS"
                pid = -14
            elif particle == "nuel":
                spec = flux_file + ",enufullfine_nue_allpar_NoXSec_CHIPSoffAXIS"
                pid = 12
            elif particle == "anuel":
                spec = flux_file + ",enufullfine_anue_allpar_NoXSec_CHIPSoffAXIS"
                pid = -12

            # Create the script
            script = self.blank_job_script(script_name)
            script.write("\ncd " + path.join(self.host_prod, "scripts/gen/"))
            script.write("\nmkdir gen" + str(i))
            script.write("\ncd gen" + str(i))
            script.write(
                "\n" + self.exec + "gevgen " +
                "-n " + str(self.gen_size) +
                " -e 0.5,15" +
                " -p " + str(pid) +
                " -t 1000080160[0.8879],1000010010[0.1121]" +
                " -r 0" +
                " -f " + spec +
                " --seed " + str(i) +
                " --cross-sections " + xsec_file +
                " --event-generator-list " + event_type +
                " --message-thresholds /opt/genie/config/Messenger_laconic.xml"
            )
            script.write("\nchips exec gntpc -i gntp.0.ghep.root -f nuance_tracker -o gen.vec)
            script.write("\nmv gen.vec " + path.join(self.host_prod, "gen/all/", output_name))
            script.write("\nmv gntp.0.ghep.root " + path.join(self.host_prod, "gen/all/", output_root))
            script.write("\ncd ../")
            script.write("\nrm -rf gen" + str(i))
            script.close()

            # Add script to job sumbission script
            jobs.write("\nqsub -q medium " + script_name)

        jobs.close()

    def gen_cosmic(self, num_events, detector):
        """Creates the scripts required for cosmic event generation.
        Args:
            num_events (int): Number of events to generate
            detector (int): Chips detector to use
        """
        jobs = open(path.join(self.host_prod, "scripts/", detector + "_gen.sh"), "w")
        jobs.write("#!/bin/sh")
        jobs.write("\nchmod +x " + path.join(self.host_prod, "scripts/gen/") + "*gen*.sh")

        if not os.path.isdir(path.join(self.host_prod, "gen/all/", detector)):
            os.mkdir(path.join(self.host_prod, "gen/all/", detector))

        # Loop through all the generation scripts we need to make
        for i in range(int(int(num_events)/int(self.gen_size))):
            script_name = path.join(self.host_prod, "scripts/gen/",
                                    detector + "_gen_" + "{:03d}".format(i) + ".sh")
            output_name = "gen_" + "{:03d}".format(i) + ".vec"
            cry_conf = path.join(self.container_env, 'chips/chips-gen/config/cry.conf')
            script = self.blank_script(script_name)
            script.write(
                "\nchips exec cosmicgen" +
                " " + cry_conf +
                " " + str(self.gen_size) +
                " " + detector + " " + str(i)
            )
            script.write(" > " + path.join(self.host_prod, "gen/all/", detector, output_name))
            script.close()

            jobs.write("\nqsub -q short " + script_name)

        jobs.close()

    def select(self, detector):
        """Runs the selection of the generated events and produces plots.
        Args:
            detector (str): Detector directory to use if cosmic
        """
        if detector == "":
            input_dir = path.join(self.dir, "gen/all/")
            output_dir = path.join(self.dir, "gen/selected/")
            plot_path = path.join(self.dir, "plots/", "events.root")
        else:
            if not os.path.isdir(path.join(self.dir, "gen/selected/", detector)):
                os.mkdir(path.join(self.dir, "gen/selected/", detector))
            input_dir = path.join(self.dir, "gen/all/", detector)
            output_dir = path.join(self.dir, "gen/selected/", detector)
            plot_path = path.join(self.dir, "plots/", detector + "_events.root")

        req_particles = []  # Require certain particles
        req_types = []  # Require certain interaction types

        selector = Selector(input_dir, output_dir, plot_path,
                            self.config["sim_size"],
                            req_particles, req_types)
        selector.Run()

    def sim_beam(self, detector, num, start):
        """Creates the scripts required for beam detector simulation.
        Args:
            detector (str): Detector directory to use if cosmic
        """

        print("Creating Simulation Scripts...")
        jobs = open(path.join(self.dir, "scripts/" + detector + "_sim.sh"), "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.dir, "sim/", detector)):
            os.mkdir(path.join(self.dir, "sim/", detector))

        for i, f in enumerate(os.listdir(path.join(self.dir, "gen/selected/"))):
            if i == int(num):
                break

            if i < int(start):
                continue

            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.dir, "scripts/sim/", detector + "_" + base + "_sim.sh")
            mac_name = path.join(self.dir, "scripts/sim/", detector + "_" + base + "_sim.mac")

            script = self.blank_script(script_name)
            script.write("\nsource " + self.config["setup"])
            script.write("\ncd $WCSIMHOME")
            script.write("\nWCSim -g " + self.config[detector] + " " + mac_name)
            script.close()

            mac = open(mac_name, "w")
            text = ("/run/verbose 0\n"
                    "/tracking/verbose 0\n"
                    "/hits/verbose 0\n"
                    "/mygen/vecfile " + path.join(self.dir, "gen/selected/", f) + "\n"
                    "/mygen/useXAxisForBeam true\n"
                    "/mygen/enableRandomVtx true\n"
                    "/mygen/fiducialDist 1.0\n"
                    "/mygen/generator muline\n"
                    "/WCSimIO/SaveRootFile true\n"
                    "/WCSimIO/RootFile " + path.join(self.dir, "sim/", detector, base + "_sim.root") +
                    "\n"
                    "/WCSimIO/SavePhotonNtuple false\n"
                    "/WCSimIO/SaveEmissionProfile false\n"
                    "/WCSimTrack/PercentCherenkovPhotonsToDraw 0.0\n"
                    "/run/beamOn " + str(self.config["sim_size"]))
            mac.write(text)
            mac.close()

            jobs.write("\nqsub -q medium " + script_name)

    def sim_cosmic(self, detector, num, start):
        """Creates the scripts required for cosmic detector simulation."""
        print("Creating Simulation Scripts...")
        jobs = open(path.join(self.dir, "scripts/" + detector + "_sim.sh"), "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.dir, "sim/", detector)):
            os.mkdir(path.join(self.dir, "sim/", detector))

        for i, f in enumerate(os.listdir(path.join(self.dir, "gen/selected/", detector))):
            if i == int(num):
                break

            if i < int(start):
                continue

            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.dir, "scripts/sim/", detector + "_" + base + "_sim.sh")
            mac_name = path.join(self.dir, "scripts/sim/", detector + "_" + base + "_sim.mac")

            script = self.blank_script(script_name)
            script.write("\nsource " + self.config["setup"])
            script.write("\ncd $WCSIMHOME\n")
            script.write("\nWCSim -g " + self.config[detector] + " " + mac_name)
            script.close()

            rand = int(base[-3:])
            mac = open(mac_name, "w")
            text = ("/run/verbose 0\n"
                    "/tracking/verbose 0\n"
                    "/hits/verbose 0\n"
                    "/mygen/vecfile " + path.join(self.dir, "gen/selected/", detector, f) + "\n"
                    "/mygen/useXAxisForBeam false\n"
                    "/mygen/enableRandomVtx false\n"
                    "/mygen/generator muline\n"
                    "/WCSimIO/SaveRootFile true\n"
                    "/WCSimIO/RootFile " + path.join(self.dir, "sim/", detector, base + "_sim.root") +
                    "\n"
                    "/WCSimIO/SavePhotonNtuple false\n"
                    "/WCSimIO/SaveEmissionProfile false\n"
                    "/WCSimTrack/PercentCherenkovPhotonsToDraw 0.0\n"
                    "/WCSim/random/seed " + str(rand) + "\n"
                    "/run/beamOn " + str(self.config["sim_size"]))
            mac.write(text)
            mac.close()

            jobs.write("\nqsub -q medium " + script_name)

    def map(self, detector, save_extra):
        """Creates the scripts required for hit map generation."""
        print("Creating Mapping Scripts...")
        jobs = open(path.join(self.dir, "scripts/" + detector + "_map.sh"), "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.dir, "map/", detector)):
            os.mkdir(path.join(self.dir, "map/", detector))

        for f in os.listdir(path.join(self.dir, "sim", detector)):
            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.dir, "scripts/map/", detector + "_" + base + "_map.sh")
            script = self.blank_script(script_name)
            script.write("\nsource " + self.config["setup"])
            script.write('\nroot -l -q -b "' + self.config["map_mac"] + '(' +
                         r'\"' + path.join(self.dir, "sim", detector, f) +
                         r'\",' + r'\"' + path.join(self.dir, "map", detector,
                                                    base + "_map.root") +
                         r'\",' + str(self.config["sim_size"]) + 
                         r',' + str(save_extra) + ')"')
            script.close()

            jobs.write("\nqsub -q medium " + script_name)

    def reco(self, num, split, detector):
        """Creates the scripts required for event reconstruction."""
        print("Creating Reconstruction Scripts...")
        jobs = open(path.join(self.dir, "scripts/" + detector + "_reco.sh"), "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.dir, "reco/", detector)):
            os.mkdir(path.join(self.dir, "reco/", detector))

        for i, f in enumerate(os.listdir(path.join(self.dir, "sim", detector))):
            if i == int(num):
                break

            name, ext = path.splitext(f)
            base = path.basename(name)
            for evtCounter in range(0, self.config["sim_size"], int(split)):
                script_name = path.join(self.dir, "scripts/reco/", detector + "_" +
                                        base + "_" + str(evtCounter) + "_reco.sh")
                script = self.blank_script(script_name)
                script.write("\nsource " + self.config["setup"])
                script.write("\ncd " + path.join(self.dir, "reco", detector))
                script.write('\nroot -l -q -b "' + self.config["reco_mac"] + '(' +
                             r'\"' + path.join(self.dir, "sim", detector, f) +
                             r'\",' + str(evtCounter) +
                             r',' + str(split) + ')"')
                script.close()

                jobs.write("\nqsub -q medium " + script_name)


def parse_args():
    """Parse the command line arguments."""
    parser = argparse.ArgumentParser(description='Creates batch farm submission scripts')
    parser.add_argument('hostenv', help='path to host chips-env directory')
    parser.add_argument('hostprod', help='path to input production directory')
    parser.add_argument('--job', default='make', choices=['make', 'gen', 'select', 'sim', 'map', 'reco'],
                        help='job to make scripts for')
    parser.add_argument('-n', '--num', help='number of events to gen or files to use', default=1000)

    # Additional job sepcific arguments
    parser.add_argument('-p', '--particle', help='Event generation particle: nuel, anuel, numu, anumu, cosmic')
    parser.add_argument('-t', '--type', help='Beam event generation list', default='Default+CCMEC+NCMEC')
    parser.add_argument('-d', '--detector', help='CHIPS detector geometry name', default='chips_1200')
    parser.add_argument('-s', '--start', help='Selected file to start at', default=0)
    parser.add_argument('--all', action='store_true', help='Save all hit maps to file in mapper')
    parser.add_argument('--split', help='How many events per old reco job', default=100)

    return parser.parse_args()


def main():
    """Main function called by scripts script.
    """
    args = parse_args()
    if not args:
        print('Invalid Arguments')
        sys.exit(1)

    print("Creating scripts for {}".format(args.hostprod))
    maker = ScriptMaker(args.hostprod, args.hostenv)
    job = args.job
    if job == 'make':
        maker.make_dir()
    elif job == 'gen' and args.particle != 'cosmic':
        maker.gen_beam(args.num, args.particle, args.type)
    elif job == 'gen' and args.particle == 'cosmic':
        maker.gen_cosmic(args.num, args.detector)
    elif job == 'select':
        maker.select(args.detector)
    elif job == 'sim' and args.particle != 'cosmic':
        maker.sim_beam(args.detector, args.num, args.start)
    elif job == 'sim' and args.particle == 'cosmic':
        maker.sim_cosmic(args.geom, args.detector, args.num, args.start)
    elif job == 'map':
        maker.map(args.detector, args.all)
    elif job == 'reco':
        maker.reco(args.num, args.split, args.detector)


if __name__ == '__main__':
    main()
