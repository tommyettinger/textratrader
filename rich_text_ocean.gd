@tool
extends RichTextEffect
class_name RichTextOcean

const noise = preload("res://noise_utils.gd")

# Syntax: [ocean speed=2 span=40.0 hue=0.14 sat=1.0 val=0.7 seed=0]Ocean[/ocean]

# Define the tag name.
var bbcode = "ocean"

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var speed = char_fx.env.get("speed", 1.0) * 0.25
	var span = char_fx.env.get("span", 40.0)
	var hue = char_fx.env.get("hue", 0.5)
	var sat = char_fx.env.get("sat", 0.8)
	var val = char_fx.env.get("val", 0.25)
	var noise_seed = char_fx.env.get("seed", hash(char_fx))
	
	var progress = speed * char_fx.elapsed_time + (char_fx.range.x / float(span))
	
	char_fx.color = Color.from_ok_hsl(noise.octave_noise_1d(progress * 2.5, noise_seed ^ 123456) * 0.1 + hue, \
	 sat, 0.15 - absf(noise.octave_noise_1d(progress * 1.6 + cos(progress), noise_seed ^ -123456789, 3)) * 0.3 + val, char_fx.color.a)
	return true
