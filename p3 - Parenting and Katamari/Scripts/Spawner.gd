# @tool allows code to be ran within Godot's editor.
# This is useful for making your own tools for speeding up
# development, but doing certain things can be risky.
# See the documentation for @tool for more info.
@tool
extends Node

# Values
var random_amount : int

# Export Vars
@export var person_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Do NOT run code when we are in the editor.
	# Just preventing weird shit.
	if Engine.is_editor_hint():
		return
		
	# Get a random amount of people to spawn
	random_amount = randi_range(4,8)
	
	# Make that amount of people
	# The -1 is there to make sure we actually get between 4-8 and not 5-9
	# because computers count from 0
	for i in random_amount - 1:
		# Make an instance of the person
		var person_node = person_scene.instantiate() as Sprite2D
		
		# Get the size of the active screen
		var screen_size = get_viewport().get_window().size
		# Randomize the position
		var rand_position : Vector2 = Vector2(randf_range(128,screen_size.x - 128) , randf_range(128,screen_size.y - 128))
		# Set the person's position
		person_node.position = rand_position
		
		# Add the Person to the scene
		add_child(person_node)

# This allows a developer to set up custom warnings
# This can be used for things like reminders when a value isn't set,
# putting a node in the wrong place, etc.
# In this case I'm using it to give you a hint!

# NOTE: Warnings only update when a scene is reloaded (closing and reopening the tab)
func _get_configuration_warnings() -> PackedStringArray:
	if person_scene == null:
		return ["Person Scene has no scene set!"]
	return []
