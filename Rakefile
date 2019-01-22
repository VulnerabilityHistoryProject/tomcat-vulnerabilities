require 'require_all'
require_rel 'scripts'
require 'byebug'

namespace :pull do
  task :cves do
    PullLatestCVEs.new.run
  end
end
