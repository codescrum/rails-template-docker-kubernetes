require 'zeus/rails'

class CustomPlan < Zeus::Rails

  # def my_custom_command
  #  # see https://github.com/burke/zeus/blob/master/docs/ruby/modifying.md
  # end

  # According to this issue https://github.com/burke/zeus/issues/131
  def test
    require 'simplecov'
    formatters = [SimpleCov::Formatter::HTMLFormatter]
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]
    SimpleCov.start 'rails'
    # require all ruby files
    Dir["#{Rails.root}/app/**/*.rb"].reject{ |f| f[%r{/app/controllers/concerns/}] || f[%r{/app/models/concerns/}]  }.each { |f| load f }
    # run the tests
    super
  end

end

Zeus.plan = CustomPlan.new
