extends Control


export var _bpm : int = 120
var _clock = _bpm
var _realTime = _clock/60000
var _note = _realTime/16

var _isPlaying = false
var _sequenceState = 0 
var _track1steps = []


func _ready():
	_clockUpdate()
	_track1steps = [$Step0,$Step1,$Step2,$Step3]



func _clockUpdate():
	_clock = _bpm
	_realTime = _clock/60000
	_note = _realTime/16


func _sequencer():
	_clockUpdate()
	$MasterClock.start(_note)


	match _sequenceState:
		0:
			_sequenceState+=1
			if $Step0._isTrig:
				$Step0._play()
		1:
			_sequenceState+=1
			if $Step1._isTrig:
				$Step1._play()
		2:
			_sequenceState+=1
			if $Step2._isTrig:
				$Step2._play()
		3:
			_sequenceState+=1
			if $Step3._isTrig:
				$Step3._play()


func _process(_delta):
	if _sequenceState > 3:
		_sequenceState = 0
		for _s in _track1steps:
			_s._hasTriggered = false


	_realTime = (_bpm/60000)*_delta
	_note = (_realTime/16)*_delta


func _on_MasterClock_timeout():
	if _isPlaying:
		_sequencer()
	else:
		$MasterClock.stop()


func _on_PlayButton_pressed():
	if !_isPlaying:
		_sequencer()
		$MasterClock.start(_note)
	
	
	_isPlaying = !_isPlaying
	
	if _isPlaying:
		$PlayButton.icon = load("res://graphics/stop_icon.png")
	else:
		$PlayButton.icon = load("res://graphics/play_icon.png")
