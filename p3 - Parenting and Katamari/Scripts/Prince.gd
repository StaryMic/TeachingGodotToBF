extends Sprite2D

# Values
var speed : float = 400

# Node References
@onready var sprite_ball : Sprite2D = $KatamariBall

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# CALCULATE MOVEMENT
	# Get a vector from our inputs
	var movement_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Scale the vector by our speed and make sure it is framerate-independant
	var movement = (movement_dir * speed) * delta
	
	# Rotate the katamari ball
	sprite_ball.rotation += (deg_to_rad(200) * sign(movement_dir.x)) * delta
	
	# Switch the katamari side and prince facing direction
	if(movement_dir.x > 0):
		# Facing right
		sprite_ball.position = Vector2(50,0)
		self.flip_h = false
	else:
		sprite_ball.position = Vector2(-50,0)
		self.flip_h = true
		
	## APPLY MOVEMENT
	global_position += movement
