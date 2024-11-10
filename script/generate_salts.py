# generate_salts.py
import json
import subprocess
import re

def run_create2(suffix):
    cmd = f'''forge script ./script/CalculateInitCodeHash.s.sol | grep "initCodeHash: " | awk '{{print $3}}' | xargs -I {{}} cast create2 --caller 0x28996f7DECe7E058EBfC56dFa9371825fBfa515A --init-code-hash {{}} --ends-with {suffix}'''
    
    output = subprocess.check_output(cmd, shell=True).decode()
    
    # Extract address and salt using regex
    address_match = re.search(r'Address: (0x[a-fA-F0-9]+)', output)
    salt_match = re.search(r'Salt: (0x[a-fA-F0-9]+)', output)
    
    return {
        'address': address_match.group(1),
        'salt': salt_match.group(1)
    }

# List of desired suffixes
suffixes = ['beef', 'babe', 'deaf', 'dead', 'face', 'feed', 'fed', 'bad']

# Generate results
results = {suffix: run_create2(suffix) for suffix in suffixes}

# Save to JSON file
with open('./script/salts.json', 'w') as f:
    json.dump(results, f, indent=2)