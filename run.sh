#!/bin/bash
#apt install -y ansible sshpass
ansible-playbook -i ./hosts mochimo.yml --ask-pass
