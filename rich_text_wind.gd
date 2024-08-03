@tool
extends RichTextEffect
class_name RichTextWind

const noise = preload("res://noise_utils.gd")

# Syntax: [wind x=0.8 y=1.5 spacing=1.0 intensity=1.4 flag=false seed=0]Wind[/wind]

# Define the tag name.
var bbcode = "wind"

# Gets TextServer for retrieving font information.
func _get_text_server():
	return TextServerManager.get_primary_interface()

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var x_distance = char_fx.env.get("x", 1.5)
	var y_distance = char_fx.env.get("y", 1.5)
	var span = 20
	var spacing = char_fx.env.get("spacing", 1.0)
	var intensity = char_fx.env.get("intensity", 1.4)
	var flag = char_fx.env.get("flag", true)
	var noise_seed = char_fx.env.get("seed", hash(char_fx))
	
	var progress = (spacing * char_fx.range.x / float(span))
	var time = intensity * char_fx.elapsed_time
	var dim = Vector2i(1.5, 1.5)
	dim = _get_text_server().font_get_glyph_size(char_fx.font, dim, char_fx.glyph_index)
	char_fx.offset.x = noise.octave_noise_1d(time * x_distance + progress, noise_seed ^ 123456) * dim.x
	if(flag): char_fx.offset.x = absf(char_fx.offset.x) * sign(x_distance)
	char_fx.offset.y = noise.octave_noise_1d(time * y_distance + progress + 1.618, noise_seed ^ -123456789) * dim.y
	return true
