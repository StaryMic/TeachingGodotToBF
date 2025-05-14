extends Node2D

# Node References
@onready var sprite : Sprite2D = $Sprite

# Values
# Movement speed is in Pixels per frame.
var movement_speed : float = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		self.global_position.x += -movement_speed
	if Input.is_action_pressed("ui_right"):
		self.global_position.x += movement_speed
	if Input.is_action_pressed("ui_up"):
		self.global_position.y += movement_speed
	if Input.is_action_pressed("ui_down"):
		self.global_position.y += -movement_speed
