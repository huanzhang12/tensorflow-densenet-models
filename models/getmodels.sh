#!/bin/bash

python2 download_google.py 0B_fUSpodN0t0eW1sVk1aeWREaDA tf-densenet121.tar.gz                                                  
python2 download_google.py 0B_fUSpodN0t0TDB5Ti1PeTZMM2c tf-densenet169.tar.gz                                                  
python2 download_google.py 0B_fUSpodN0t0NmZvTnZZa2plaHc tf-densenet161.tar.gz     

for layer in 121 169 161; do
    mkdir ${layer}
    tar xvf tf-densenet${layer}.tar.gz -C ${layer}/
done
