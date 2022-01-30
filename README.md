# owasp-test-site

Container to run a local test environment when making PRs or edits to the new OWASP website driven by Github pages / Jekyll

**Why**

If you don't want to install Jekyll locally (and clutter up your file system) then this container allows a quick locally running instance of Jekyll setup for the new OWASP website.  Additionally, it starts the Jekyll server with live reload enabled so changes to your files launches a new site build.

**Goals**

Simple container with everything needed to test a OWASP website before doing a PR.

### Running the docker

The docker command below needs to be run from within the git repo you've cloned/forked so that the OWASP site content is in the current working directory:

```
docker run -it --rm --name owasp-test -v `pwd`:/opt/owasp-test/ -p 8888:80 mtesauro/owasp-test-site:0.1.0
```

Once the container is running, you can visit the site at http://localhost:8888/

If you don't want to pull the container from my Docker Hub repository, see "Building" below.

### Errors while building site

Depending on your git workflow, you may encounter the error below while running the container:


```
Configuration file: /opt/owasp-test/_config.yml
             Source: /opt/owasp-test
        Destination: /opt/owasp-test/_site
  Incremental build: disabled. Enable with --incremental
       Generating...
       Remote Theme: Using theme owasp/www--site-theme
      Not Installed: No such file or directory - git
   Liquid Exception: No repo name found. Specify using PAGES_REPO_NWO environment variables, 'repository' in your configuration, or set up an 'origin' git remote pointing to your github.com repository. in /_layouts/col-sidebar.html
              ERROR: YOUR SITE COULD NOT BE BUILT:
                     ------------------------------------
                     No repo name found. Specify using PAGES_REPO_NWO environment variables, 'repository' in your configuration, or set up an 'origin' git remote pointing to your github.com repository.

 =============================================
   Sometimes the site will fail to build
   When this happens, add a repository line
   like below to _config.yml
     'repository: "owasp/www-community"'
 =============================================
```

If you run into this error, it is generally solved by adding the repository option to _config.yml.  For example, adding that to the [OWASP Community pages repo](https://github.com/mtesauro/www-community/blob/master/_config.yml) would result in a _config.yml that looks like:

```
remote_theme: "owasp/www--site-theme@main"
repository: "owasp/www-community"
# core files/folders to exclude
exclude:
 - README.md

plugins:
 - jekyll-include-cache-0.2.0
 - jekyll-redirect-from
```

**DO NOT ADD/COMMIT THE MODIFIED _config.yml with your changes**

### Building

Clone this repo and use of the below commands.

```
docker build --no-cache -f ./owasp-test-site.dockerfile -t "owasp-test-site:0.1.1" .
```

If you like using ':latest' to keep from having to type the version label:

```
docker build --no-cache -f ./owasp-test-site.dockerfile -t "owasp-test-site:0.1.1" -t "owasp-test-site:latest" .
```

### References

* OWASP Theme repo - https://github.com/OWASP/www--site-theme
* Jekyll remote theme repo - https://github.com/benbalter/jekyll-remote-theme
* OWASP community repo - https://github.com/OWASP/www-community
* Jekyll installation docs - https://jekyllrb.com/docs/installation/ubuntu/
* OWASP migration page - https://owasp.org/migration/

