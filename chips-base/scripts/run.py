import os.path as path
import sys
import argparse
import os
from selector import Selector
import json

class CHIPSRunner:
    def __init__(self, prod_dir, config_file):
        self.prod_dir = prod_dir
        self.config = self.load_config(config_file)

    # Load the configuration from the json file
    def load_config(self, config_file):
        with open(config_file, 'r') as config:
            config_dict = json.load(config)
        return config_dict

    # Make all the directories in the production directory path
    def make_dir(self):
        os.mkdir(path.join(self.prod_dir, "gen/"))
        os.mkdir(path.join(self.prod_dir, "gen/all/"))
        os.mkdir(path.join(self.prod_dir, "gen/filtered/"))
        os.mkdir(path.join(self.prod_dir, "sim/"))
        os.mkdir(path.join(self.prod_dir, "map/"))
        os.mkdir(path.join(self.prod_dir, "tf/"))
        os.mkdir(path.join(self.prod_dir, "reco/"))
        os.mkdir(path.join(self.prod_dir, "plots/"))
        os.mkdir(path.join(self.prod_dir, "scripts/"))
        os.mkdir(path.join(self.prod_dir, "scripts/gen/"))
        os.mkdir(path.join(self.prod_dir, "scripts/filter/"))
        os.mkdir(path.join(self.prod_dir, "scripts/sim/"))
        os.mkdir(path.join(self.prod_dir, "scripts/map/"))
        os.mkdir(path.join(self.prod_dir, "scripts/tf/"))
        os.mkdir(path.join(self.prod_dir, "scripts/reco/"))

    def blank_script(self, name):
        script = open(name, "w")
        script.write("#!/bin/bash\n")
        script.write("source " + self.config["setup"] + "\n")
        return script

    def gen_beam(self, events, particle, type):
        print("Creating Generation Scripts...")
        jobs = open(path.join(self.prod_dir, "scripts/gen.sh"), "w") # Open the job submission script
        jobs.write("#!/bin/sh" + "\n")
        jobs.write("chmod +x " + path.join(self.prod_dir, "scripts/gen/") + "*gen*.sh" + "\n")
        num_jobs = int(events)/self.config["gen_job_size"]
        for i in range(num_jobs):
            script_name = path.join(self.prod_dir, "scripts/gen/", "gen_" + "{:03d}".format(i) + ".sh")
            output_name = "gen_" + "{:03d}".format(i) + ".vec"
            script = self.blank_script(script_name)
            if particle == "numu":
                spec = self.config["spec_file"] + ",spectrum-numu"
                pid = 14
                script.write("export GSPLOAD=" + self.config["numu_xsec"] + "\n")
            elif particle == "nuel":
                spec = self.config["spec_file"] + ",spectrum-nuel"
                pid = 12
                script.write("export GSPLOAD=" + self.config["nuel_xsec"] + "\n")
            if type == "":
                script.write("unset GEVGL" + "\n")
            else:
                script.write("export GEVGL=" + type + "\n")
            script.write("export GSEED=" + str(i) + "\n")
            script.write("cd " + path.join(self.prod_dir, "scripts/gen/") + "\n")
            script.write("mkdir gen" + str(i) + "\n")
            script.write("cd gen" + str(i)+ "\n")
            script.write("gevgen -n " + str(self.config["gen_job_size"]) + " -s -e 0.5,5 -p " + str(pid) + 
                        " -t 1000080160[0.95],1000010010[0.05] -r 0 -f " + spec + " > /dev/null" + "\n")
            script.write("gntpc -i gntp.0.ghep.root -f nuance_tracker -o " + output_name + " > /dev/null" + "\n")
            script.write("mv " + output_name + " " + path.join(self.prod_dir, "gen/all/", output_name) + "\n")
            script.write("cd ../" + "\n")
            script.write("rm -rf gen" + str(i) + "\n")
            script.close()

            jobs.write("qsub -q medium " + script_name + "\n")

    def gen_cosmic(self, events):
        print("Creating Generation Scripts...")
        jobs = open(path.join(self.prod_dir, "scripts/gen.sh"), "w") # Open the job submission script
        jobs.write("#!/bin/sh" + "\n")
        jobs.write("chmod +x " + path.join(self.prod_dir, "scripts/gen/") + "*gen*.sh" + "\n")
        num_jobs = int(events)/self.config["gen_job_size"]
        for i in range(num_jobs):
            script_name = path.join(self.prod_dir, "scripts/gen/", "gen_" + "{:03d}".format(i) + ".sh")
            output_name = "gen_" + "{:03d}".format(i) + ".vec"
            script = self.blank_script(script_name)
            script.write("cosmicGen " + self.config["cosmic_config"] + " " + str(events) + " " + 
                         self.config["cosmic_geom"] + " > " + path.join(self.prod_dir, "gen/all/", output_name))
            script.close()
            jobs.write("qsub -q medium " + script_name + "\n")

    def filter(self):
        print("Running Filter...")
        input_dir = path.join(self.prod_dir, "gen/all/")	
        output_dir = path.join(self.prod_dir, "gen/filtered/")
        plot_path = path.join(self.prod_dir, "plots/filtered_plots.root")

        req_particles = [] # Require certain particle
        req_types = [] # Require certain interaction types

        selector = Selector(input_dir, output_dir, plot_path, 
                            self.config["gen_select_size"], req_particles, req_types)
        selector.Run()

    def sim(self, geom):
        print("Creating Simulation Scripts...")
        jobs = open(path.join(self.prod_dir, "scripts/" + geom + "_sim.sh"), "w") # Open the job submission script
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.prod_dir, "sim/", geom)):
            os.mkdir(path.join(self.prod_dir, "sim/", geom))

        for f in os.listdir(path.join(self.prod_dir, "gen/filtered/")):
            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.prod_dir, "scripts/sim/", geom + "_" + base + "_sim.sh")
            mac_name = path.join(self.prod_dir, "scripts/sim/", geom + "_" + base + "_sim.mac")

            script = self.blank_script(script_name)
            script.write("cd $WCSIMHOME\n")
            script.write("WCSim -g " + self.config[geom] + " " + mac_name)
            script.close()	

            mac = open(mac_name, "w")
            text = ("/run/verbose 0\n"
                    "/tracking/verbose 0\n"
                    "/hits/verbose 0\n"
                    "/mygen/vecfile " + path.join(path.join(self.prod_dir, "gen/filtered/"), f) + "\n"
                    "/mygen/useXAxisForBeam true\n"
                    "/mygen/enableRandomVtx true\n"
                    "/mygen/fiducialDist 1.0\n"
                    "/mygen/generator muline\n"
                    "/WCSimIO/SaveRootFile true\n"
                    "/WCSimIO/RootFile " + path.join(self.prod_dir, "sim/", geom, base + "_sim.root") + "\n"
                    "/WCSimIO/SavePhotonNtuple false\n"
                    "/WCSimIO/SaveEmissionProfile false\n"
                    "/WCSimTrack/PercentCherenkovPhotonsToDraw 0.0\n"
                    "/WCSim/random/seed 103 \n"
                    "/run/beamOn 1000")	
            mac.write(text)
            mac.close()	

            jobs.write("\nqsub -q medium " + script_name)

    def map(self, geom, category, pdg):
        print("Creating Mapping Scripts...")
        jobs = open(path.join(self.prod_dir, "scripts/" + geom + "_map.sh"), "w") # Open the job submission script
        jobs.write("#!/bin/sh")

        if not os.path.isdir(path.join(self.prod_dir, "map/", geom)):
            os.mkdir(path.join(self.prod_dir, "map/", geom))

        for f in os.listdir(path.join(self.prod_dir, "sim", geom)):
            name, ext = path.splitext(f)
            base = path.basename(name)
            script_name = path.join(self.prod_dir, "scripts/map/", geom + "_" + base + "_map.sh")
            script = self.blank_script(script_name)
            script.write('root -l -q -b "' + self.config["map"] + '(' + r'\"' + path.join(self.prod_dir,"sim",geom,f) + 
                         r'\",' + r'\"' + path.join(self.prod_dir,"map",geom,base + "_map.root") +
                         r'\",' + str(self.config["gen_select_size"]) +
                         r',' + str(category) +
                         r',' + str(pdg) + ')"')
            script.close()	

            jobs.write("\nqsub -q medium " + script_name)

    def reco(self, split, geom):
        print("Creating Reconstruction Scripts...")
        jobs = open(path.join(self.prod_dir, "scripts/reco.sh"), "w") # Open the job submission script
        jobs.write("#!/bin/sh")
        
        totalFiles = 0
        for f in os.listdir(path.join(self.prod_dir, "sim/reco.sh")):
            name, ext = path.splitext(f)
            baseName = path.basename(name)
            for evtCounter in range(0, 1000, int(split)):
                scriptName = path.join(outputDir, "submit/reco_scripts_" + recoName, baseName + "_reco_sub_" + recoName + "_" + str(evtCounter) + ".sh")
                f = open(scriptName, "w")

                text = ("#!/bin/sh\n"
                        "source /unix/chips/jtingey/reco/setup.sh\n"
                        "cd " + path.join(outputDir, recoName) + "\n"  
                        'root -l -q -b "' + recoType + '(' + r'\"' + path.join(self.prod_dir,f) + r'\",' + str(evtCounter) + ')"'
                        )
                        
                f.write(text)
                f.close()
                jobs.write("\nqsub -q medium " + scriptName)
                
            totalFiles += 1
            if int(totalFiles) == int(numFiles):
                break	

