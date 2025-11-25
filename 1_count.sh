#!/bin/bash
echo "Step 1: Counting fragments..."
zcat query.bed.gz | awk '{
    len = $3 - $2;
    count[len]++;
} 
END {
    for (l in count) print l "\t" count[l];
}' > query.counts
echo "Done. Saved to query.counts"
