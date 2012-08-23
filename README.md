[![build status](https://secure.travis-ci.org/walling/geo-distance.png)](http://travis-ci.org/walling/geo-distance)

Common JS module for calculating and converting Earth distances using correct
[great-circle distance formula](http://en.wikipedia.org/wiki/Great-circle_distance).


Installation
------------

    npm install geo-distance


Usage example
-------------

For JavaScripters:

    var Distance = require('geo-distance');

    console.log('' + Distance('50 km').human_readable('customary'));

    var Oslo = {
      lon: 59.914,
      lat: 10.752
    };
    var Berlin = {
      lon: 52.523,
      lat: 13.412
    };
    var OsloToBerlin = Distance.between(Oslo, Berlin);

    console.log('' + OsloToBerlin.human_readable());
    if (OsloToBerlin > Distance('800 km')) {
      console.log('Nice journey!');
    }

For CoffeeScripters:

    Distance = require 'geo-distance'

    console.log "#{ Distance('50 km').human_readable 'customary' }"

    Oslo =
      lon: 59.914
      lat: 10.752
    Berlin =
      lon: 52.523
      lat: 13.412
    OsloToBerlin = Distance.between Oslo, Berlin

    console.log "#{ OsloToBerlin.human_readable() }"
    console.log 'Nice journey!' if OsloToBerlin > Distance '800 km'


License
-------

The image `example/earth.jpg` is a rescaled version of a NASA image in the
public domain. All other files are released under the MIT license:

    Copyright (c) 2011 Bjarke Walling <bwp@bwp.dk>
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to
    deal in the Software without restriction, including without limitation the
    rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
    sell copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.

