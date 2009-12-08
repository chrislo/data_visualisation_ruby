require 'rsruby'

# Simple way of generating plots with R is to provide R commands
# directly to the RSRuby instance.
cmd = %Q(
  pdf(file = "r_directly.pdf")
  boxplot(c(1,2,3,4),c(5,6,7,8))
  dev.off()
)

r = RSRuby.instance
r.eval_R(cmd)

# ... but doing that you lose the ability to turn ruby objects into R
# ones. Here's the example above using rsruby's translation
# capabilities

r2 = RSRuby.instance
r2.pdf('rsruby.pdf')
r2.boxplot([1,2,3,4],[5,6,7,8])
r2.dev_off.call

# -- A more complex example --
# Fitting a line to some data
r.pdf('line_fit.pdf')

# Define our data using ruby arrays
x = (1..100).to_a
y = x.map{|xi| xi + (rand(10)-5)}

# to process using R commands we must assign to R variables
r.assign('x', x)
r.assign('y', y)

# Fit a linear model to the data
fit = r.lm('x ~ y')

# .. and plot
r.plot(x,y,:xlab => "x", :ylab => "y")
r.abline(fit["coefficients"]["(Intercept)"], fit["coefficients"]["y"])
r.dev_off.call
