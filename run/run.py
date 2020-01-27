# -*- coding: utf-8 -*-
"""Python script to generate running scripts for gen/sim/map/reco

Author: Josh Tingey
Email: j.tingey.16@ucl.ac.uk

The general pipeline we run in CHIPS is...

event generation -> event filtering -> detector simulation ->
    -> hit mapping(or reco) -> network training

This script defines a directory structure given below and uses this
to generate scripts to run every stage of this pipeline on the batch
farm. Each directory is designed to contain events of a particular
type. For an example of this structure visit /unix/chips/production.

directory (for every event type)
├── _gen
|   ├── _all [all genie .vec events]
|   └── _filtered [filtered genie .vec events]
├── _map
|   └── _[geometry]
|       └── [mapper output .root files]
├── _plots [output plot files]
├── _reco
|   └── _[geometry]
|       └── [reconstruction output .root files]
├── _scripts
|   ├── gen [event generation scripts]
|   ├── map [event mapping scripts]
|   ├── reco [event reconstruction scripts]
|   ├── sim [event simulation scripts]
|   └── [batch farm submission scripts]
├── _sim
|   └── _[geometry]
|       └── [simulation output .root files]
└── _tf
    └── _[geometry]
        ├── _train [training .tfrecords files]
        ├── _val [validation .tfrecords files]
        └── _test [testing .tfrecords files]

Using a given directory $(DIR) an example pipeline would require the
following commands, with $(RUN) being this directory...

$ python run.py $(DIR) --make
$ python run.py $(DIR) --gen -e 1000000 -p nuel -t QEL-CC
$ cd $(DIR)/scripts/gen
$ source ../gen.sh
(wait for generation jobs to finish)
$ cd $(RUN)
$ python run.py $(DIR) --filter
$ python run.py $(DIR) --sim -g chips_1200_sk1pe
$ cd $(DIR)/scripts/sim
$ source ../chips_1200_sk1pe_sim.sh
(wait for simulation jobs to finish)
$ cd $(RUN)
$ python run.py $(DIR) --map -g chips_1200_sk1pe --pdg 11
$ cd $(DIR)/scripts/map
$ source ../chips_1200_sk1pe_map.sh

GENIE Event Types:
    - QEL-CC (quasi-elastic charged-current)
    - QEL-NC (quasi-elastic neutral-current)
    - RES-CC (resonant charged-current)
    - RES-NC (resonant neutral-current)
    - DIS-CC (deep inelastic scattering charged-current)
    - DIS-NC (deep inelastic scattering neutral-current)
    - COH-CC (coherent charged-current)
    - COH-NC (coherent neutral-current)
    - QEL-CHARM (quasi-elastic charmed charged-current)
    - DIS-CHARM (deep inelastic scattering charmed charged-current)
"""

import os.path as path
import sys
import os
from selector import Selector
import argparse
import json


