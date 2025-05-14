class_name SimpleWinCounter extends Node

# Values
var current_amount : int = 0
var total_amount : int = 0

# Node References
@onready var game_state : Node = $"../GameState"

# Called when the node enters the scene tree for the first time.
func on_count_updated():
	# If the counter updates then check conditions.
	# Account for accidental moments where current > total
	if current_amount >= total_amount && total_amount != 0:
		game_state.emit_signal("game_winner_signal")

func add_total_count():
	# Used for setup. This shouldn't trigger an update.
	total_amount += 1

func add_current_count():
	current_amount += 1
	on_count_updated()
