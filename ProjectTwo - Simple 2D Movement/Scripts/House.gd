extends Sprite2D

@onready var area : Area2D = $Area2D
@onready var particle : GPUParticles2D = $GPUParticles2D
var game_state : GameState

func _ready() -> void:
	# Get a reference to our gamestate node
	game_state = get_tree().current_scene.get_node("GameState")
	
	var screen_size = get_viewport_rect().size
	self.global_position.x = randf_range(128,screen_size.x - 128)
	self.global_position.y = randf_range(128,screen_size.y - 128)

# Really hacky way of seeing if a player hit.
# This really should be done by checking if the thing that hit us
# is a part of a Player class, but I don't remember how to do that.
func _on_area_2d_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player":
		# Debug: Print out that we got the Player
		print("Player hit!")
		# Make smoke come out of the house
		particle.emitting = true
		# Delete the player so it looks like they went in
		area.get_parent().queue_free()
		# Tell the gamestate that we won!
		game_state.game_won_signal.emit()
