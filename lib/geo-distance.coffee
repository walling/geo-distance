

fixed = (number, digits=0) ->
	radix = Math.pow 10, digits
	(Math.ceil(number * radix) / radix).toFixed digits


class Distance

	constructor: (distance, unit) ->
		return new Distance distance, unit unless this instanceof Distance

		if unit
			radians = distance / Distance.unit_conversion[unit]
			unit = unit
		else if typeof distance == 'string'
			distance = distance.replace( /^\s+|\s+$/g, '' ).replace /,/, '.'
			[_, value, unit] = distance.match(Distance.distance_regexp) or []
			if value
				radians = value / Distance.unit_conversion[unit]
		radians = distance * 1.0 unless radians?
		@radians = radians
		@in_good_unit()

	in_unit: (@unit) -> this

	in_good_unit: ->
		if @radians < 1.1 / Distance.unit_conversion['km']
			@unit = 'm'
		else
			@unit = 'km'
		this

	human_readable_in_units: (large_unit, small_unit) ->
		unit = large_unit
		dist = @radians * Distance.unit_conversion[unit]
		if dist < 1.1
			unit = small_unit
			dist = @radians * Distance.unit_conversion[unit]
		{
			distance_earth_radians: @radians
			distance: if dist < 10 then fixed dist, 1 else fixed dist
			unit: unit
			toString: -> "#{@distance} #{@unit}"
		}

	human_readable: (system) ->
		system or= @system()
		switch system
			when 'customary' then @human_readable_in_units 'mi', 'ft'
			else @human_readable_in_units 'km', 'm'

	system: -> Distance.systems[@unit]

	valueOf: -> @radians

	toString: ->
		"#{@radians * Distance.unit_conversion[@unit]} #{@unit}"


if window?
	window.Distance = Distance
else
	module.exports = Distance


Distance.between = (A, B) ->
	degrees_to_radians = Math.PI / 180
	A_lat = (A.lat or A[0] or 0) * degrees_to_radians
	B_lat = (B.lat or B[0] or 0) * degrees_to_radians
	d_lon = Math.abs((B.lon or B[1] or 0) - (A.lon or A[1] or 0)) * degrees_to_radians
	new Distance Math.atan2(
		Math.sqrt(
			Math.pow(Math.cos(B_lat) * Math.sin(d_lon), 2.0) +
			Math.pow(Math.cos(A_lat) * Math.sin(B_lat) - Math.sin(A_lat) * Math.cos(B_lat) * Math.cos(d_lon), 2.0)
		),
		Math.sin(A_lat) * Math.sin(B_lat) + Math.cos(A_lat) * Math.cos(B_lat) * Math.cos(d_lon)
	)


Distance.unit_conversion =
	km:       6372.8
	m:        6372800
	meter:    6372800
	metres:   6372800
	mi:       3959.9
	ml:       3959.9
	mile:     3959.9
	miles:    3959.9
	yd:       6969379
	yard:     6969379
	yards:    6969379
	ft:       20908136
	feet:     20908136


Distance.systems =
	km:       'metric'
	m:        'metric'
	meter:    'metric'
	metres:   'metric'
	mi:       'customary'
	ml:       'customary'
	mile:     'customary'
	miles:    'customary'
	yd:       'customary'
	yard:     'customary'
	yards:    'customary'
	ft:       'customary'
	feet:     'customary'


Distance.distance_regexp = ///^ ([\d\.]+) \s* (#{ Object.keys(Distance.unit_conversion).join '|' }) $///
