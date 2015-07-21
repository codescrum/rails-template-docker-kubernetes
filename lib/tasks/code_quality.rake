require 'pry'
# all tasks associated with code quality inspection
namespace :code_quality do
  desc 'Executes all available code inspection for the current app'
  task :check do
    `rubycritic app`
    `rubocop --format html -o tmp/rubocop.html`
    `brakeman -o tmp/brakeman.html`
    `rails_best_practices -f html --output-file tmp/rails_best_practices.html`
    puts `inch`
  end
end
