extends Node

# Keeping track of if the player won or not
var game_won : bool = false

# These variables are holding objects (known as nodes in Godot)
# instead of values
# @onready makes the variable be filled by the value when the node is made.
# $ is a shortcut for referencing a node.
# In this case, this references our child nodes (Timer and Label)
@onready var timer = $Timer
@onready var label = $Label
@onready var progress_bar = $ProgressBar

# This sets up a signal, which can be used to run code on other nodes.
# Typically you want other nodes to connect to this event, but for this example
# I'm using this within this script for simplicity.
signal game_won_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect() connects signals to functions.
	# Think of this like plugging a cable into a computer then having it carry
	# something like a mouse button being clicked.
	var timeout_signal : Signal = Signal(timer, "timeout")
	timeout_signal.connect(on_timer_timeout)
	connect("game_won_signal", set_game_won)

# Called every frame.
func _process(delta: float) -> void:
	progress_bar.value = timer.time_left

func on_timer_timeout():
	if game_won:
		label.text = "You won!"
	else:
		label.text = "You lost. :("

func set_game_won():
	# This sets the Boolean "game_won" to true
	game_won = true
