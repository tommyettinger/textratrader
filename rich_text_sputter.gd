@tool
extends RichTextEffect
class_name RichTextSputter

const noise = preload("res://noise_utils.gd")

# Syntax: [sputter x=0.25 y=0.25 span=20 speed=3 seed=0]Sputter[/sputter]

# Define the tag name.
var bbcode = "sputter"

# Gets TextServer for retrieving font information.
func _get_text_server():
	return TextServerManager.get_primary_interface()

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var x_scale = char_fx.env.get("x", 0.25)
	var y_scale = char_fx.env.get("y", 0.25)
	var span = char_fx.env.get("span", 20)
	var speed = char_fx.env.get("speed", 3.0)
	var noise_seed: int = char_fx.env.get("seed", hash(char_fx))
	
	var progress = (char_fx.range.x / float(span))
	var time = speed * char_fx.elapsed_time + progress
	var dim = Vector2i(1, 1)
	dim = _get_text_server().font_get_glyph_size(char_fx.font, dim, char_fx.glyph_index)
	var h = noise.octave_noise_1d(time, noise_seed + char_fx.relative_index ^ char_fx.glyph_index + 123456)
	var v = noise.octave_noise_1d(time + 1.618, noise_seed + char_fx.relative_index ^ char_fx.glyph_index + -123456789)
	char_fx.transform = char_fx.transform.scaled_local(Vector2( \
		h * h * h * x_scale * 1.25 - v * 0.125 + 0.25, \
		v * v * v * y_scale * 1.25 - h * 0.125 + 0.25) * dim)
	return true