def parse_args():
    parser = argparse.ArgumentParser(description='Submits Sim/Reco Jobs')
    parser.add_argument('-i', '--input', help='path to production dir')
    parser.add_argument('-j', '--json', help='path to json config file', 
                        default="../config/default_config.json")
    parser.add_argument('-n', '--num', help='number of files to use', default=50)
    parser.add_argument('--make', action = 'store_true')

    # Generate arguments
    parser.add_argument('--gen', action = 'store_true')
    parser.add_argument('-e', '--events', help='Number of events to generate', default=100000)
    parser.add_argument('-p', '--particle', help='Neutrino type nuel, numu, cosmic')
    parser.add_argument('-t', '--type', help='Event type (GEVGL)', default='')

    # Filter arguments
    parser.add_argument('--filter', action = 'store_true')

    # Simulation arguments
    parser.add_argument('--sim', action = 'store_true')	
    parser.add_argument('-g', '--geom', help='WCSim geometry .mac file')

    # Mapping arguments
    parser.add_argument('--map', action = 'store_true')
    parser.add_argument('--cat', help='Category to assign for PID', default=0)
    parser.add_argument('--pdg', help='PDG code to use in truth info', default=11)

    # Reconstruction arguments
    parser.add_argument('--reco', action = 'store_true')
    parser.add_argument('-s', '--split', default = 20)

    return parser.parse_args()	

def main():
    args = parse_args()
    if not args:
        print('Invalid Arguments')
        sys.exit(1)		

    # Create the CHIPSRunner and run whatever we want...
    runner = CHIPSRunner(args.input, args.json)
    if args.make:
        runner.make_dir()
    elif args.gen:
        if args.particle == "cosmic":
            runner.gen_cosmic(args.events)
        else:
            runner.gen_beam(args.events, args.particle, args.type)
    elif args.filter:
        runner.filter()
    elif args.sim:
        runner.sim(args.geom)
    elif args.map:
        runner.map(args.geom, int(args.cat), int(args.pdg))
    elif args.reco:
        runner.reco(args.split, args.geom)
    
if __name__=='__main__':
    main()



