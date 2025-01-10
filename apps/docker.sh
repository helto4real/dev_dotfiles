#!/bin/bash

# Make user a member of the docker group
sudo groupadd docker
sudo usermod -aG docker $USER

