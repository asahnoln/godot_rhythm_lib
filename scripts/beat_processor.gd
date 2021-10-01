class_name BeatProcessor

var apm := 60.0
var pattern := [4]

var _last_index := -1.0


# Register hit
func hit(time: float) -> bool:
	var result := false
	var atcharam_length := 60.0 / apm
	
	# Find current index and check if it's close enough to integral index
	var index := time / atcharam_length * 4
	match pattern:
		[4]:
			index /= 4
		[2, 2]:
			index /= 2
		[1, 1, 1, 1]:
			pass
		[2, 1, 1]:
			if int(index) % 4 == 1:
				index -= 0.5
		[1, 2, 1]:
			if int(index) % 4 == 2:
				index -= 0.5
		[1, 2, 1, 2, 1]:
			if int(index) % 7 in [2, 5]:
				index -= 0.5
			
	var close_index := round(index)
	print("last ", _last_index, " current ", index)
	var buffer := abs(index - close_index)
	if buffer < 0.15:
		result = _last_index != close_index
			
	_last_index = close_index
	return result

