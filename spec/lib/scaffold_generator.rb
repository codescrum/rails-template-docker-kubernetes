require 'spec_helper'
require 'rails/generators/rails/scaffold_generator'

describe Rails::Generators::ScaffoldGenerator, type: :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  destination File.expand_path('../../../tmp/tests', __FILE__)

  before do
    prepare_destination
    run_generator %w(user name:string email:string age:integer)
  end

  # subject { file 'app/api/test_app/entities/users/default.rb' }

  it 'test' do
    # binding.pry
    puts ''
  end
end
