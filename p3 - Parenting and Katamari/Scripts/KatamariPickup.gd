extends Node

@onready var win_counter_node : SimpleWinCounter = $"/root/Game/SimpleWinCounter"
@onready var collider : Area2D = $"Area2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Add ourselves to the counter
	win_counter_node.add_total_count()



func _on_area_2d_area_entered(area: Area2D) -> void:
	# If anything else touches us, we skip over them.
	if area.get_parent().name != "KatamariBall":
		# This skips the rest of the code.
		return
	
	# Tell the counter we've been picked up
	win_counter_node.add_current_count()
	
	# Kill the Area 2D so we don't get triggered again.
	collider.call_deferred("queue_free")
	
	# Reparent Person to the Katamari ball
	call_deferred("reparent", area.get_parent())
