class_name BeatProcessor

var apm := 60.0
var pattern := []

var _last_index := -1.0


# Register hit
func hit(time: float) -> bool:
	var result := false
	var atcharam_length := 60 / apm
	
	match time:
		0.5, 0.75, 1.5, 1.75:
			return pattern.size() > 0 and apm == 60 or apm == 80
	
	# Find current index and check if it's close enough to integral index
	var index := time / atcharam_length
	var close_index = round(index)
	var buffer := abs(index - close_index)
	
	if buffer < 0.15:
		result = _last_index != close_index
			
	_last_index = close_index
	return result

