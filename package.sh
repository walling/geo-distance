#!/bin/sh

# Make Data URL in JavaScript source from JPEG image.
echo -n 'window.earth_src = "data:image/jpeg;base64,' > example/earth.js
base64 -w0 example/earth.jpg >> example/earth.js
echo '";' >> example/earth.js

# Compile CoffeeScript to JavaScript.
coffee -c .
