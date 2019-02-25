# Tomcat Vulnerabilities

Curated vulnerability data for vulnerabilityhistory.org

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
