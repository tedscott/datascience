## cacheMatrix.R
#

## The following two functions are designed to speed up the potentially
# costly operation of calculating the inverse of a matrix by caching the result 
# from calculating the inverse the first time, after a call to cacheSolve,
# and then retrieving the inverse from the cache in any subsequent calls
# to cacheSolve

# a new matrix is created like so
# a <- makecacheMatrix(matrix(1:4, 2, 2))
#
# and the inverse is calculated by
# cacheSolve(a)
#
#
#

## makeCacheMatrix
#
# This function creates a special "matrix" object
# that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinv <- function(solve) inv <<- solve
  getinv <- function() inv
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}

## cacheSolve
# This function computes the inverse of the special
# "matrix" returned by `makeCacheMatrix` above. If the inverse has
# already been calculated, then `cacheSolve` retrieves the inverse from the cache.

cacheSolve <- function(x, ...) {
  inv <- x$getinv()
  if(!is.null(inv)) {
    message("getting cached inverse")
    return(inv)
  }
  # I assume the matrix is invertible, i.e. a square matrix
  data <- x$get()
  inv <- solve(data)
  x$setinv(inv)
  inv
}

