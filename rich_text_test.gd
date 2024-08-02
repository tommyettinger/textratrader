@tool
extends RichTextEffect
class_name RichTextTest

# Syntax: [test]Test[/test]

# Define the tag name.
var bbcode = "test"

# Arithmetic shift right.
static func shr(n, amt):
	amt &= 63;
	return ((n & 0x7FFF_FFFF_FFFF_FFFF) >> amt | -((n & -0x8000_0000_0000_0000) / (-1 << amt)))

# Unsigned (logical) shift right.
static func ushr(n, amt):
	amt &= 63;
	return ((n & 0x7FFF_FFFF_FFFF_FFFF) >> amt | (n & -0x8000_0000_0000_0000) / (-1 << amt))
	
func _process_custom_fx(char_fx):
	char_fx.color = Color.ROYAL_BLUE if \
#	  RichTextTest.shr(-7046029254386353131, 4) == -440376828399147071 \
	  RichTextTest.ushr(-7046029254386353131, 4) == 712544676207699905 \
#	  RichTextTest.shr(-7046029254386353131, 63) == -1 \
#	  RichTextTest.ushr(-7046029254386353131, 63) == 1 \
	  else Color.RED
	return true
