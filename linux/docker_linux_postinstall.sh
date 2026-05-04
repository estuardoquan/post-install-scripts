#!/bin/bash

usermod -aG docker $USER
systemctl enable --now docker.service
systemctl enable --now containerd.service
