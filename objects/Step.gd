extends Button


## graphic constants/resources
const _REST = preload("res://graphics/rest.png")
const _READY = preload("res://graphics/ready.png")
const _TRIG = preload("res://graphics/oontz.png")

## logic
var _isTrig = false ## is this a sound trigger?
var _hasTriggered = false ## has this sound triggered? (changes graphic)
onready var _cue = $Cue ## sound file ref
onready var _highlight = $CurrentStep ## highlight frame


func _process(_delta):
	if pressed: ## button will handle own graphics, cursor and trig reporting
		_isTrig = true
		if !_hasTriggered:
			icon = _READY
		else:
			icon = _TRIG
	else:
		icon = _REST
		_isTrig = false


## external functions for play and stop
func _play():
	_hasTriggered = true
	$Cue.play()


func _stop():
	$Cue.stop()


## notify of mouse entry (use for menu)
func _on_Step0_mouse_entered(): 
	print("Mouse entered area of "+str(self))
