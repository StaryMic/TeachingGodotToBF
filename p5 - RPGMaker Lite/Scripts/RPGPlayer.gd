extends Area2D

# Nodes
@onready var move_timer : Timer = $MovementTimer
@onready var ray : RayCast2D = $RayCast2D
@export var game_state : GameState

# Values
var can_walk : bool = true # Reset by the timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Allow movement again once some time has passed
	move_timer.timeout.connect(_reset_walk)
	

func _reset_walk():
	can_walk = true
	
func do_walk_cooldown():
	can_walk = false
	move_timer.start(0.1)
	
# The -> tells the engine what value will be returned.
# When you set up a function like this, it HAS to return a value of that type.
func check_for_walls(direction : Vector2) -> bool:
	ray.target_position = direction
	ray.force_raycast_update()
	return ray.is_colliding()

func do_movement(direction : Vector2):
	global_position += direction
	do_walk_cooldown()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If the movement cooldown is active, then skip this frame
	if !can_walk: return
	
	var horizontal = Input.get_axis("ui_left","ui_right")
	var vertical = Input.get_axis("ui_up","ui_down")
	
	# Prioritize Vertical movement over Horizontal movement
	# Basing the movement off of Pokemon for this.
	if vertical != 0:
		var dir = Vector2(0, 32 * vertical)
		# Check for collision in the direction we are moving.
		if check_for_walls(dir):
			# We hit a wall. Do nothing.
			return
		else:
			# We did NOT hit a wall. Move in that direction.
			do_movement(dir)
			return

	if horizontal != 0:
		var dir = Vector2(32 * horizontal, 0)
		# Check for collision in the direction we are moving.
		if check_for_walls(dir):
			# We hit a wall. Do nothing.
			return
		else:
			# We did NOT hit a wall. Move in that direction.
			do_movement(dir)
			return




func _on_special_body_entered(body: Node2D) -> void:
	# We have won!
	game_state.win_condition_met.emit()
	queue_free()
