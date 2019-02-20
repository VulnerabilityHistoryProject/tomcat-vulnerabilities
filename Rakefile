require 'byebug'
require 'require_all'
require 'rspec/core/rake_task'
require_rel 'scripts'

desc 'Run the specs by default'
task default: :spec

RSpec::Core::RakeTask.new(:spec)

namespace :pull do
  task :cves do
    PullLatestCVEs.new.run
  end

  task :repo do
    Dir.chdir("tmp/") do
      `git clone https://github.com/apache/tomcat.git`
    end
  end
end
