#!/bin/bash

usermod -aG docker $USER
systemctl enable --now docker

