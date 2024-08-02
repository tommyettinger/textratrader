@tool
extends RichTextEffect
class_name RichTextOcean

# Syntax: [ocean speed=2 hue=0.14 sat=1.0 val=0.7]Ocean[/ocean]

# Define the tag name.
var bbcode = "ocean"

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var speed = char_fx.env.get("speed", 1.0) * 0.25
	var span = char_fx.env.get("span", 40.0)
	var hue = char_fx.env.get("hue", 0.5)
	var sat = char_fx.env.get("sat", 0.8)
	var val = char_fx.env.get("val", 0.25)
	
	var progress = speed * char_fx.elapsed_time + (char_fx.range.x / float(span))

# ColorUtils.hsl2rgb(NoiseUtils.octaveNoise1D(progress * 5f, 12345) * 0.15f + hue, saturation,
#                         0.15f - Math.abs(NoiseUtils.noise1D(progress * 3f + progress * progress, -123456789)) * 0.3f + lightness, 1f)
	char_fx.color = Color.from_ok_hsl(NoiseUtils.octaveNoise1D(progress * 1.5, 12345) * 0.1 + hue, \
	 sat, 0.15 - absf(NoiseUtils.octaveNoise1D(progress * 1.6 + sin(progress), -123456789)) * 0.3 + val, char_fx.color.a)
	return true
