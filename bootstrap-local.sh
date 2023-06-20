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