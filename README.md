
Common JS module for calculating and converting Earth distances using correct
[great-circle distance formula](http://en.wikipedia.org/wiki/Great-circle_distance).


Installation
------------

    npm install geo-distance


Notice
------

The lat/lon coordinates were flipped until v0.1.2. This is fixed in v0.2.0. Please be aware, when updating. [Discussion here](https://github.com/walling/geo-distance/issues/2).


Usage example
-------------

For JavaScripters:

    var Distance = require('geo-distance');

    console.log('' + Distance('50 km').human_readable('customary'));

	// https://www.latlong.net/place/oslo-norway-14195.html: Oslo, Norway, Latitude and longitude coordinates are: 59.911491, 10.757933
    var Oslo = {
      lat: 59.914,
      lon: 10.752
    };
    var Berlin = {
      lat: 52.523,
      lon: 13.412
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
      lat: 59.914
      lon: 10.752
    Berlin =
      lat: 52.523
      lon: 13.412
    OsloToBerlin = Distance.between Oslo, Berlin

    console.log "#{ OsloToBerlin.human_readable() }"
    console.log 'Nice journey!' if OsloToBerlin > Distance '800 km'


Other modules
-------------

If you want to work with GeoJSON or maybe just want to calculate distance as a number (fx. kilometers or miles), it is possible to use the [@turf/distance](https://www.npmjs.com/package/@turf/distance) npm module.


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

