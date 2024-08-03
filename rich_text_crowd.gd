@tool
extends RichTextEffect
class_name RichTextCrowd

const noise = preload("res://noise_utils.gd")

# Syntax: [crowd intensity=0.25 speed=2 span=40.0 seed=0]Crowd[/crowd]

# Define the tag name.
var bbcode = "crowd"

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var speed = char_fx.env.get("speed", 1.0)
	var span = char_fx.env.get("span", 40.0)
	var intensity = char_fx.env.get("intensity", 0.25)
	var noise_seed: int = char_fx.env.get("seed", hash(char_fx))
	
	var progress = speed * char_fx.elapsed_time + (char_fx.range.x / float(span))
	char_fx.transform = char_fx.transform.rotated_local(noise.octave_noise_1d(progress, noise_seed + char_fx.relative_index ^ char_fx.glyph_index) * intensity)
	return true
