# Prints summary of a qic object

Prints summary of a qic object

## Usage

``` r
# S3 method for class 'qic'
summary(object, ...)
```

## Arguments

- object:

  A qic object.

- ...:

  For compatibility with generic summary function.

## Value

A data frame of summary values of each facet and part of a qic plot.

- facet1 Vertical facets.

- facet2 Horizontal facets

- part Number of chart part when argument break.points is given.

- aLCL Average of lower control limit.

- CL Centre line.

- aUCL Average of upper control limit.

- longest.run Length of the longest run of data points on the same side
  of the centre line.

- longest.run.max Upper limit of expected length of longest run.

- n.crossings Number of times the data line crosses the centre line.

- n.crossings.min Lower limit of expected number of crossings.

- runs.signal 1 if either longest run or number of crossings are outside
  expected limits.

- sigma.signal Number of data points outside control limits.

## Examples

``` r
p <- qic(rnorm(24), chart = 'i')
p

summary(p)
#>   facet1 facet2 part n.obs n.useful longest.run longest.run.max n.crossings
#> 1      1      1    1    24       24           4               8          10
#>   n.crossings.min runs.signal      aLCL   aLCL.95         CL  aUCL.95     aUCL
#> 1               8           0 -3.860042 -2.629206 -0.1675323 2.294141 3.524978
#>   sigma.signal
#> 1            0
```
