# Using base R; no libraries required

# Read text file containing typical text, with newlines, punctuation etc
textdata <- readLines('somefile.txt')

# Exclude blank rows, or rows with just spaces
textdata2 <- textdata[textdata != "" & textdata != " "]

# Combine all rows into a single string, separated by spaces
textdata3 <- paste(textdata2, collapse = " ")

# Letters converted to lowercase
textdata4 <- tolower(textdata3)

# Replace punctuation with spaces
textdata5 <- gsub("[[:punct:]]+", " ", textdata4)

# Separate tokens so each is on a row; give the column a name; make output a dataframe
textdata6 <- data.frame(strsplit(textdata5, split = " "))
colnames(textdata6) <- "token"

# Only include if row is non-blank, and token starts with a letter
# Note that output changes from dataframe to character vector again; ok to use for table
textdata7 <- textdata6[textdata6$token != "" & grepl("^[a-z]", textdata6$token) == TRUE, ]

# Make a table of words, with frequencies
t.orig <- table(textdata7)
# Make table into a dataframe
t.df <- data.frame(t.orig)
names(t.df) <- c('token', 'frequency')

# Re-order dataframe rows by word frequency
t2 <- t.df[order(t.df$frequency, decreasing = TRUE), ]
# Preview
head(t2, 30)

# Export table as csv
write.csv(t2, "~/Desktop/freqtable.csv")
