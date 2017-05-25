#!/bin/bash

FILENAME=$(date +%s)

mkdir -p tmp/graphs

gnuplot << EOF
  set title 'time analysis'
  set xlabel "Time (seconds)"
  set ylabel "Input size (n)"
  set grid
  set term png
  set output "tmp/graphs/$FILENAME.png"
  set datafile separator ","
  plot 'tmp/input.csv'
EOF

echo "tmp/graphs/$FILENAME.png"
