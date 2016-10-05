docker-mumble
=============

Docker image for Mumble server.

[![](https://images.microbadger.com/badges/image/phlak/mumble.svg)](http://microbadger.com/#/images/phlak/mumble "Get your own image badge on microbadger.com")

Running the Container
---------------------

In order to persist configuration data when upgrading your container you should create a named data
volume. This is not required but is _highly_ recommended.

    docker volume create --name mumble-data

After the data-only container has been created run your server container with shared volumes from
the data-only container:

    docker run -d -p 64738:64738 -p 64738:64738/udp -v mumble-data:/etc/mumble --name mumble-server phlak/mumble


#### Optional 'docker run' arguments

`--restart always` - Always restart the container regardless of the exit status. See the Docker
                     [restart policies](https://goo.gl/OI87rA) for additional details.

Get/Set the SuperUser Password
------------------------------

After starting your container, you can get the randomly generated SuperUser password with:

    docker logs mumble-server 2>&1 | grep "Password for 'SuperUser'"

**--- OR ---**

Manually set a new SuperUser password with:

    docker exec -it mumble-server supw

**NOTE:** This can be run at any time to update the SuperUser password

Edit the Config
---------------

Once you have a running container, you can edit the config with:

    docker exec -it mumble-server vi /etc/mumble/config.ini

After saving changes, restart your container:

    docker restart mumble-server

Troubleshooting
---------------

Please report bugs to the [GitHub Issue Tracker](https://github.com/PHLAK/docker-mumble/issues).

Copyright
---------

This project is liscensed under the [MIT License](https://github.com/PHLAK/docker-mumble/blob/master/LICENSE).
