#!/bin/bash
docker run --rm -it --name madresteam --shm-size 256M -p 5880:5800 --privileged -v /steam:/steam akrista/madresteam