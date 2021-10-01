class_name BeatProcessor

const JATHI := 4

var apm := 60.0 setget _set_apm
var pattern := [4] setget _set_pattern

var _last_index := -1
var _matras_pattern := [true, false, false, false]
var _matras_sum := 4
var _matra_length := 60.0 / apm / JATHI


# Register hit
func hit(time: float) -> bool:
	var result := false
	
	var index := time / _matra_length
	var close_index: int = round(index)
	var buffer := abs(index - close_index)

	if buffer < 0.5:
		result = _last_index != close_index and _matras_pattern[close_index % _matras_sum]

	_last_index = close_index
	return result


func update_time(time: float) -> void:
	pass
	

# Update matra length
func _set_apm(value: float) -> void:
	apm = value
	_matra_length = 60.0 / apm / JATHI


# Update pattern sum and matras pattern
func _set_pattern(value: Array) -> void:
	_matras_sum = 0
	_matras_pattern = []
	
	for i in value:
		_matras_sum += i
		_matras_pattern.push_back(true)
		for _i in i - 1:
			_matras_pattern.push_back(false)
	
	pattern = value
	
