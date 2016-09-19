#!/usr/bin/env bash

vagrant status | grep "running" -q
if [ $? -ne 0 ]; then
    vagrant up
fi

pwd | grep ansible-role-mysql/tests$ -q
if [ $? -ne 0 ]; then
    echo "tests must be run in the ansible-role-steamengine/tests folder"
    exit 1
fi

ansible-playbook -i inventory test.yml -u vagrant -e "ansible_ssh_pass=vagrant" \
--ssh-common-args="-o PubkeyAuthentication=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" $@