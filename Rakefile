# Ignore vendored code. Called by other tasks.
def exclude_paths
  ["build/**/*", "vendor/**/*"]
end

FileList['lib/tasks/*.rake'].each do |rake_file|
  import rake_file
end

task :default => [
  :syntax,
  :lint,
  :spec,
]
