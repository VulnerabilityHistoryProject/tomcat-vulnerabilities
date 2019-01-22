require 'require_all'
require_rel 'scripts'
require 'byebug'

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
