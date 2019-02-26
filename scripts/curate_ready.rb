require_relative 'helpers'

class CurateReady
  def print_readiness(print_ready=true)
    cve_ymls.each do |yml_file|
      yml = File.open(yml_file) { |f| YAML.load(f) }
      any_fix = yml['fixes'].inject(false) do |memo, fix|
        memo || !fix['commit'].to_s.empty? || !fix[:commit].to_s.empty?
      end
      if !yml['curated']
        if any_fix
          puts yml['CVE'] if print_ready # READY
        else
          puts yml['CVE'] if !print_ready # NOT READY
        end
      end # if it's already curated, it's "done"
    end
  end
end
