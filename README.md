docker-mumble
=============

Docker container for Mumble server.

[![](https://badge.imagelayers.io/phlak/docker-mumble:latest.svg)](https://imagelayers.io/?images=phlak/docker-mumble:latest 'Get your own badge on imagelayers.io')


### Running the container

First create a data-only container to hold the persistent config data:

    docker run --name mumble-data phlak/mumble echo "Data-only container for Mumble server"

Then run the Mumble server:

    docker run -d -p 64738:64738 -p 64738:64738/udp --volumes-from mumble-data --restart=always --name mumble-server phlak/mumble


##### Get/set the SuperUser password

After starting your container, you can get the randomly generated SuperUser password with:

    docker logs mumble-server 2>&1 | grep "Password for 'SuperUser'"

**--- OR ---**

Manually set a new SuperUser password with:

    docker exec -it mumble-server /srv/scripts/update-pw

**NOTE:** This can be run at any time to update the SuperUser password


##### Edit the config

Once you have a running container, you can edit the config with:

    docker exec -it mumble-server vi /srv/mumble/config.ini

After saving changes, restart your container with `docker restart mumble-server`


-----

**Copyright (c) 2015 Chris Kankewicz <Chris@ChrisKankiewicz.com>**

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
