# Pre-release, not properly tested yet! #


## Introduction ##
Ansible playbook for setting up multirig mochimo mining.

## Requirements ##
* Clean installation of Ubuntu 18.04
* Enable SSH on all rigs: `apt install ssh`
* Install ansible and sshpass on one of the nodes: `apt install ansible sshpass`

## How to use ##
1. Modify the file `hosts` to match your rigs (LAN IP, Number of GPUs, Rig Id (number in the range 0-255), if it is a node with public internet IP).
2. Replace `data/maddr.dat` with your own mining address file.
3. Run `./run.sh` on the rig where you have installed ansible and downloaded this playbook.
4. Wait for it to complete (may take a while since it has to wait for masters to sync before starting slaves).

### Monitoring your rigs ###
On each rig open two terminals.
In the first terminal run `sudo tmux a -t mochi-master` to monitor the master instance.
In the second terminal run `sudo tmux a -t mochi` to monitor the slave nodes.
