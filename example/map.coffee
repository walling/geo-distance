width  = 400
height = 200
factor_x =  360 / (width  - 1)
factor_y = -180 / (height - 1)

radius_input = null
map_context = null
earth = null

click =
	lat: 0
	lon: 0
radius = Distance 0


update = ->
	radius_input.val radius.human_readable()

	map = map_context.createImageData earth
	map_data   = map.data
	earth_data = earth.data

	for x in [0...width]
		for y in [0...height]
			index = 4 * (y * width + x)
			pixel = [
				x * factor_x - 180
				y * factor_y +  90
			]
			if Distance.between(click, pixel) < radius
				map_data[index    ] = earth_data[index    ] * 1.5
				map_data[index + 1] = earth_data[index + 1] * 1.6
				map_data[index + 2] = earth_data[index + 2] * 1.7
				map_data[index + 3] = earth_data[index + 3]
			else
				map_data[index    ] = earth_data[index    ]
				map_data[index + 1] = earth_data[index + 1]
				map_data[index + 2] = earth_data[index + 2]
				map_data[index + 3] = earth_data[index + 3]
	map_context.putImageData map, 0, 0


$ ->
	map_canvas = $ '#map-canvas'
	map_context = map_canvas.get(0).getContext '2d'

	update_mouse = (event) ->
		map_position = map_canvas.position()
		click =
			x: event.pageX - map_position.left
			y: event.pageY - map_position.top
		click.lat = click.x * factor_x - 180
		click.lon = click.y * factor_y +  90
		$('#position').text """
			#{Math.abs(click.lon).toFixed 1}° #{if click.lon < 0 then 'W' else 'E'},
			#{Math.abs(click.lat).toFixed 1}° #{if click.lat < 0 then 'S' else 'N'}.
		"""
		update()

	earth_canvas = document.createElement 'canvas'
	earth_canvas.width  = width
	earth_canvas.height = height
	earth_context = earth_canvas.getContext '2d'

	update_moving_input = $ '#update-moving'

	earth_img = document.createElement 'img'
	earth_img.src = window.earth_src
	earth_img.onload = ->
		earth_context.drawImage earth_img, 0, 0
		earth = earth_context.getImageData 0, 0, width, height

		map_context.putImageData earth, 0, 0

		map_canvas
		.click(update_mouse)
		.mousemove (event) ->
			update_mouse event if update_moving_input.is ':checked'

	update_radius = ->
		radius = Distance radius_input.val()

	radius_input = $ '#radius'
	radius_input.blur ->
		update_radius()
		update()
	.keydown (event) ->
		update_radius()
		update() if event.keyCode == 13

	update_radius()
