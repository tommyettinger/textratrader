@tool
extends RichTextEffect
class_name RichTextTest

const BitUtils = preload("res://bit_utils.gd")

# Syntax: [test]Test[/test]

# Define the tag name.
var bbcode = "test"

func _process_custom_fx(char_fx):
	char_fx.color = Color.ROYAL_BLUE if \
#	  BitUtils.shr(-7046029254386353131, 4) == -440376828399147071 \
	  BitUtils.ushr(-7046029254386353131, 4) == 712544676207699905 \
#	  BitUtils.shr(-7046029254386353131, 63) == -1 \
#	  BitUtils.ushr(-7046029254386353131, 63) == 1 \
	  else Color.RED
	return true
