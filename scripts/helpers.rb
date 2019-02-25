def cve_ymls
  Dir['cves/*.yml']
end

def cve_yaml_exists?(cve)
  File.exists? as_filename(cve)
end

def as_filename(cve)
  File.expand_path('../cves/', __dir__) + '/' + cve + ".yml"
end

# Return the text of the CVE skeleton
def cve_skeleton_yml
  File.read(File.expand_path('../skeletons/cve.yml', __dir__))
end

def repo_dirs
  %w(tomcat55 tomcat70 tomcat80 tomcat85 tomcat).map do |t|
    File.expand_path("../tmp/#{t}", __dir__)
  end
end

def svn_id_to_git_sha(svn_id)
  git_sha = ''
  repo_dirs.each do |repo_dir|
    Dir.chdir(repo_dir) do
      s = `git log --pretty="%H" --grep="trunk@#{svn_id} `.strip # note final space!!
      git_sha = s unless s.empty?
    end
  end
  return git_sha
end

def fix_skeleton
  <<~EOS
    fixes:
       - commit:
         note:
       - commit:
         note:
  EOS
end

# Replace text in an entire file
def replace_in_file(file, pattern, replacement)
  str = File.read(file)
  str.gsub!(pattern, replacement)
  File.open(file, "w") { |f| f.write(str) }
end
