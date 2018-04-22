# UlamSpiral

The Ulam Spiral, named after Stanislaw Ulam, is a simple mapping of
the non-negative integers to a square lattice, spiralling out from the
center, and highlighting the prime numbers.

The interesting feature is the apparent patterns that appear in the
highlighted primes.

There's a lot more written about this online

+ https://en.wikipedia.org/wiki/Ulam_spiral
+ https://rosettacode.org/wiki/Ulam_spiral_(for_primes)
+ https://www.r-bloggers.com/the-ulam-spiral-euler-problem-28/

so I won't try to duplicate it all here.

The code here will produce such a spiral. There are two main routines:

+ `text_spiral`:  plot the numbers themselves in the spiral (for small grids)
+ `point_spiral`: plot the points corresponding to the primes (for larger grids)

and a couple of utilities:

+ `position`:       used internally to fget (x,y) position for a point on the spiral
+ `plot_quadratic`: plot points along a quadratic function, as these appear asymptotically
                      linear in the spiral 

## Examples:
 
    julia> text_spiral()

![Example 1](/plots/ulam_spiral_0.png)

    julia> text_spiral( 100; fontsize=16)

![Example 2](/plots/ulam_spiral_1.png)

    julia> text_spiral(fig_n=2, color_comp="white", color_prime="black", width=20, fontsize=10)

![Example 3](/plots/ulam_spiral_2.png)

    julia> point_spiral()

![Example 4](/plots/ulam_spiral_3.png)

    julia> point_spiral( 1000; fig_n=4, markersize=10)

![Example 5](/plots/ulam_spiral_4.png)

    julia> point_spiral(fig_n=5, markersize=1, color="black", width=200)
    julia> plot_quadratic(; fig_n=5, width=200);
    julia> plot_quadratic(4, 2, 41; fig_n=5, width=200, color_prime="green");

![Example 6](/plots/ulam_spiral_5.png)

    julia> text_spiral(fig_n=6, color_comp="white", color_prime="black", width=20, fontsize=10)
    julia> point_spiral(fig_n=6, markersize=3, marker="s", color="green", width=20, clear="off")

![Example 7](/plots/ulam_spiral_6.png)


