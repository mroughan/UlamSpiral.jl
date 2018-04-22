
using PyPlot
using UlamSpiral

# text spirals
text_spiral()
savefig("plots/ulam_spiral_0.pdf")
savefig("plots/ulam_spiral_0.png")

text_spiral( 100; fig_n=2, fontsize=16)
savefig("plots/ulam_spiral_1.pdf")
savefig("plots/ulam_spiral_1.png")

text_spiral(fig_n=3, color_comp="white", color_prime="black", width=20, fontsize=10)
savefig("plots/ulam_spiral_2.pdf")
savefig("plots/ulam_spiral_2.png")

# points
point_spiral()
savefig("plots/ulam_spiral_3.pdf")
savefig("plots/ulam_spiral_3.png")

point_spiral( 1000; fig_n=4, markersize=10)
savefig("plots/ulam_spiral_4.pdf")
savefig("plots/ulam_spiral_4.png")

point_spiral(fig_n=5, markersize=1, color="black", width=200)
savefig("plots/ulam_spiral_5.pdf")
savefig("plots/ulam_spiral_5.png")

text_spiral(fig_n=6, color_comp="white", color_prime="black", width=20, fontsize=10)
point_spiral(fig_n=6, markersize=3, marker="s", color="green", width=20, clear="off")
savefig("plots/ulam_spiral_6.pdf")
savefig("plots/ulam_spiral_6.png")


