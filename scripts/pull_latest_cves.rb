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
    link.href.upcase.match(/(?<svnid>\d+)/)[:svnid].to_i
  end

  def crawl(url)
    cves = {}
    Mechanize.new.get(url) do |page|
      cur_cve = 'REPLACEME'
      page.links.each do | link |
        if is_cve?(link)
          # byebug
          cur_cve = get_cve(link)
          cves[cur_cve] = []
        else
          if is_svn?(link)
            cves[cur_cve] << get_svn_commit(link)
            # byebug
          end
        end
      end
    end
    return cves
  end

  def save(cves)
    puts cves
    cves.each do |cve, fixes|

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
