import os
import subprocess
import sys
import argparse


def run_shell_command(cmd: str):
    cmd = cmd.split()

    process = subprocess.Popen(['make'] + cmd,
                               cwd='/usr/app/dbt/',
                               stdout=subprocess.PIPE,
                               universal_newlines=True)

    while True:
        output = process.stdout.readline()
        print(output.strip())
        # Do something else
        return_code = process.poll()
        if return_code is not None:
            print('RETURN CODE', return_code)
            # Process has finished, read rest of the output
            for output in process.stdout.readlines():
                print(output.strip())
            if return_code != 0:
                raise Exception(f'RETURN CODE {return_code}')
            else:
                break


databricksURL = dbutils.notebook.entry_point.getDbutils().notebook().getContext().apiUrl().getOrElse(None)
myToken = dbutils.notebook.entry_point.getDbutils().notebook().getContext().apiToken().getOrElse(None)
os.environ['DBT_ACCESS_TOKEN'] = myToken  # visible in this process + all children

# Initialize parser
parser = argparse.ArgumentParser()

# Adding optional argument
parser.add_argument("-s", "--script", help="the makefile cmd target to run", required=True, type=str)
parser.add_argument("-t", "--target", help="the environment in which to run the code", required=True, default="exploration", type=str)

# Read arguments from command line
args = parser.parse_args()

os.environ['DBT_TARGET'] = args.target
run_shell_command(args.script)
