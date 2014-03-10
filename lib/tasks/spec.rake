require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  desc "Run Puppet specs with rspec-puppet"
  t.pattern = FileList["**/spec/**/*_spec.rb"].exclude(*exclude_paths)
  $stderr.puts '---> spec'
end
