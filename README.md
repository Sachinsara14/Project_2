## Project 2: Rescale to Reference

**Goal:** Correct the fragment length bias in a query dataset by statistically resampling it to match a "perfect" reference distribution. This pipeline removes "noise" (short fragment peaks) while retaining signal (nucleosome peaks) using a probabilistic rejection sampling method.


### File Structure

| File | Language | Description |
| :--- | :--- | :--- |
| `1_count.sh` | Bash/Awk | Streams the compressed BED file and counts fragment lengths (handling column variations). |
| `2_calc_rules.py` | Python | Compares Query vs. Reference distributions and calculates "Keep Probabilities". |
| `3_filter.sh` | Bash/Awk | Reads the rules into memory and filters the original stream using `rand()` for decision making. |
| `final_plot.R` | R | Visualization script to verify that the output matches the reference. |

### Prerequisites
* Unix environment (Linux/Mac/Colab)
* Python 3
* R (Base graphics, no extra packages required)
* Standard tools: `gzip`, `awk`

###  Usage

#### 1. Prepare Data
Ensure the following files are in your directory:
* `query.bed.gz` 
* `reference.hist` 

#### 2. Run the Pipeline
You can run the entire process in a single line. This chains the counting, rule calculation, and filtering steps:
```bash
bash 1_count.sh && python 2_calc_rules.py && bash 3_filter.sh
```

**Output:**
* `query.counts`: Intermediate count file.
* `sampling_rules.txt`: The calculated probabilities for each length.
* **`query.rescaled.bed`**: The final cleaned dataset.

### 3. Verify Results (Visualization)

To visually verify the results, we prepare the data and generate a comparison plot between the Reference, Original Query, and Rescaled Output.

#### Step 1: Prepare Data Files for R
We need to give R simple lists of numbers (Length vs Count). Run these 3 commands in your terminal:

```bash
# 1. Prepare Reference (Remove header lines)
grep -v "#" reference.hist > plot_ref.tmp

# 2. Prepare Original Query (Copy existing counts from Step 1)
cp query.counts plot_query.tmp

# 3. Prepare Rescaled Output (Count fragments in the new file)
awk '{len=$3-$2; count[len]++} END{for(l in count) print l, count[l]}' query.rescaled.bed > plot_output.tmp

```
**Output:**
* `plot_ref.tmp`
* `plot_query.tmp`
* `plot_output.tmp`

### For Graph

Run this `final_plot.R` R file for Visualization script to verify that the output matches the reference

```bash
Rscript final_plot.R
```
**Output:**
* `result_graph.png`

