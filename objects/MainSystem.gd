extends Control

## make sure bpm is float so errors
export var _bpm : float = 120.0
## clock reference bpm
var _clock = _bpm
## math for clock time
var _realTime = (30/_clock)
var _note = float(_realTime)

## sequencing logic
var _isPlaying = false
var _sequenceState = 0
var _track1steps = []

## ui element pointer
var _pastCursor


func _ready(): ## fill array with steps of track
	_track1steps = get_tree().get_nodes_in_group("track1")


func _clocking(): ## function to update clocking in real time
	_clock = _bpm
	_realTime = (30/_clock)
	_note = float(_realTime)
	
	$BpmLabel.set_text("BPM: "+str(_bpm))


func _sequencer(): ## state machine for sequencer
	$MasterClock.start(_note)

	match _sequenceState:
		0: ## error handling for end step
			if _isPlaying and $Step15._isTrig:
				$Step15._hasTriggered = true
			_trigger($Step0)
		1: ## error handling for end step
			if _isPlaying and $Step15._isTrig:
				$Step15._hasTriggered = false
			_trigger($Step1)
		2:
			_trigger($Step2)
		3:
			_trigger($Step3)
		4:
			_trigger($Step4)
		5:
			_trigger($Step5)
		6:
			_trigger($Step6)
		7:
			_trigger($Step7)
		8:
			_trigger($Step8)
		9:
			_trigger($Step9)
		10:
			_trigger($Step10)
		11:
			_trigger($Step11)
		12:
			_trigger($Step12)
		13:
			_trigger($Step13)
		14:
			_trigger($Step14)
		15:
			_trigger($Step15)
		16: ## blank state for holding end graphic
			_sequenceState+=1


func _trigger(_target:Button): ## function progresses state, uses button state to play sound
	if _pastCursor != null: ## update tracking cursor if not null
		_pastCursor.visible = false
	
	
	_sequenceState+=1
	_target._highlight.visible = true
	_pastCursor = _target._highlight
	
	
	if _target._isTrig:
		_target._play()


func _process(_delta): ## listen for clock and reset every frame
	_clocking()
	
	if _sequenceState > 16: ## reset sequence at end
		_trigRefresh()
		_sequenceState = 0
		_sequencer()


func _trigRefresh(): ## reset trigger gfx
	for _s in _track1steps:
		_s._hasTriggered = false
		_s._highlight.visible = false


func _on_MasterClock_timeout(): ## continue sequencer if running on step end
	if _isPlaying:
		_sequencer()
	else:
		$MasterClock.stop()


func _on_PlayButton_pressed(): ## control playing logic (main loop)
	_trigRefresh()
	_sequenceState = 0
	
	if !_isPlaying:
		_sequencer()
		$MasterClock.start(_note)
	
	## toggle play state
	_isPlaying = !_isPlaying


	if _isPlaying: ## graphics update
		$PlayButton.icon = load("res://graphics/stop_icon.png")
	else:
		$PlayButton.icon = load("res://graphics/play_icon.png")
