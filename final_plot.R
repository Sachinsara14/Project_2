# Output the image to a PNG file
png("result_graph.png", width=1000, height=600)

# 1. Read the tiny files
ref  <- read.table("plot_ref.tmp")
orig <- read.table("plot_query.tmp")
out  <- read.table("plot_output.tmp")

# 2. Normalize to Frequencies (0 to 1 scale)
#    Formula: Value / Sum(Values)
ref[,2]  <- ref[,2]  / sum(ref[,2])
orig[,2] <- orig[,2] / sum(orig[,2])
out[,2]  <- out[,2]  / sum(out[,2])

# 3. Sort the data by Length (V1) so lines draw correctly
ref  <- ref[order(ref[,1]),]
orig <- orig[order(orig[,1]),]
out  <- out[order(out[,1]),]

# 4. Create the Plot
#    Start with the Reference (Green Line)
plot(ref, type="l", col="darkgreen", lwd=3, 
     xlim=c(0, 700), ylim=c(0, 0.025),
     main="Project 2: Final Verification", 
     xlab="Fragment Length (bp)", ylab="Normalized Frequency")

#    Add Grid for easier reading
grid(col="gray", lty="dotted")

#    Add Original Query (Purple Line)
lines(orig, col="purple", lwd=2)

#    Add Rescaled Output (Blue Stars)
points(out, col="dodgerblue", pch=8, cex=0.8)

# 5. Add a Legend
legend("topright", 
       legend=c("Reference", "Original Query", "Rescaled Output"),
       col=c("darkgreen", "purple", "dodgerblue"), 
       lty=c(1, 1, NA),   # Lines for first two
       pch=c(NA, NA, 8),  # Star symbol for the third
       lwd=c(3, 2, 1))

dev.off() # Save and close file
cat("Graph saved as 'result_graph.png'\n")