def gnuplot(commands)
  IO.popen("gnuplot", "w") {|io| io.puts commands}
end

# Create an SVG plot using Gnuplot's built-in mathematical functions
commands =
  %Q(
     set terminal svg
     set output "curves.svg"
     plot [-10:10] sin(x),atan(x),cos(atan(x))
    )
gnuplot(commands)