class CHIPSRunner:
    """Class controlling all the stages of script production."""
    def __init__(self, dir, config_file):
        self.dir = dir
        self.config = self.load_config(config_file)

    # Load the configuration from the json file
    def load_config(self, config_file):
        """Loads the configuration from file."""
        with open(config_file, 'r') as config:
            config_dict = json.load(config)
        return config_dict

    # Make all the directories in the production directory path
    def make_dir(self):
        """Generates the required directory structure."""
        try:
            os.mkdir(path.join(self.dir, "gen/"))
            os.mkdir(path.join(self.dir, "gen/all/"))
            os.mkdir(path.join(self.dir, "gen/filtered/"))
            os.mkdir(path.join(self.dir, "sim/"))
            os.mkdir(path.join(self.dir, "map/"))
            os.mkdir(path.join(self.dir, "tf/"))
            os.mkdir(path.join(self.dir, "reco/"))
            os.mkdir(path.join(self.dir, "plots/"))
            os.mkdir(path.join(self.dir, "scripts/"))
            os.mkdir(path.join(self.dir, "scripts/gen/"))
            os.mkdir(path.join(self.dir, "scripts/sim/"))
            os.mkdir(path.join(self.dir, "scripts/map/"))
            os.mkdir(path.join(self.dir, "scripts/reco/"))
        except FileExistsError:
            pass

    def blank_script(self, name):
        """Creates a blank bash script."""
        script = open(name, "w")
        script.write("#!/bin/bash")
        return script

    def gen_beam(self, ev, par, type):
        """Creates the scripts required for beam event generation."""
        print("Creating Generation Scripts...")
        jobs = open(path.join(self.dir, "scripts/gen.sh"), "w")
        jobs.write("#!/bin/sh")
        jobs.write("\nchmod +x " + path.join(self.dir, "scripts/gen/") +
                   "*gen*.sh")
        num_jobs = int(ev)/self.config["gen_job_size"]
        for i in range(num_jobs):
            script_name = path.join(self.dir, "scripts/gen/", "gen_" +
                                    "{:03d}".format(i) + ".sh")
            output_name = "gen_" + "{:03d}".format(i) + ".vec"
            script = self.blank_script(script_name)
            script.write("\nsource " + self.config["gen_setup"])
            if par == "numu":
                spec = self.config["spec_file"] + ",spectrum-numu"
                pid = 14
                script.write("\nexport GSPLOAD=" + self.config["numu_xsec"])
            elif par == "nuel":
                spec = self.config["spec_file"] + ",spectrum-nuel"
                pid = 12
                script.write("\nexport GSPLOAD=" + self.config["nuel_xsec"])
            if type == "":
                script.write("\nunset GEVGL")
            else:
                script.write("\nexport GEVGL=" + type)
            script.write("\nexport GSEED=" + str(i))
            script.write("\ncd " + path.join(self.dir, "scripts/gen/"))
            script.write("\nmkdir gen" + str(i))
            script.write("\ncd gen" + str(i))
            script.write("\ngevgen -n " + str(self.config["gen_job_size"]) +
                         " -s -e 0.5,15 -p " + str(pid) +
                         " -t 1000080160[0.95],1000010010[0.05] -r 0 -f " +
                         spec + " > /dev/null")
            script.write("\ngntpc -i gntp.0.ghep.root -f nuance_tracker -o " +
                         output_name + " > /dev/null")
            script.write("\nmv " + output_name + " " +
                         path.join(self.dir, "gen/all/", output_name))
            script.write("\ncd ../")
            script.write("\nrm -rf gen" + str(i))
            script.close()

            jobs.write("\nqsub -q medium " + script_name)

    def gen_cosmic(self, ev):
        """Creates the scripts required for cosmic event generation."""
        print("Creating Generation Scripts...")
        jobs = open(path.join(self.dir, "scripts/gen.sh"), "w")
        jobs.write("#!/bin/sh")
        jobs.write("\nchmod +x " + path.join(self.dir, "scripts/gen/") +
                   "*gen*.sh")
        num_jobs = int(ev)/self.config["gen_job_size"]
        for i in range(num_jobs):
            script_name = path.join(self.dir, "scripts/gen/", "gen_" +
                                    "{:03d}".format(i) + ".sh")
            output_name = "gen_" + "{:03d}".format(i) + ".vec"
            script = self.blank_script(script_name)
            script.write("\nsource " + self.config["gen_setup"])
            script.write("\ncosmicGen " + self.config["cosmic_config"] + " " +
                         str(self.config["gen_job_size"]) + " " +
                         self.config["cosmic_geom"] + " > " +
                         path.join(self.dir, "gen/all/", output_name))
            script.close()
            jobs.write("\nqsub -q long " + script_name)

    def filter(self):
        """Runs the filtering of the generated events and produces plots."""
        print("Running Filter...")
        input_dir = path.join(self.dir, "gen/all/")
        output_dir = path.join(self.dir, "gen/filtered/")
        plot_path = path.join(self.dir, "plots/filtered.root")

        req_particles = []  # Require certain particles
        req_types = []  # Require certain interaction types

        selector = Selector(input_dir, output_dir, plot_path,
                            self.config["gen_select_size"],
                            req_particles, req_types)
        selector.Run()

    def sim_beam(self, geom, num):
        """Creates the scripts required for beam detector simulation."""
        print("Creating Simulation Scripts...")
        jobs = open(path.join(self.dir, "scripts/" + geom + "_sim.sh"),
                    "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.dir, "sim/", geom)):
            os.mkdir(path.join(self.dir, "sim/", geom))

        count = 0
        for f in os.listdir(path.join(self.dir, "gen/filtered/")):
            if count >= int(num):
                break
            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.dir, "scripts/sim/", geom + "_" +
                                    base + "_sim.sh")
            mac_name = path.join(self.dir, "scripts/sim/", geom + "_" +
                                 base + "_sim.mac")

            script = self.blank_script(script_name)
            script.write("source " + self.config["base_setup"] + "\n")
            script.write("source " + self.config["sim_setup"] + "\n")
            script.write("cd $WCSIMHOME\n")
            script.write("WCSim -g " + self.config[geom] + " " + mac_name)
            script.close()

            rand = int(base[-3:])
            mac = open(mac_name, "w")
            text = ("/run/verbose 0\n"
                    "/tracking/verbose 0\n"
                    "/hits/verbose 0\n"
                    "/mygen/vecfile " + path.join(self.dir, "gen/filtered/",
                                                  f) + "\n"
                    "/mygen/useXAxisForBeam true\n"
                    "/mygen/enableRandomVtx true\n"
                    "/mygen/fiducialDist 1.0\n"
                    "/mygen/generator muline\n"
                    "/WCSimIO/SaveRootFile true\n"
                    "/WCSimIO/RootFile " + path.join(self.dir, "sim/", geom,
                                                     base + "_sim.root") + "\n"
                    "/WCSimIO/SavePhotonNtuple false\n"
                    "/WCSimIO/SaveEmissionProfile false\n"
                    "/WCSimTrack/PercentCherenkovPhotonsToDraw 0.0\n"
                    "/WCSim/random/seed " + str(rand) + "\n"
                    "/run/beamOn " + str(self.config["gen_select_size"]))
            mac.write(text)
            mac.close()

            jobs.write("\nqsub -q medium " + script_name)

            count += 1

    def sim_cosmic(self, geom, num):
        """Creates the scripts required for cosmic detector simulation."""
        print("Creating Simulation Scripts...")
        jobs = open(path.join(self.dir, "scripts/" + geom + "_sim.sh"),
                    "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.dir, "sim/", geom)):
            os.mkdir(path.join(self.dir, "sim/", geom))

        count = 0
        for f in os.listdir(path.join(self.dir, "gen/filtered/")):
            if count >= int(num):
                break
            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.dir, "scripts/sim/", geom + "_" +
                                    base + "_sim.sh")
            mac_name = path.join(self.dir, "scripts/sim/", geom + "_" +
                                 base + "_sim.mac")

            script = self.blank_script(script_name)
            script.write("source " + self.config["base_setup"] + "\n")
            script.write("source " + self.config["sim_setup"] + "\n")
            script.write("cd $WCSIMHOME\n")
            script.write("WCSim -g " + self.config[geom] + " " + mac_name)
            script.close()

            rand = int(base[-3:])
            mac = open(mac_name, "w")
            text = ("/run/verbose 0\n"
                    "/tracking/verbose 0\n"
                    "/hits/verbose 0\n"
                    "/mygen/vecfile " + path.join(self.dir, "gen/filtered/",
                                                  f) + "\n"
                    "\n/mygen/useXAxisForBeam false\n"
                    "/mygen/enableRandomVtx false\n"
                    "/mygen/generator muline\n"
                    "/WCSimIO/SaveRootFile true\n"
                    "/WCSimIO/RootFile " + path.join(self.dir, "sim/", geom,
                                                     base + "_sim.root") + "\n"
                    "\n/WCSimIO/SavePhotonNtuple false\n"
                    "/WCSimIO/SaveEmissionProfile false\n"
                    "/WCSimTrack/PercentCherenkovPhotonsToDraw 0.0\n"
                    "/WCSim/random/seed " + str(rand) + "\n"
                    "/run/beamOn " + str(self.config["gen_select_size"]))
            mac.write(text)
            mac.close()

            jobs.write("\nqsub -q medium " + script_name)

            count += 1

    def map(self, geom, pdg):
        """Creates the scripts required for hit map generation."""
        print("Creating Mapping Scripts...")
        jobs = open(path.join(self.dir, "scripts/" + geom + "_map.sh"),
                    "w")
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.dir, "map/", geom)):
            os.mkdir(path.join(self.dir, "map/", geom))

        for f in os.listdir(path.join(self.dir, "sim", geom)):
            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.dir, "scripts/map/", geom + "_" +
                                    base + "_map.sh")
            script = self.blank_script(script_name)
            script.write("\nsource " + self.config["base_setup"])
            script.write("\nsource " + self.config["sim_setup"])
            script.write("\nsource " + self.config["analysis_setup"])
            script.write('\nroot -l -q -b "' + self.config["map"] + '(' +
                         r'\"' + path.join(self.dir, "sim", geom, f) +
                         r'\",' + r'\"' + path.join(self.dir, "map", geom,
                                                    base + "_map.root") +
                         r'\",' + str(self.config["gen_select_size"]) +
                         r',' + str(pdg) + ')"')
            script.close()

            jobs.write("\nqsub -q medium " + script_name)

    '''
    def reco(self, split, geom):
        """Creates the scripts required for event reconstruction."""
        print("Creating Reconstruction Scripts...")
        jobs = open(path.join(self.dir, "scripts/reco.sh"), "w")
        jobs.write("#!/bin/sh")

        totalFiles = 0
        for f in os.listdir(path.join(self.dir, "sim/reco.sh")):
            name, ext = path.splitext(f)
            baseName = path.basename(name)
            for evtCounter in range(0, 1000, int(split)):
                scriptName = path.join(outputDir, "submit/reco_scripts_" +
                                       recoName, baseName + "_reco_sub_" +
                                       recoName + "_" + str(evtCounter) +
                                       ".sh")
                f = open(scriptName, "w")

                text = ("#!/bin/sh\n"
                        "source /unix/chips/jtingey/reco/setup.sh\n"
                        "cd " + path.join(outputDir, recoName) + "\n"
                        'root -l -q -b "' + recoType + '(' + r'\"' +
                        path.join(self.dir, f) + r'\",' +
                        str(evtCounter) + ')"'
                        )

                f.write(text)
                f.close()
                jobs.write("\nqsub -q medium " + scriptName)

            totalFiles += 1
            if int(totalFiles) == int(numFiles):
                break
    '''


