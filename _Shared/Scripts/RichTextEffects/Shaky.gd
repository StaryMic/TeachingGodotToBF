@tool
# Having a class name is handy for picking the effect in the Inspector.
class_name RichTextShaky
extends RichTextEffect


# To use this effect:
# - Enable BBCode on a RichTextLabel.
# - Register this effect on the label.
var bbcode := "shaky"


func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var time_scaled : float = char_fx.elapsed_time * 15
	var character_offset = time_scaled + char_fx.relative_index
	var char_offset : Vector2 = Vector2(sin(character_offset - 0.5), cos(character_offset - 0.5))

	char_fx.offset = char_offset
	return true
