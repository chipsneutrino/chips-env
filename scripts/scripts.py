# -*- coding: utf-8 -*-

"""Python script to generate scripts for running gen/sim/map/reco

We assume that this is run within the singularity container. We need it to
have access to both...

 - The chips-env directory at /opt/chips-env
 - The production directory to modify or produce job scripts within at /opt/prod

It becomes a little complicated as we need to know the absolute host path
of the production directory as we are producing scripts that can be run on the host
to submit the jobs outside the container.

We also need to know the chips-env path on the host in order to be able to mount it
and the Geant4 data directory correctly.

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
    
    def __init__(self, sub_prod):
        """Initialise the ScriptMaker.
        Args:
            sub_prod (str): sub-production directory
        """
        # Host paths
        self.host_prod = path.join(os.getenv('HOSTPROD'), sub_prod)
        self.host_env = os.getenv('HOSTENV')
        self.host_geant4 = os.getenv('HOSTGEANT4')

        # Container paths
        self.env = os.getenv('ENV')
        self.prod = path.join(os.getenv('PROD'), sub_prod)

        # Job settings
        self.gen_size = 100000
        self.sim_size = 2000

        # Singularity execution prefix
        container_path = path.join(self.host_env, "env/chips-env.sif")
        self.exec = (
            "singularity exec -B " +
            self.host_env + ":" + self.env + "," +
            self.host_geant4 + ":/opt/data/geant4," +
            self.host_prod + ":" + self.prod + " " +
            container_path + " "
        )

    # Make all the directories in the production directory path
    def make_dir(self):
        """Generates the required directory structure.
        """
        try:
            os.mkdir(path.join(self.prod, "gen/"))
            os.mkdir(path.join(self.prod, "gen/all/"))
            os.mkdir(path.join(self.prod, "gen/selected/"))
            os.mkdir(path.join(self.prod, "sim/"))
            os.mkdir(path.join(self.prod, "map/"))
            os.mkdir(path.join(self.prod, "reco/"))
            os.mkdir(path.join(self.prod, "plots/"))
            os.mkdir(path.join(self.prod, "scripts/"))
            os.mkdir(path.join(self.prod, "scripts/gen/"))
            os.mkdir(path.join(self.prod, "scripts/sim/"))
            os.mkdir(path.join(self.prod, "scripts/map/"))
            os.mkdir(path.join(self.prod, "scripts/reco/"))
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
        jobs = open(path.join(self.prod, "scripts/gen.sh"), "w")
        jobs.write("#!/bin/sh")

        # Loop through all the generation scripts we need to make
        for i in range(int(int(num_events)/int(self.gen_size))):
            # Create the options required
            script_name = path.join(self.prod, "scripts/gen/", "gen_" + "{:03d}".format(i) + ".sh")
            output_name = "gen_" + "{:03d}".format(i) + ".vec"
            output_root = "gen_" + "{:03d}".format(i) + ".root"
            flux_file = path.join(self.env, 'chips/chips-gen/config/flux.root')
            xsec_file = path.join(self.env, 'chips/chips-gen/config/xsecs.xml')
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
                " --message-thresholds /opt/genie/config/Messenger_laconic.xml > /dev/null"
            )
            script.write("\n" + self.exec + "gntpc -i gntp.0.ghep.root -f nuance_tracker -o gen.vec > /dev/null")
            script.write("\nmv gen.vec " + path.join(self.host_prod, "gen/all/", output_name))
            script.write("\nmv gntp.0.ghep.root " + path.join(self.host_prod, "gen/all/", output_root))
            script.write("\ncd ../")
            script.write("\nrm -rf gen" + str(i))
            script.close()

            # Add script to job sumbission script
            host_name = path.join(self.host_prod, "scripts/gen/", "gen_" + "{:03d}".format(i) + ".sh")
            jobs.write("\nqsub -q medium " + host_name)

        jobs.close()

    def gen_cosmic(self, num_events, detector):
        """Creates the scripts required for cosmic event generation.
        Args:
            num_events (int): Number of events to generate
            detector (int): Chips detector to use
        """
        jobs = open(path.join(self.prod, "scripts/", detector + "_gen.sh"), "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.prod, "gen/all/", detector)):
            os.mkdir(path.join(self.prod, "gen/all/", detector))

        # Loop through all the generation scripts we need to make
        for i in range(int(int(num_events)/int(self.gen_size))):
            script_name = path.join(self.prod, "scripts/gen/",
                                    detector + "_gen_" + "{:03d}".format(i) + ".sh")
            output_name = "gen_" + "{:03d}".format(i) + ".vec"
            cry_conf = path.join(self.env, 'chips/chips-gen/config/cry.conf')
            script = self.blank_job_script(script_name)
            script.write(
                "\n" + self.exec + "cosmicgen" +
                " " + cry_conf +
                " " + str(self.gen_size) +
                " " + detector + " " + str(i)
            )
            script.write(" > " + path.join(self.host_prod, "gen/all/", detector, output_name))
            script.close()

            host_name = path.join(self.host_prod, "scripts/gen/",
                                  detector + "_gen_" + "{:03d}".format(i) + ".sh")
            jobs.write("\nqsub -q short " + host_name)

        jobs.close()

    def select(self, detector):
        """Runs the selection of the generated events and produces plots.
        Args:
            detector (str): Detector directory to use if cosmic
        """
        if detector == "":
            input_dir = path.join(self.prod, "gen/all/")
            output_dir = path.join(self.prod, "gen/selected/")
            plot_path = path.join(self.prod, "plots/", "events.root")
        else:
            if not os.path.isdir(path.join(self.prod, "gen/selected/", detector)):
                os.mkdir(path.join(self.prod, "gen/selected/", detector))
            input_dir = path.join(self.prod, "gen/all/", detector)
            output_dir = path.join(self.prod, "gen/selected/", detector)
            plot_path = path.join(self.prod, "plots/", detector + "_events.root")

        req_particles = []  # Require certain particles
        req_types = []  # Require certain interaction types

        selector = Selector(input_dir, output_dir, plot_path,
                            self.sim_size, req_particles, req_types)
        selector.Run()

    def sim_beam(self, detector, num, start):
        """Creates the scripts required for beam detector simulation.
        Args:
            detector (str): Detector directory to use if cosmic
        """

        print("Creating Simulation Scripts...")
        jobs = open(path.join(self.prod, "scripts/" + detector + "_sim.sh"), "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.prod, "sim/", detector)):
            os.mkdir(path.join(self.prod, "sim/", detector))

        for i, f in enumerate(os.listdir(path.join(self.prod, "gen/selected/"))):
            if i == (int(num) + int(start)):
                break

            if i < int(start):
                continue

            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.prod, "scripts/sim/", detector + "_" + base + "_sim.sh")
            mac_name = path.join(self.prod, "scripts/sim/", detector + "_" + base + "_sim.mac")
            geom_name = path.join(self.env, "chips/chips-sim/config/geom", detector + ".mac")

            script = self.blank_job_script(script_name)
            script.write("\n" + self.exec + "chipssim -g " + geom_name + " " + mac_name)
            script.close()

            mac = open(mac_name, "w")
            text = ("/run/verbose 0\n"
                    "/tracking/verbose 0\n"
                    "/hits/verbose 0\n"
                    "/mygen/vecfile " + path.join(self.prod, "gen/selected/", f) + "\n"
                    "/mygen/useXAxisForBeam true\n"
                    "/mygen/enableRandomVtx true\n"
                    "/mygen/fiducialDist 1.0\n"
                    "/mygen/generator muline\n"
                    "/WCSimIO/SaveRootFile true\n"
                    "/WCSimIO/RootFile " + path.join(self.prod, "sim/", detector, base + "_sim.root") +
                    "\n"
                    "/WCSimIO/SavePhotonNtuple false\n"
                    "/WCSimIO/SaveEmissionProfile false\n"
                    "/WCSimTrack/PercentCherenkovPhotonsToDraw 0.0\n"
                    "/run/beamOn " + str(self.sim_size))
            mac.write(text)
            mac.close()

            host_name = path.join(self.host_prod, "scripts/sim/", detector + "_" + base + "_sim.sh")
            jobs.write("\nqsub -q medium " + host_name)

    def sim_cosmic(self, detector, num, start):
        """Creates the scripts required for cosmic detector simulation."""
        print("Creating Simulation Scripts...")
        jobs = open(path.join(self.prod, "scripts/" + detector + "_sim.sh"), "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.prod, "sim/", detector)):
            os.mkdir(path.join(self.prod, "sim/", detector))

        for i, f in enumerate(os.listdir(path.join(self.prod, "gen/selected/", detector))):
            if i == (int(num) + int(start)):
                break

            if i < int(start):
                continue

            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.prod, "scripts/sim/", detector + "_" + base + "_sim.sh")
            mac_name = path.join(self.prod, "scripts/sim/", detector + "_" + base + "_sim.mac")
            geom_name = path.join(self.env, "chips/chips-sim/config/geom", detector + ".mac")

            script = self.blank_job_script(script_name)
            script.write("\n" + self.exec + "chipssim -g " + geom_name + " " + mac_name)
            script.close()

            rand = int(base[-3:])
            mac = open(mac_name, "w")
            text = ("/run/verbose 0\n"
                    "/tracking/verbose 0\n"
                    "/hits/verbose 0\n"
                    "/mygen/vecfile " + path.join(self.prod, "gen/selected/", detector, f) + "\n"
                    "/mygen/useXAxisForBeam false\n"
                    "/mygen/enableRandomVtx false\n"
                    "/mygen/generator muline\n"
                    "/WCSimIO/SaveRootFile true\n"
                    "/WCSimIO/RootFile " + path.join(self.prod, "sim/", detector, base + "_sim.root") +
                    "\n"
                    "/WCSimIO/SavePhotonNtuple false\n"
                    "/WCSimIO/SaveEmissionProfile false\n"
                    "/WCSimTrack/PercentCherenkovPhotonsToDraw 0.0\n"
                    "/run/beamOn " + str(self.sim_size))
            mac.write(text)
            mac.close()

            host_name = path.join(self.host_prod, "scripts/sim/", detector + "_" + base + "_sim.sh")
            jobs.write("\nqsub -q medium " + host_name)

    def map(self, detector, save_extra, height, radius):
        """Creates the scripts required for hit map generation."""
        jobs = open(path.join(self.prod, "scripts/" + detector + "_map.sh"), "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.prod, "map/", detector)):
            os.mkdir(path.join(self.prod, "map/", detector))

        extra = 'false'
        if save_extra:
            extra = 'true'

        map_mac = path.join(self.env, "scripts/hitmapper.C")
        for f in os.listdir(path.join(self.prod, "sim", detector)):
            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.prod, "scripts/map/", detector + "_" + base + "_map.sh")
            script = self.blank_job_script(script_name)
            script.write('\n' + self.exec + 'root -l -q -b "' + map_mac + '(' +
                         r'\"' + path.join(self.prod, "sim", detector, f) +
                         r'\",' + r'\"' + path.join(self.prod, "map", detector,
                                                    base + "_map.root") +
                         r'\",' + str(self.sim_size) + 
                         r',' + extra +
                         r',' + str(height) +
                         r',' + str(radius) + ')"')
            script.close()

            host_name = path.join(self.host_prod, "scripts/map/", detector + "_" + base + "_map.sh")
            jobs.write("\nqsub -q medium " + host_name)

    def reco(self, num, split, start, detector, height):
        """Creates the scripts required for event reconstruction."""
        jobs = open(path.join(self.prod, "scripts/" + detector + "_reco.sh"), "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.prod, "reco/", detector)):
            os.mkdir(path.join(self.prod, "reco/", detector))

        reco_mac = path.join(self.env, "scripts/basicreco.C")
        for i, f in enumerate(os.listdir(path.join(self.prod, "sim", detector))):
            if i == (int(num) + int(start)):
                break

            if i < int(start):
                continue

            name, ext = path.splitext(f)
            base = path.basename(name)
            for evtCounter in range(0, self.sim_size, int(split)):
                script_name = path.join(self.prod, "scripts/reco/", detector + "_" +
                                        base + "_" + str(evtCounter) + "_reco.sh")
                script = self.blank_job_script(script_name)
                script.write("\ncd " + path.join(self.host_prod, "reco", detector))
                script.write('\n' + self.exec + 'root -l -q -b "' + reco_mac + '(' +
                             r'\"' + path.join(self.prod, "sim", detector, f) +
                             r'\",' + str(evtCounter) +
                             r',' + str(split) +
                             r',' + str(height) +')"')
                script.close()

                host_name = path.join(self.host_prod, "scripts/reco/", detector + "_" +
                                      base + "_" + str(evtCounter) + "_reco.sh")
                jobs.write("\nqsub -q medium " + host_name)


def parse_args():
    """Parse the command line arguments."""
    parser = argparse.ArgumentParser(description='Creates batch farm submission scripts')
    parser.add_argument('subprod', help='path to the sub-production directory')
    parser.add_argument('--job', default='make', choices=['make', 'gen', 'select', 'sim', 'map', 'reco'],
                        help='job to make scripts for')
    parser.add_argument('-n', '--num', help='number of events to gen or files to use', default=1000)

    # Additional job sepcific arguments
    parser.add_argument('-p', '--particle', help='Event generation particle: nuel, anuel, numu, anumu, cosmic',
                        default='')
    parser.add_argument('-t', '--type', help='Beam event generation list', default='Default+CCMEC+NCMEC')
    parser.add_argument('-d', '--detector', help='CHIPS detector geometry name', default='')
    parser.add_argument('-s', '--start', help='Selected file to start at', default=0)
    parser.add_argument('--all', action='store_true', help='Save all hit maps to file in mapper')
    parser.add_argument('--split', help='How many events per old reco job', default=25)
    parser.add_argument('--height', help='Detector height in cm', default=1200)
    parser.add_argument('--radius', help='Detector radius in cm', default=1250)

    return parser.parse_args()


def main():
    """Main function called by scripts script.
    """
    args = parse_args()
    if not args:
        print('Invalid Arguments')
        sys.exit(1)

    print("Using sub-production directory {}".format(args.subprod))
    maker = ScriptMaker(args.subprod)
    job = args.job
    if job == 'make':
        print("Making directories...")
        maker.make_dir()
    elif job == 'gen' and args.particle != 'cosmic':
        print("Making beam generation scripts...")
        maker.gen_beam(args.num, args.particle, args.type)
    elif job == 'gen' and args.particle == 'cosmic':
        print("Making cosmic generation scripts...")
        maker.gen_cosmic(args.num, args.detector)
    elif job == 'select':
        print("Running selection...")
        maker.select(args.detector)
    elif job == 'sim' and args.particle != 'cosmic':
        print("Making beam simulation scripts...")
        maker.sim_beam(args.detector, args.num, args.start)
    elif job == 'sim' and args.particle == 'cosmic':
        print("Making cosmic simulation scripts...")
        maker.sim_cosmic(args.detector, args.num, args.start)
    elif job == 'map':
        print("Making mapping scripts...")
        maker.map(args.detector, args.all, args.height, args.radius)
    elif job == 'reco':
        print("Making reconstruction scripts...")
        maker.reco(args.num, args.split, args.start, args.detector, args.height)


if __name__ == '__main__':
    main()