def parse_args():
    """Parse the command line arguments."""
    parser = argparse.ArgumentParser(description='Submits Sim/Reco Jobs')
    parser.add_argument('input', help='path to directory')
    parser.add_argument('-j', '--json', help='path to json config file',
                        default="config/ucl_config.json")
    parser.add_argument('-n', '--num', help='number of files to use',
                        default=1000)
    parser.add_argument('--make', action='store_true')

    # Generate arguments
    parser.add_argument('--gen', action='store_true')
    parser.add_argument('-e', '--ev', help='number of events',
                        default=100000)
    parser.add_argument('-p', '--par', help='nuel, numu, cosmic')
    parser.add_argument('-t', '--type', help='event type (GEVGL)', default='')

    # Filter arguments
    parser.add_argument('--filter', action='store_true')

    # Simulation arguments
    parser.add_argument('--sim', action='store_true')
    parser.add_argument('-g', '--geom', help='geometry .mac file')

    # Mapping arguments
    parser.add_argument('--map', action='store_true')
    parser.add_argument('--pdg', help='pdg code to use in truth info',
                        default=11)

    # Reconstruction arguments
    # parser.add_argument('--reco', action='store_true')
    # parser.add_argument('-s', '--split', default=20)

    return parser.parse_args()


def main():
    filter
    """Main function called by script."""
    args = parse_args()
    if not args:
        print('Invalid Arguments')
        sys.exit(1)

    # Create the CHIPSRunner and run whatever we want...
    runner = CHIPSRunner(args.input, args.json)
    if args.make:
        runner.make_dir()
    elif args.gen:
        if args.par == "cosmic":
            runner.gen_cosmic(args.ev)
        else:
            runner.gen_beam(args.ev, args.par, args.type)
    elif args.filter:
        runner.filter()
    elif args.sim:
        if args.par == "cosmic":
            runner.sim_cosmic(args.geom, args.num)
        else:
            runner.sim_beam(args.geom, args.num)
    elif args.map:
        runner.map(args.geom, int(args.pdg))
    # elif args.reco:
    #     runner.reco(args.split, args.geom)


if __name__ == '__main__':
    main()
