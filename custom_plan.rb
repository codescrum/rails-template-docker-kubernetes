require 'zeus/rails'
# Modifies the behaviour for zeus using its defined scenarios (test, cucumber, etc)
class CustomPlan < Zeus::Rails
  # def my_custom_command
  #  # see https://github.com/burke/zeus/blob/master/docs/ruby/modifying.md
  # end

  # According to this issue https://github.com/burke/zeus/issues/131
  def test
    require 'simplecov'
    formatters = [SimpleCov::Formatter::HTMLFormatter]
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]
    start_simplecov
    # require all ruby files
    Dir["#{Rails.root}/app/**/*.rb"].reject { |file| file[%r{/app/controllers/concerns/}] || file[%r{/app/models/concerns/}]  }.each { |file| load file }
    # run the tests
    super
  end

  private

  def start_simplecov
    SimpleCov.start do
      filters = ['config/', 'spec/']
      filters.each { |filter| add_filter filter }
      groups = [['Models', 'app/models'], ['Controllers', 'app/controllers'], ['Helpers', 'app/helpers'], ['Services', 'app/services'], ['Mailers', 'app/mailers']]
      groups.each { |group| add_group(*group) }
      # You can regroup your files by their properties (for example 'lines')
      add_group 'Long files' do |src_file|
        src_file.lines.count > 100
      end
    end
  end
end

Zeus.plan = CustomPlan.new
