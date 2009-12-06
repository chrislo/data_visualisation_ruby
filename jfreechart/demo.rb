class Plot
  require 'java'
  require 'jcommon-1.0.16'
  require 'jfreechart-1.0.13'

  include_class 'java.io.File'
  include_class 'org.jfree.chart.ChartUtilities'
  include_class 'org.jfree.chart.JFreeChart'
  include_class 'org.jfree.chart.axis.NumberAxis'
  include_class 'org.jfree.chart.plot.XYPlot'
  include_class 'org.jfree.chart.renderer.xy.StandardXYItemRenderer'
  include_class 'org.jfree.data.xy.XYSeries'
  include_class 'org.jfree.data.xy.XYSeriesCollection'
  include_class 'org.jfree.chart.plot.PlotOrientation'

  def initialize(width=200, height=200, data=[])
    @width = width
    @height = height
    dataset = create_sample_data() if data.empty?
    @chart = create_chart(dataset)
  end

  def render_to_file(filename, format="png")
    javafile = java.io.File.new(filename)
    ChartUtilities.saveChartAsPNG(javafile, @chart, @width, @height)
  end

  private
  def create_sample_data
    series = XYSeries.new("Sparkline")
    data = [20]
    (1..99).each {|x|
      y = (data.last + (rand(x) + 1)) / 2
      data << y
      series.add(x, y)
    }

    dataset = XYSeriesCollection.new
    dataset.addSeries(series)
    return dataset
  end

  def create_chart(dataset)
    x = NumberAxis.new
    x.setTickLabelsVisible(false)
    x.setTickMarksVisible(false)
    x.setAxisLineVisible(false)
    x.setNegativeArrowVisible(false)
    x.setPositiveArrowVisible(false)
    x.setVisible(false)

    y = NumberAxis.new
    y.setTickLabelsVisible(false)
    y.setTickMarksVisible(false)
    y.setAxisLineVisible(false)
    y.setNegativeArrowVisible(false)
    y.setPositiveArrowVisible(false)
    y.setVisible(false)

    plot = XYPlot.new
    plot.setDataset(dataset)
    plot.setDomainAxis(x)
    plot.setDomainGridlinesVisible(false)
    plot.setDomainCrosshairVisible(false)
    plot.setRangeGridlinesVisible(false)
    plot.setRangeCrosshairVisible(false)
    plot.setRangeAxis(y)
    plot.setOutlinePaint(nil)
    plot.setRenderer(StandardXYItemRenderer.new(StandardXYItemRenderer::LINES))

    chart = JFreeChart.new(nil, JFreeChart::DEFAULT_TITLE_FONT, plot, false)
    chart.setBorderVisible(false);
    return chart
  end

end 

plot = Plot.new
puts "Rendering plot"
plot.render_to_file("plot.png")
