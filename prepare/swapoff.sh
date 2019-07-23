#!/bin/bash

swapoff -a
sed  -i 's/.swap./#&/' /etc/fstab
