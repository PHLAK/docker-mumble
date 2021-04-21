docker-mumble
=============

<p align="center">
    <img src="docker-mumble.png" alt="Docker Mumble" width="500">
<p>

<p align="center">
    <a href="https://spectrum.chat/phlaknet"><img src="https://img.shields.io/badge/Join_the-Community-7b16ff.svg?style=for-the-badge" alt="Join our Community"></a>
    <a href="https://github.com/users/PHLAK/sponsorship"><img src="https://img.shields.io/badge/Become_a-Sponsor-cc4195.svg?style=for-the-badge" alt="Become a Sponsor"></a>
    <a href="https://paypal.me/ChrisKankiewicz"><img src="https://img.shields.io/badge/Make_a-Donation-006bb6.svg?style=for-the-badge" alt="One-time Donation"></a>
    <br>
    <a href="https://hub.docker.com/repository/docker/phlak/mumble/tags"><img alt="Docker Image Version" src="https://img.shields.io/docker/v/phlak/mumble?style=flat-square&sort=semver"></a>
    <a href="https://hub.docker.com/repository/docker/phlak/mumble"><img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/phlak/mumble?style=flat-square"></a>
    <a href="https://hub.docker.com/repository/docker/phlak/mumble/builds"><img src="https://img.shields.io/docker/cloud/build/phlak/mumble?style=flat-square" alt="Docker Cloud Build Status"></a>
    <a href="https://github.com/PHLAK/docker-mumble/blob/master/LICENSE"><img src="https://img.shields.io/github/license/PHLAK/docker-mumble?style=flat-square" alt="License"></a>
</p>

<p align="center">
  Docker image for Mumble server.
</p>

---

Running the Container
---------------------

In order to persist configuration data when upgrading your container you should create a named data
volume. This is not required but is _highly_ recommended.

    docker volume create --name mumble-data

After the data volume has been created run the server container with the named data volume:

    docker run -d -p 64738:64738 -p 64738:64738/udp -v mumble-data:/etc/mumble --name mumble-server phlak/mumble

#### Optional `docker run` arguments

<dl>
    <dt><code>-e SUPERUSER_PASSWORD=password</code></dt>
    <dd>Set the superuser password for your server during container initialization.</dd>
</dl>

<dl>
    <dt><code>-e TZ=America/Phoenix</code></dt>
    <dd>Set the timezone for your server. You can find your timezone in this <a href="https://goo.gl/uy1J6q">list of timezones</a>. Use the (case sensitive) value from the <code>TZ</code> column. If left unset, timezone will be UTC.</dd>
</dl>

<dl>
    <dt><code>--restart unless-stopped</code></dt>
    <dd>Always restart the container regardless of the exit status, but do not start it on daemon startup if the container has been put to a stopped state before. See the Docker <a href="https://goo.gl/Y0dlDH">restart policies</a> for additional details.</dd>
</dl>

Get/Set the SuperUser Password
------------------------------

After starting your container, you can get the randomly generated SuperUser password with:

    docker logs mumble-server 2>&1 | grep "Password for 'SuperUser'"

**--- OR ---**

Manually set a new SuperUser password with:

    docker exec -it mumble-server supw

**NOTE:** This can be run at any time to update the SuperUser password

**--- OR ---**

Provide a SuperUser password using the `SUPERUSER_PASSWORD` environment variable (see the [Optional `docker run` arguments](#optional-docker-run-arguments) section above).

Edit the Config
---------------

Once you have a running container, you can edit the config with:

    docker exec -it mumble-server vi /etc/mumble/config.ini

After saving changes, restart your container:

    docker restart mumble-server

Troubleshooting
---------------

For general help and support join our [Spectrum Community](https://spectrum.chat/phlaknet) or reach out on [Twitter](https://twitter.com/PHLAK).

Please report bugs to the [GitHub Issue Tracker](https://github.com/PHLAK/docker-mumble/issues).

Copyright
---------

This project is licensed under the [MIT License](https://github.com/PHLAK/docker-mumble/blob/master/LICENSE).
