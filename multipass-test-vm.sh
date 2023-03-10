UBUNTU_VERSION=22.10
export ANSIBLE_HOST_KEY_CHECKING=false
multipass delete test-vm
multipass purge
multipass launch --name test-vm --cloud-init multipass-cloud-init.yml $UBUNTU_VERSION
echo $(multipass list | grep test-vm | awk '{print $3}') ansible_user=ubuntu > test-inventory
ansible-playbook -i test-inventory bootstrap.yml