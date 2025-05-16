extends Area2D

# Vars
var clicked : bool = false
var shot : bool = false
var target_position : Vector2
var speed : float = 100.0

# Nodes
@export var sprite : Sprite2D
@export var gamestate : GameState
@export var line : Line2D
@export var ball_sound : AudioStreamPlayer

# NOTE: See how I can reference distance_to_target inside the if statement
# below the declaration.
# If I were to define the variable inside that statement, then I wouldn't
# be able to use it outside that scope.

func _process(delta: float) -> void:
	# Checking distance here to fix a glitch with my bad math.
	var distance_to_target = global_position.distance_squared_to(target_position)
	# If we have shot the ball, then move it to the target position
	if shot && distance_to_target >= 28.0:
		var direction_to_target = global_position.direction_to(target_position)
		# Some weird math to smoothly move the ball.
		var movement = direction_to_target * (log(distance_to_target) + PI) * speed
		# Move the ball
		global_position += movement * delta
		return
	
	# Click check happens in _on_input_event()
	if clicked:
		# Get the target position of the ball
		target_position = get_global_mouse_position()
		
		# Draw the line from the ball to the cursor
		line.visible = true
		line.points[1] = target_position - global_position
		
		# Check if we have let go of Left Click
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			clicked = false
			shot = true
			line.visible = false


func _input(event: InputEvent) -> void:
	# Do not allow the ball to be hit again
	if shot == true: return
	
	# Check for click
	if event is InputEventMouseButton:
		# This is called Casting.
		# An InputEvent is the base class that other events come from
		# InputEventMouseButton is an extension of InputEvent
		# Which lets you check what event type you got
		# and get specific information from an input.
		var mouse_event = event as InputEventMouseButton
		# If we press the left mouse button
		if mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed:
			# Then we are being dragged.
			clicked = true

func _on_area_entered(area: Area2D) -> void:
	if area.name == "GolfGoal":
		# Tell the game state we won
		gamestate.win_condition_met.emit()
		# Hide the ball
		visible = false
		# Play ball sound
		ball_sound.play()
		
