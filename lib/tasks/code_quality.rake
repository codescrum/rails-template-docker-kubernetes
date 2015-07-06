require 'pry'
# all tasks associated with code quality inspection
namespace :code_quality do
  desc 'Executes all available code inspection for the current app'
  task :inspect do
    `rubycritic app`
    `rubocop --format html -o tmp/rubocop.html`
  end
end
