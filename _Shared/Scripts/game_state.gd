# This defines a Class.
# A class is an object that can be instanced (aka there can be multiple)
# In this case, it is being used to allow for me to search for this node
# and access it in other scripts without hacky workarounds.
class_name GameState extends Node

# Keeping track of if the player won or not
var game_won : bool = false

# Variables for names and timers
@export_group("Settings")
@export var time : float = 5.0
@export var can_be_won_early : bool = true
@export_group("Audio")
@export var win_sound : AudioStreamWAV
@export var lose_sound : AudioStreamWAV
@export_group("Text")
@export var hint_text : String = "HINT NOT SET"
@export var win_text : String = "WIN TEXT NOT SET"

# These variables are holding objects (known as nodes in Godot)
# instead of values
# @onready makes the variable be filled by the value when the node is made.
# $ is a shortcut for referencing a node.
# In this case, this references our child nodes (Timer and Label)
@onready var timer = $Timer
@onready var label = $Label
@onready var progress_bar = $ProgressBar
@onready var win_label = $RichTextLabel
@onready var win_audio_player = $WinAudio
@onready var lose_audio_player = $LostAudio

# This sets up a signal, which can be used to run code on other nodes.
# Typically you want other nodes to connect to this event, but for this example
# I'm using this within this script for simplicity.
signal win_condition_met

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set up nodes
	label.text = hint_text
	timer.start(time)
	progress_bar.max_value = time
	win_label.text = win_text
	win_audio_player.stream = win_sound
	lose_audio_player.stream = lose_sound
	
	# connect() connects signals to functions.
	# Think of this like plugging a cable into a computer then having it carry
	# something like a mouse button being clicked.
	var timeout_signal : Signal = Signal(timer, "timeout")
	timeout_signal.connect(on_timer_timeout)
	connect("win_condition_met", condition_met)

# Called every frame.
func _process(delta: float) -> void:
	# Update the progress bar
	progress_bar.value = timer.time_left

func on_timer_timeout():
	# Check if the player has won
	check_if_won()

func condition_met():
	game_won = true
	
	if !can_be_won_early:
		return # Wait for the timer to elapse
	
	# If the game can be completed early
	# Pause the timer
	timer.paused = true
	check_if_won()

func check_if_won():
	if game_won:
		win_label.visible = true
		win_audio_player.play()
		return
	# If the player did NOT win
	else:
		lose_audio_player.play()
		label.text = "You lost :("
		return
