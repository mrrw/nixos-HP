#!/bin/bash

FrostDateFirst=$(date -d 10/04/2025 +%D)
FrostDateLast=$(date -d 05/30/2026 +%D)
F1=$FrostDateFirst
F2=$FrostDateLast

echo "Erie PA is in Zone 6."
echo "First frost happens between Late October to Early November."
echo "Last frost happens between Mid to Late April."
echo "FIRST FROST DATE:  $F1"
echo "LAST FROST DATE:  $F2"
