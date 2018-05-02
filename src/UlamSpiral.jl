"A module to plot Ulam spirals"
module UlamSpiral

using PyPlot
using Primes
import Base: position
 
export position, text_spiral, point_spiral, plot_quadratic
 
""" 
    position(n[, start_n=1])

Compute (x,y) location in the lattice spiral of the integer n, assuming the spiral
starts at the integer start_n (which takes default value 1).

# Arguments
- `n::Integer`: the integer to find the position of, N.B. n >= start_n
- `start_n::Integer=1`: the starting integer of the spiral

# Examples
```jldoctest
julia> UlamSpiral.position(23, 1)
(0, -2)
```
"""
function position( n::Integer, start_n::Integer=1 )
    if n<start_n
        throw(DomainError()) 
    elseif n==start_n 
        return (0, 0) 
    end
        
    j = n-start_n 
    k = Int(ceil( floor(sqrt( j )) / 2 )) # how far out in the spiral
    m = Int( j - (2*(k-1)+1)^2 ) # how far along the arm
    length = Int( 2*k )
    quarter = Int( floor(m / length) )
    m2 = m - length*quarter
    if quarter==0
        d_x = k
        d_y =  Int( m2 - length/2 + 1 )
    elseif quarter==1
        d_x = -Int( m2 - length/2 + 1 )
        d_y = k
    elseif quarter==2
        d_x = -k
        d_y = -Int( m2 - length/2 + 1 )
    elseif quarter==3
        d_x =  Int( m2 - length/2 + 1 )
        d_y = -k    
    end
    # println(i, ", ", k, ", ", m, ", ", length, ", ", quarter, ", ", d_x, ", ", d_y)
    return (d_x, d_y)
end


"""
    text_spiral( [start_n] )

Write numbers in an Ulam spiral starting from start_n.

# Arguments
- `start_n::Integer=1`: the starting integer of the spiral

# Keyword Arguments
- `fontsize=20`:        the size of the font to write everything
- `color_prime="red"`:  the color to use for prime numbers
- `color_comp="blue"`:  the color to use for composite numbers (note 1 is compositite by convention)
- `width=10`:           the width of the square used (which determines how many numbers to plot)
- `fig_n=1`:            the figure on which to plot everything
- `clear="on"`:         whether to clear the figure before starting

# Examples
```jldoctest
julia> text_spiral()
PyPlot.Figure(PyObject <matplotlib.figure.Figure object at 0x1221f3dd0>)

julia> text_spiral( 100; fontsize=16)
PyPlot.Figure(PyObject <matplotlib.figure.Figure object at 0x1221f3dd0>)

julia> text_spiral(fig_n=2, color_comp="white", color_prime="black", width=20, fontsize=10)
PyPlot.Figure(PyObject <matplotlib.figure.Figure object at 0x122136e10>)

```
"""
function text_spiral(start_n::Integer=1;
                     fontsize=20, color_prime="red", color_comp="blue", width=10, fig_n=1, clear="on")
    c_x = Int(floor(width/2)) # centre of spiral
    c_y = Int(floor(width/2))
    stop_n = start_n + width^2 - 1;

    f = figure(fig_n)
    if clear=="on"
        clf()
    end
    hold(true)
    for n=start_n : stop_n
        (d_x, d_y) = UlamSpiral.position(n, start_n)
        if isprime(n)
            PyPlot.text(c_x + d_x, c_y + d_y, @sprintf("%d", n), fontsize=fontsize, color=color_prime)
        else
            PyPlot.text(c_x + d_x, c_y + d_y, @sprintf("%d", n), fontsize=fontsize, color=color_comp)
         end
    end
    PyPlot.xlim(0, width+1)
    PyPlot.ylim(0, width+1)
    return f
end


"""
    point_spiral( [start_n] )

Plot points at numbers in an Ulam spiral starting from start_n.

# Arguments
- `start_n::Integer=1`: the starting integer of the spiral

# Keyword Arguments
- `marker="o":     the marker to use
- `markersize=7`:  the size of the markers being plotted
- `color="red"`:   the color to use (this routine only plots prime numbers)
- `width=10`:      the width of the square used (which determines how many numbers to plot)
- `fig_n=1`:       the figure on which to plot everything
- `clear="on"`:    whether to clear the previous figure 

# Examples
```jldoctest
julia> point_spiral()
PyPlot.Figure(PyObject <matplotlib.figure.Figure object at 0x1221f3dd0>)

julia> point_spiral( 1000; markersize=10)
PyPlot.Figure(PyObject <matplotlib.figure.Figure object at 0x1221f3dd0>)

julia> point_spiral(fig_n=2, markersize=1, color="black", width=200)
PyPlot.Figure(PyObject <matplotlib.figure.Figure object at 0x122136e10>)

julia> text_spiral(fig_n=2, color_comp="white", color_prime="black", width=20, fontsize=10)
julia> point_spiral(fig_n=2, markersize=3, marker="s", color="green", width=20, clear="off")
PyPlot.Figure(PyObject <matplotlib.figure.Figure object at 0x122136e10>)

```
"""
function point_spiral(start_n::Integer=1;
                      marker="o", markersize=7, color="red", width=100, fig_n=1, clear="on")
    c_x = Int(floor(width/2)) # centre of spiral
    c_y = Int(floor(width/2))
    stop_n = start_n + width^2 - 1;

    f = figure(fig_n)
    if clear=="on"
        clf()
    end
    hold(true)
    for n=primes(start_n, stop_n)
        (d_x, d_y) = UlamSpiral.position(n, start_n)
        PyPlot.plot(c_x + d_x, c_y + d_y; marker=marker, markersize=markersize, color=color)
    end
    PyPlot.xlim(0, width+1)
    PyPlot.ylim(0, width+1)
    return f
end



"""
    plot_quadratic(a, b, c)

Highlight points on the quadratic ax^2 + bx + c. Presumes you have already 
run point_spiral with the same width parameter.

# Arguments
- `a::Integer = 4`:  quadratic coefficient
- `b::Integer = -2`: linear coefficient
- `c::Integer = 41`: constant coefficient

# Keyword Arguments
- `start_n=1`           the starting integer of the spiral
- `marker="o":          the marker to use
- `markersize=7`:       the size of the markers being plotted
- `color_prime="blue"`: the color to use for prime numbers
- `color_comp="white"`: the color to use for compositive numbers
- `width=10`:              the width of the square used (should be the same as previous plot)
- `fig_n=1`:              the figure on which to plot everything (should be the same as previous plot)

# Examples
```jldoctest
julia> point_spiral(fig_n=2, markersize=1, color="black", width=200);
julia> plot_quadratic(; fig_n=2, width=200);
julia> plot_quadratic(4, 2, 41; fig_n=2, width=200, color_prime="green");
```
"""
function plot_quadratic(a::Integer=4, b::Integer=-2, c::Integer=41;
                        start_n=1, width=10, fig_n=1,
                        marker="o", markersize=7, color_prime="red", color_comp="white")
    c_x = Int(floor(width/2)) # centre of spiral
    c_y = Int(floor(width/2))
    stop_n = start_n + width^2 - 1;
    rad = 0
    x = start_n - 1
    while rad <= width/2
        x = nextprime(x+1)
        n = a*x^2 + b*x + c
        if n>0
            (d_x, d_y) = UlamSpiral.position(n, start_n);
            rad = max( abs(d_x), abs(d_y) )
            plot(c_x + d_x, c_y + d_y, marker=marker, color=color_prime, markersize=markersize)
        end
    end
    # at present not plotting composite numbers at all
end

end # module
