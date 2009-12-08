require 'rubygems'
require 'scruffy'

graph = Scruffy::Graph.new
graph.title = "Sample Line Graph"
graph.renderer = Scruffy::Renderers::Standard.new

graph.add :line, 'Example', [20, 100, 70, 30, 106]

graph.render :to => "line_test.svg"
graph.render :width => 300, :height => 200,
:to => "line_test.png", :as => 'png'
