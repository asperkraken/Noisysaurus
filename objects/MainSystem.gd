extends Control

## fps locked to 30 for mth consistency
export var _bpm : int = 120
var _realTime = (30/_bpm)
var _note = (_realTime/2)
var _frameCount = 0
var _frameLimit = (_note*16)

var _isPlaying = false
var _sequenceLoop = false
var _sequenceState = 0 
var _track1steps = []


func _ready():
	_track1steps = [$Step0,$Step1,$Step2,$Step3]



func _sequencer():
	match _sequenceState:
		0:
			_frameCount+=_note*4
			_sequenceState+=1
			if $Step0._isTrig:
				$Step0._play()
		1:
			_frameCount+=_note*4
			_sequenceState+=1
			if $Step1._isTrig:
				$Step1._play()
		2:
			_frameCount+=_note*4
			_sequenceState+=1
			if $Step2._isTrig:
				$Step2._play()
		3:
			_frameCount+=_note*4
			_sequenceState+=1
			if $Step3._isTrig:
				$Step3._play()


func _process(_delta):
	if _sequenceState > 3:
		_sequenceState = 0
		_frameCount = 0
		for _s in _track1steps:
			_s._hasTriggered = false


	if _isPlaying:
		_sequencer()


func _on_PlayButton_pressed():
	if !_isPlaying:
		_sequencer()
		$MasterClock.start(_note)
	
	
	_isPlaying = !_isPlaying
	
	if _isPlaying:
		$PlayButton.icon = load("res://graphics/stop_icon.png")
	else:
		$PlayButton.icon = load("res://graphics/play_icon.png")
