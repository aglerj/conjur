---
title: Get Started
layout: 2-col
---

{% include toc.md key='client' %}
#### Download the Conjur Client from Docker Hub

You can easily download and run the Conjur CLI using the official pre-built images hosted by Docker Hub. 

If you run the container with interactive mode (`-it`), then you will get an interactive `bash` shell. Otherwise, you will run a single `conjur` command.

Here's how to run interactively:

{% highlight shell %}
$ docker run --rm \
    -it \
    conjurinc/cli5
root@5628127eac77:/# which conjur
/usr/local/bundle/bin/conjur
{% endhighlight %}

And here's how to run a single Conjur command (with arguments, it prints the help string):

{% highlight shell %}
$ docker run --rm \
    -e CONJUR_APPLIANCE_URL=http://conjur \
    -e CONJUR_ACCOUNT=myorg \
    -e CONJUR_AUTHN_LOGIN=admin \
    -e CONJUR_AUTHN_API_KEY=the-secret-api-key \   
    conjurinc/cli5
NAME
    conjur - Command-line toolkit for managing roles, resources and privileges
...
{% endhighlight %}

{% include toc.md key='configure' %}

The Conjur command-line interface requires two settings to connect to the server. You can configure these two settings along with some optional ones using either the environment or using files.

{% include toc.md key='configure' section='environment' %}

To configure using the environment, export the following variables:

* **CONJUR_APPLIANCE_URL** The URL to the Conjur server (example: "http://conjur")
* **CONJUR_ACCOUNT** The organization account name (example: "mycorp").

If your Conjur server is using a self-signed certificate, you can establish SSL trust to Conjur with one of the following:

* **CONJUR_SSL_CERTIFICATE** The SSL certificate.
* **CONJUR_CERT_FILE** The path to the certificate file on disk.

<div class="note">
<strong>Note</strong> Certificate configuration is not required if you are running Conjur in dev mode without HTTPS, or if you are running Conjur with HTTPS and the certificate is already trusted by your operating system.
</div>
<p/>

You can configure a shell session for the CLI by exporting the variables shown above. For example:

{% highlight shell %}
$ export CONJUR_APPLIANCE_URL=http://conjur
$ export CONJUR_ACCOUNT=mycorp
$ conjur authn login admin
Please enter admin's password (it will not be echoed): *******
Logged in
{% endhighlight %}


{% include toc.md key='server' %}

{% include toc.md key='login' %}