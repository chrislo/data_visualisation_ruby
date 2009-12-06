class Plot
  require 'java'
  require 'jcommon-1.0.16'
  require 'jfreechart-1.0.13'

  include_class 'java.io.File'
  include_class 'org.jfree.chart.ChartUtilities'
  include_class 'org.jfree.chart.JFreeChart'
  include_class 'org.jfree.chart.plot.PiePlot'
  include_class 'org.jfree.data.general.DefaultPieDataset'
  
  def initialize(width=400, height=600)
    @width = width
    @height = height
    dataset = pie_data
    @chart = create_chart(dataset)
  end

  def render_to_file(filename, format="png")
    javafile = java.io.File.new(filename)
    ChartUtilities.saveChartAsPNG(javafile, @chart, @width, @height)
  end

  private
  def pie_data
    dataset = DefaultPieDataset.new
    dataset.setValue("Doesn't", 20)
    dataset.setValue("Looks like pacman", 80)
    return dataset
  end

  def create_chart(dataset)
    plot = PiePlot.new
    plot.setDataset(dataset)

    chart = JFreeChart.new(nil, JFreeChart::DEFAULT_TITLE_FONT, plot, false)
    chart.setBorderVisible(false);
    return chart
  end
end 

plot = Plot.new
puts "Rendering plot"
plot.render_to_file("plot.png")
