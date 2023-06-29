
# Check for single command line arg
if [[ -z "$1" || ! -z "$2" ]]; then
    echo "Comma-separated ansible playbook tags required as sole script arg"
    exit 1
fi

if [[ $(cat /etc/os-release) =~ ubuntu ]]; then
    sudo apt install python3-venv
else
    sudo dnf install python3-venv
fi

python3 -m venv venv
source venv/bin/activate
pip install -U pip
pip install ansible
echo "localhost ansible_connection=local" > inventory
ansible-playbook -i inventory configure-host.yml -t $1