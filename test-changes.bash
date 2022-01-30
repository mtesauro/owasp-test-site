#/bin/bash

# Pull in needed dependencies
echo ""
echo "========================================"
echo "  Installing dynamic dependencies"
echo "========================================"
cd /opt/owasp-test
bundle install

# Statup caddy to front jekyll
echo ""
echo "========================================"
echo "  Starting caddy webserver"
echo "========================================"
cd /opt
./caddy start

# Run the test site in Jekyll
cd /opt/owasp-test
bundle exec jekyll serve

# Warn about potential issue
echo ""
echo "============================================="
echo "  Sometimes the site will fail to build"
echo "  When this happens, add a repository line"
echo "  like below to _config.yml"
echo "    'repository: \"owasp/www-community\"'"
echo "============================================="
echo ""

# Start a new shell
bash
