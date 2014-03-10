require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.with_filename = true
PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.send("disable_double_quoted_strings")
PuppetLint.configuration.send("disable_documentation")
PuppetLint.configuration.ignore_paths = exclude_paths

task :lint_status do
  $stderr.puts "---> lint"
end

task :lint => :lint_status
