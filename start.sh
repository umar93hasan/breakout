#!/bin/bash

export PORT=5090

cd ~/www/breakout
./bin/breakout stop || true
./bin/breakout start

