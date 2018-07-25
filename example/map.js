(function() {
  var click, earth, factor_x, factor_y, height, map_context, radius, radius_input, update, width;
  width = 400;
  height = 200;
  factor_x = 360 / (width - 1);
  factor_y = -180 / (height - 1);
  radius_input = null;
  map_context = null;
  earth = null;
  click = {
    lat: 0,
    lon: 0
  };
  radius = Distance(0);
  update = function() {
    var earth_data, index, map, map_data, pixel, x, y;
    radius_input.val(radius.human_readable());
    map = map_context.createImageData(earth);
    map_data = map.data;
    earth_data = earth.data;
    for (x = 0; 0 <= width ? x < width : x > width; 0 <= width ? x++ : x--) {
      for (y = 0; 0 <= height ? y < height : y > height; 0 <= height ? y++ : y--) {
        index = 4 * (y * width + x);
        pixel = [y * factor_y + 90, x * factor_x - 180];
        if (Distance.between(click, pixel) < radius) {
          map_data[index] = earth_data[index] * 1.5;
          map_data[index + 1] = earth_data[index + 1] * 1.6;
          map_data[index + 2] = earth_data[index + 2] * 1.7;
          map_data[index + 3] = earth_data[index + 3];
        } else {
          map_data[index] = earth_data[index];
          map_data[index + 1] = earth_data[index + 1];
          map_data[index + 2] = earth_data[index + 2];
          map_data[index + 3] = earth_data[index + 3];
        }
      }
    }
    return map_context.putImageData(map, 0, 0);
  };
  $(function() {
    var earth_canvas, earth_context, earth_img, map_canvas, update_mouse, update_moving_input, update_radius;
    map_canvas = $('#map-canvas');
    map_context = map_canvas.get(0).getContext('2d');
    update_mouse = function(event) {
      var map_position;
      map_position = map_canvas.position();
      click = {
        x: event.pageX - map_position.left,
        y: event.pageY - map_position.top
      };
      click.lat = click.y * factor_y + 90;
      click.lon = click.x * factor_x - 180;
      $('#position').text("" + (Math.abs(click.lon).toFixed(1)) + "° " + (click.lon < 0 ? 'W' : 'E') + ",\n" + (Math.abs(click.lat).toFixed(1)) + "° " + (click.lat < 0 ? 'S' : 'N') + ".");
      return update();
    };
    earth_canvas = document.createElement('canvas');
    earth_canvas.width = width;
    earth_canvas.height = height;
    earth_context = earth_canvas.getContext('2d');
    update_moving_input = $('#update-moving');
    earth_img = document.createElement('img');
    earth_img.src = window.earth_src;
    earth_img.onload = function() {
      earth_context.drawImage(earth_img, 0, 0);
      earth = earth_context.getImageData(0, 0, width, height);
      map_context.putImageData(earth, 0, 0);
      return map_canvas.click(update_mouse).mousemove(function(event) {
        if (update_moving_input.is(':checked')) {
          return update_mouse(event);
        }
      });
    };
    update_radius = function() {
      return radius = Distance(radius_input.val());
    };
    radius_input = $('#radius');
    radius_input.blur(function() {
      update_radius();
      return update();
    }).keydown(function(event) {
      update_radius();
      if (event.keyCode === 13) {
        return update();
      }
    });
    return update_radius();
  });
}).call(this);
