class_name BeatProcessor

var apm := 60

var _last_time := -1.0


# Register hit
func hit(time: float) -> bool:
	var result := false
	
	# Find current index and check if it's close enough to integral index
	var index := time / 60 * apm
	var buffer := abs(index - round(index))
	if buffer < 0.15:
		result = _last_time != time
			
	_last_time = time
	return result

