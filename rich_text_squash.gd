@tool
extends RichTextEffect
class_name RichTextSquash

# Syntax: [squash span=20 speed=3 elastic=false]Squash[/squash]

# Define the tag name.
var bbcode = "squash"

# Gets TextServer for retrieving font information.
func _get_text_server():
	return TextServerManager.get_primary_interface()

func _swingOut(a: float, scale: float = 2.0):
	a -= 1.0
	return ((scale + 1.0) * a + scale) * a * a + 1.0

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var span = char_fx.env.get("span", 20)
	var speed = char_fx.env.get("speed", 3.0)
	var elastic: bool = char_fx.env.get("elastic", false)
	if(elastic): span *= 3.0
	var progress = (char_fx.range.x / float(span))
	var time = speed * char_fx.elapsed_time - progress
	var dim = Vector2i(1, 1)
	dim = _get_text_server().font_get_glyph_size(char_fx.font, dim, char_fx.glyph_index)
	if(time < 0.0): 
		char_fx.visible = false
	elif (time >= 1.0):
		char_fx.visible = true
	elif (time < 0.4):
		char_fx.visible = true
		var iv = 1.0 - pow(sin(progress * 1.25 * PI), 2.0) * 0.5
		char_fx.transform = char_fx.transform.translated_local(dim * Vector2(0.125 - 0.125 * iv, (iv - 1.0) * 0.5))
		char_fx.transform = char_fx.transform.scaled_local(dim * Vector2(1.0 - iv, iv - 1.0))
	else:
		char_fx.visible = true
		var iv = (progress - 0.4) * 1.666
		if(elastic):
			iv = _swingOut(iv) * 0.5 + 0.5
		else:
			iv = pow(sin(progress * 0.5 * PI), 2.0) * 0.5 + 0.5
		char_fx.transform = char_fx.transform.translated_local(dim * Vector2(0.125 - 0.125 * iv, (iv - 1.0) * 0.5))
		char_fx.transform = char_fx.transform.scaled_local(dim * Vector2(1.0 - iv, iv - 1.0))
	return true
