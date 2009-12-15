require 'rubygems'
require 'Tioga/FigureMaker'

include Tioga
include Math
include FigureConstants

# Tioga includes a Vector class to help with function plotting
num = 50
xs = Dvector.new(num) {|i| 2*PI*i/(num-1) }    
ys = xs.sin

# Create the Plot and export as a PDF
FigureMaker.make_pdf('demo') do |t|
  
  # Labels for the plot (LaTeX code is rendered)
  title  = 'Sine from $0$ to $2\pi$'
  xlabel = '$x$'
  ylabel = '$\sin(x)$'
  t.do_box_labels(title, xlabel, ylabel)
  
  # set boundary for plot ([left, right, top, bottom])
  boundaries = [0, 2*PI, 1, -1] 

  # The plot
  t.show_plot(boundaries) do
    t.show_polyline(xs,ys,Blue)
  end
end
