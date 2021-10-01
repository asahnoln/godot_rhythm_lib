class_name BeatProcessor

var apm := 60

var _last_time := -1.0


# Register hit
func hit(time: float) -> bool:
	var result := false
	
	# Check if index is integral, so it's aligned to the beat
	var index := time / 60 * apm
	if index == floor(index):
		result = _last_time != time
			
	_last_time = time
	return result

