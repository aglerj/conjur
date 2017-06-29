---
title: Get Started
layout: sidebar
---

{% include toc.md key='client' %}
#### Download the Conjur Client from Docker Hub

You can easily download and run the Conjur CLI using the official pre-built images hosted by Docker Hub. 

Here's how to run interactively:

{% highlight shell %}
$ docker run -it \
    conjurinc/cli5
root@5628127eac77:/# which conjur
/usr/local/bundle/bin/conjur
{% endhighlight %}


{% include toc.md key='server' %}

In just a few seconds, you can obtain a [hosted Conjur account](https://possum-cpanel-ci-conjur.herokuapp.com/) for demo and evaluation purposes.

* Choose an organization account name (e.g. “yourname” or “yourcorp”).
* Enter your email address that you'll use to configure your Conjur test environment.

To configure using the environment, export the following variables:

* **CONJUR_APPLIANCE_URL** The URL to the Conjur server (example: "http://conjur")
* **CONJUR_ACCOUNT** The organization account name (example: "mycorp").

You can configure a shell session for the CLI by exporting the variables shown above. For example:

{% highlight shell %}
$ export CONJUR_APPLIANCE_URL=http://conjur
$ export CONJUR_ACCOUNT=mycorp
{% endhighlight %}


{% include toc.md key='login' %}
Once you have setup your server and client, login to Conjur:

{% highlight shell %}
$ conjur authn login admin
Please enter admin's password (it will not be echoed): *******
Logged in
{% endhighlight %}


And finally, make sure you are logged in as the admin user:

{% highlight shell %}
$ conjur authn whoami
{ "account": "mycorp", "user": "admin" }
{% endhighlight %}

## Next Steps
Now that you're up & running with Conjur, check out the [Tutorials](https://possum-cpanel-ci-conjur.herokuapp.com/) and [Documentation](https://possum-cpanel-ci-conjur.herokuapp.com/) sections to learn more about:
* [Machine Identity](https://possum-cpanel-ci-conjur.herokuapp.com/)
* [Policies](https://possum-cpanel-ci-conjur.herokuapp.com/)
* [Integrations](https://possum-cpanel-ci-conjur.herokuapp.com/)
* [Secrets](https://possum-cpanel-ci-conjur.herokuapp.com/)