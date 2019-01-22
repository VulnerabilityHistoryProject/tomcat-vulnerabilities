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

def repo_dir
  File.expand_path('../tmp/tomcat', __dir__)
end

def svn_id_to_git_sha(svn_id)
  Dir.chdir(repo_dir) do
    `git log --pretty="%H" --grep="tomcat/trunk@#{svn_id} ` # note final space!!
  end
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
