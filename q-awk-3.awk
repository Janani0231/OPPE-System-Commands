# Process only the first line (the header)
NR == 1 {
    # Split the header using comma as delimiter
    n = split($0, cols, ",")

    # Print each column number and column name
    for (i = 1; i <= n; i++) {
        print i, cols[i]
    }
}
