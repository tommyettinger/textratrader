@tool
extends RichTextEffect
class_name RichTextTest

# Syntax: [test]Test[/test]

# Define the tag name.
var bbcode = "test"

# Arithmetic shift right.
static func ashr(n, amt):
	amt &= 63;
	return ((n & 0x7FFF_FFFF_FFFF_FFFF) >> amt | (n & ~0x7FFF_FFFF_FFFF_FFFF) / (1 << amt))

func _process_custom_fx(char_fx):
	char_fx.color = Color.ROYAL_BLUE if \
	 ashr(-7046029254386353131, 4) == -440376828399147071 else Color.RED
	return true