# udp2sqs-server

Simple UDP server. Posts UDP payloads to a configured AWS SQS queue.

[![Build Status](https://travis-ci.org/meducation/udp2sqs-server.png)](https://travis-ci.org/meducation/udp2sqs-server)
[![Dependencies](https://gemnasium.com/meducation/udp2sqs-server.png?travis)](https://gemnasium.com/meducation/udp2sqs-server)
[![Code Climate](https://codeclimate.com/github/meducation/udp2sqs-server.png)](https://codeclimate.com/github/meducation/udp2sqs-server)

## Installation

Add this line to your application's Gemfile:

    gem 'udp2sqs-server'

If you want to use the latest version from Github, you can do:

    gem 'udp2sqs-server', github: "meducation/udp2sqs-server"

And then execute:

    $ bundle

To complete the installation copy queue.yaml.example to queue.yaml and fill in your

* aws-access-key
* aws-secret-key
* aws-sqs-url
* aws-region

To run the server type:

<pre>
./bin/udp2sqs hostname port
</pre>

with the hostname and port of the server you want to listen to UDP messages from. For exxample:

<pre>
./bin/udp2sqs 0.0.0.0 9732
</pre>

## Contributing

Firstly, thank you!! :heart::sparkling_heart::heart:

Please read our [contributing guide](https://github.com/meducation/udp2sqs-client/tree/master/CONTRIBUTING.md) for information on how to get stuck in.

## Licence

Copyright (C) 2013 New Media Education Ltd

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

A copy of the GNU Affero General Public License is available in [Licence.md](https://github.com/meducation/udp2sqs-client/blob/master/LICENCE.md)
along with this program.  If not, see <http://www.gnu.org/licenses/>.
