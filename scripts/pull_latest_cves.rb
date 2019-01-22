require 'mechanize'

class PullLatestCVEs
  def tomcat_security_pages
    %w(
      http://tomcat.apache.org/security-9.html
      http://tomcat.apache.org/security-8.html
      http://tomcat.apache.org/security-7.html
      http://tomcat.apache.org/security-6.html
      http://tomcat.apache.org/security-5.html
      http://tomcat.apache.org/security-4.html
      http://tomcat.apache.org/security-3.html
    )
  end

  def is_cve?(link)
    link.href.include? "cve.mitre.org"
  end

  def is_svn?(link)
    link.href.include? "svn.apache.org"
  end

  def get_cve(link)
    link.href.upcase.match( /(?<cvekey>CVE-[\-\d]+)/ )[:cvekey]
  end

  def get_svn_commit(link)
    link.href.upcase.match(/(?<svnid>\d+)/)[:svnid]
  end

  def crawl(url)
    cves = {}
    Mechanize.new.get(url) do |page|
      cur_cve = 'REPLACEME'
      page.links.each do | link |
        if is_cve?(link)
          cur_cve = get_cve(link)
          cves[cur_cve] = []
        else
          if is_svn?(link)
            cves[cur_cve] << get_svn_commit(link)
          end
        end
      end
    end
    return cves
  end

  def fix_ymlstr(fixes)
    fixes.inject("fixes:\n") do |str, fix|
      str + "   - commit: " + fix + "\n"
    end
  end

  def save(cves)
    byebug
    cves.each do |cve, fixes|
      next if cve_yaml_exists?(cve)
      ymlstr = cve_skeleton_yml.sub(fix_skeleton, fix_ymlstr(fixes))
      File.open(as_filename(cve), 'w+') { |f| f.write(ymlstr) }
    end
  end

  def run
    cves = {}
    tomcat_security_pages.each do |url|
      cves.merge! crawl(url) do |k, v1, v2|
         # CVEs can be on multiple pages, so merge the fix lists
        (v1 + v2).uniq
      end
    end
    save(cves)
  end

end
