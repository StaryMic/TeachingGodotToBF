# This tells the game engine which class we're extending.
# Because this is a 2D element, we want to extend Node2D
# because that provides all the properties we want for this
# including position information.
extends Node2D

# This line of code adds a variable (a place where a value is held)
# Makes it a boolear (Which only holds True and False)
# And sets it to be false by default.
var clicked : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if clicked:
		# This seems to make it go the wrong direction??
		# also it's too slow :(
		self.global_position += Vector2(-150,0) * delta


func _on_click(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# I can't figure out why this is broken. Help me please!
	if event.is_pressed():
		print("Duck clicked")
		clicked = false
