#!/bin/bash
sleep 1m

# Log stdout to file
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/home/ec2-user/terraform.log 2>&1

#!bin/bash
sudo yum update -y # update all packages on system, answer yes to all
sudo mkdir /anaconda3 
sudo chown -R ec2-user:ec2-user /anaconda3 # change ownership for user and grup to be ec2-user

# Install anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh -O /home/ec2-user/anaconda.sh &&
    bash /home/ec2-user/anaconda.sh -u -b -p /anaconda3 &&
    echo 'export PATH="/anaconda3/bin:$PATH"' >> /home/ec2-user/.bashrc &&
    rm -rf /home/ec2-user/anaconda.sh &&
# Configure Jupyter for AWS HTTP
runuser -l ec2-user -c 'jupyter notebook --generate-config' &&
    sed -i -e "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '"$(curl http://169.254.169.254/latest/meta-data/public-hostname)"'/g" /home/ec2-user/.jupyter/jupyter_notebook_config.py &&
    sed -i -e "s/#c.NotebookApp.allow_origin = ''/c.NotebookApp.allow_origin = '*'/g" /home/ec2-user/.jupyter/jupyter_notebook_config.py &&
    sed -i -e "s/#c.NotebookApp.open_browser = True/c.NotebookApp.open_browser = False/g" /home/ec2-user/.jupyter/jupyter_notebook_config.py
