#!/bin/bash

FILENAME=$(date +%s)

mkdir -p tmp/graphs

gnuplot << EOF
  set title 'time analysis'
  set xlabel "Input size (n)"
  set ylabel "Time (seconds)"
  set grid
  set term png
  set output "tmp/graphs/$FILENAME.png"
  set datafile separator ","
  set yrange [0:100]
  plot 'tmp/input.csv' with line
EOF

echo "tmp/graphs/$FILENAME.png"
