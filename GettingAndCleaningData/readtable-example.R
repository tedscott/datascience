# use top 50 rows to determine classes of columns, then call read.table using those classes
# to improve the speed of file reading
initial <- read.table("input.txt",nrows=50)
classes <- sapply(initial,class)
fullDF <- read.table("input.txt",colClasses = classes)