#!/bin/bash
snap refresh; apt update; apt dist-upgrade -y; apt clean; apt autoremove -y; shutdown -h now

