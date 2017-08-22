---
title: Install Conjur
layout: page
section: get-started
---

# Install Conjur CLI

## Install Docker
If you don't have Docker installed, you can download it here:
* [Docker for Mac](https://download.docker.com/mac/stable/16048/Docker.dmg)
* [Docker for Windows](https://docs.docker.com/docker-for-windows/install/#download-docker-for-windows)

## Download & Run the CLI
You can easily download and run the Conjur CLI (command line interface) using
the [official container on DockerHub](https://hub.docker.com/r/cyberark/conjur/).

* Run `docker pull cyberark/conjur`
* Launch a Conjur container:
   ```sh-session
  $ docker run --rm \
    -it -v $PWD:/work
    cyberark/conjur
   ```

<!-- {% include toc.md key='configure' %} -->
## Configure the CLI
The Conjur command-line interface requires two settings to connect to the
server. You can configure these two settings along with some optional ones.

Export the following variables:

* **CONJUR_APPLIANCE_URL** The URL to the Conjur server (example: `http://conjur`)
* **CONJUR_ACCOUNT** The organization account name (example: "mycorp").

If your Conjur server is using a self-signed certificate, you can establish SSL
trust to Conjur with one of the following:

* **CONJUR_SSL_CERTIFICATE** The SSL certificate.
* **CONJUR_CERT_FILE** The path to the certificate file on disk.

<div class="note">
  <em><strong>Note</strong>
  Certificate configuration is not required if you are running Conjur in dev
  mode without HTTPS, or if you are running Conjur with HTTPS and the
  certificate is already trusted by your operating system.</em>
</div>

You can configure a shell session for the CLI by exporting the variables shown
above. For example:

```sh-session
$ export CONJUR_APPLIANCE_URL=http://conjur
$ export CONJUR_ACCOUNT=mycorp
$ conjur authn login admin
Please enter admin's password (it will not be echoed): *******
Logged in
```

<!-- {% include toc.md key='login' %} -->

## Login
You'll need the `admin` API key or password to login to Conjur. If
someone else is managing the Conjur server, they will provide you with
your login information.

```sh-session
$ conjur authn login
Enter your username to log into Conjur: admin
Enter password for user admin (it will not be echoed):
Logged in
```

You can show your current logged-in user with `conjur authn whoami`:

```sh-session
$ conjur authn whoami
{"account":"mycorp","username":"admin"}
```
<hr>
