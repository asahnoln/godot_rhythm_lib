class_name BeatProcessor

var apm := 60

var _last_index := -1.0


# Register hit
func hit(time: float) -> bool:
	var result := false
	
	# Find current index and check if it's close enough to integral index
	var index := time / 60 * apm
	var close_index = round(index)
	var buffer := abs(index - close_index)
	if buffer < 0.15:
		result = _last_index != close_index
			
	_last_index = close_index
	return result

