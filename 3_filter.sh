#!/bin/bash
echo "Step 3: Filtering the BED file..."
awk '
NR==FNR { rules[$1] = $2; next; }
{
    len = $3 - $2;
    prob = (len in rules) ? rules[len] : 0;
    if (rand() < prob) print $0;
}
' sampling_rules.txt <(zcat query.bed.gz) > query.rescaled.bed
echo "Done! Output saved to query.rescaled.bed"
