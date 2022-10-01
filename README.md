# Tomcat Vulnerabilities

Curated vulnerability data for the Tomcat Web Server vulnerabilityhistory.org

# The Build ![YML & Editorial Checkers](https://github.com/VulnerabilityHistoryProject/tomcat-vulnerabilities/workflows/YML%20&%20Editorial%20Checkers/badge.svg)

# For SWEN 331 students

Please see your course website for instructions. This README is more for people managing this data.

# Testing project locally

1. You'll need Ruby 2.4+
2. Run `gem install bundler` (if you don't already have bundler)
3. `cd` to the root of this repo, run `bundle install`
4. Run `bundle exec rake`

If the output has no *failures*, then it checks out!

# Clone the Repos

Tomcat has three repos, one for each of its active products (7,8,9)

When you do:

`$ rake pull:repo`

All three will be cloned into tmp/ folder

# Get the latest CVEs

Run the Tomcat scraper to get all CVEs and update the ones that don't exist.

`$ rake pull:cves`

# List the CVEs that ready to curate

List all CVEs that have at least one fix commit and curated is `false`

`$ rake curate:ready`
