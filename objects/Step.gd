extends Button


## graphic constants/resources
const _REST = preload("res://graphics/rest.png")
const _READY = preload("res://graphics/ready.png")
const _TRIG = preload("res://graphics/oontz.png")

## logic
var _isTrig = false ## is this a sound trigger?
var _hasTriggered = false ## has this sound triggered?
onready var _cue = $Cue ## sound file ref


func _process(_delta):
	if pressed: ## button will handle own graphics and trig reporting
		_isTrig = true
		if !_hasTriggered:
			icon = _READY
		else:
			icon = _TRIG
	else:
		icon = _REST
		_isTrig = false


func _play():
	_hasTriggered = true
	$Cue.play()


func _stop():
	$Cue.stop()


func _on_Cue_finished():
	icon = _READY
