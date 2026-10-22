# CRAN comments

## Package size

`R CMD check` reports an installed size of 6.3 MB (`data` subdirectory
6.2 MB), driven by the example `BirdFlow` model objects the package
exists to provide (`amewoo.rda` 3.9 MB, `rewbla.rda` 1.1 MB, plus
`states.rda`, `rewbla_observations.rda`, and `rewbla_intervals.rda`
together under 0.2 MB on disk). This is over the informal 5 MB
guideline for source packages.

These models and ancillary data are the package's sole purpose: fitted
example models for testing and demonstrating the companion `BirdFlowR`
package. They have already been fit at coarse spatial resolution
(`amewoo` at 150 km, `rewbla` at 350 km) and, for `rewbla`, with heavy
sparsification specifically to minimize size while still exercising the
code paths they are used for (geometry mismatches and season wraparound
in particular). `amewoo`'s resolution was kept finer than `rewbla`'s
because it is also used in `BirdFlowR` vignette figures, where coarser
resolution would visibly degrade example output.

## Test environments

* local macOS install, R 4.x
* GitHub Actions: macOS, Windows, Ubuntu (release and devel)

## R CMD check results

0 errors | 0 warnings | 0 notes
