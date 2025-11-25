import sys
print("Step 2: Calculating probabilities...")

query_counts = {}
total_fragments = 0

with open("query.counts", "r") as f:
    for line in f:
        length, count = line.split()
        query_counts[int(length)] = int(count)
        total_fragments += int(count)

reference_probs = {}
with open("reference.hist", "r") as f:
    for line in f:
        if not line.strip() or line.startswith("#"): continue
        try:
            parts = line.split()
            reference_probs[int(parts[0])] = float(parts[1])
        except ValueError: continue

with open("sampling_rules.txt", "w") as out:
    for length, count in query_counts.items():
        your_prob = count / total_fragments
        target_prob = reference_probs.get(length, 0.0)
        keep_prob = 0.0 if your_prob == 0 else target_prob / your_prob
        if keep_prob > 1.0: keep_prob = 1.0
        out.write(f"{length}\t{keep_prob}\n")

print("Done. Saved to sampling_rules.txt")
