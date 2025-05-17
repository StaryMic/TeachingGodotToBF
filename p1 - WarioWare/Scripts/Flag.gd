extends Node2D

# Area2D is a type of collision node.
# It does not block movement or push other objects.
# Area2D keeps track of anything that enters it and fires signals to let the
# user know what is inside of it, so devs can do stuff with whatever entered the
# area
@onready var collision_area : Area2D = $CollisionArea
@onready var confetti : GPUParticles2D = $GPUParticles2D

# TODO: What does null mean? Please fix it!
@onready var audio : AudioStreamPlayer = $AudioStreamPlayer

# The base class for this node is Node, which is the lowest object type you can have
# in the scene tree.
# Export gives you the ability to expose your values and nodes through the Inspector
# panel (to the right). This is nice for quickly connecting nodes and editing values
# outside of scripts.
@export var game_state_node : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# When we win, we want to call the on_win() function.
	# BUG: Not sure if this signal name is right :/
	game_state_node.connect("win_condition_unmet", on_win)

func on_win():
	audio.play()
	confetti.emitting = true

func _on_collision_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Duck":
		var game_win_signal = Signal(game_state_node,"win_condition_unmet")
		game_win_signal.emit()
