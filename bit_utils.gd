# MIT License
# Written in 2024 by Tommy Ettinger.

## Utility class to handle bitwise operations.
##
## Most operations here are meant to act how they do in other languages,
## such as Java and JavaScript, and not how their approximate counterparts
## do in Godot.
@tool
class_name BitUtils

## Arithmetic shift right.
##
## This is equivalent to the [code]>>[/code] operator in Java and JavaScript.
##
## n, the value to be shifted, is permitted to be negative; if so, its
## sign will be extended.
## amt, the amount to shift, will be masked to ensure it is between 0 and 63.
static func shr(n: int, amt: int) -> int:
	amt &= 63;
	@warning_ignore("integer_division")
	return ((n & 0x7FFF_FFFF_FFFF_FFFF) >> amt | -((n & -0x8000_0000_0000_0000) / (-1 << amt)))

## Unsigned (logical) shift right.
##
## This is equivalent to the [code]>>>[/code] operator in Java and JavaScript.
##
## n, the value to be shifted, is permitted to be negative; if so, its
## sign will not be extended.
## amt, the amount to shift, will be masked to ensure it is between 0 and 63.
static func ushr(n: int, amt: int) -> int:
	amt &= 63;
	@warning_ignore("integer_division")
	return ((n & 0x7FFF_FFFF_FFFF_FFFF) >> amt | (n & -0x8000_0000_0000_0000) / (-1 << amt))

## Bitwise left rotation.
##
## n, the value to be rotated, is permitted to be negative.
## amt, the amount to rotate, will be masked to ensure it is between 0 and 63.
static func rotl(n: int, amt: int) -> int:
	return n << (amt & 63) | BitUtils.ushr(n, 64 - amt)

## Bitwise right rotation.
##
## n, the value to be rotated, is permitted to be negative.
## amt, the amount to rotate, will be masked to ensure it is between 0 and 63.
static func rotr(n: int, amt: int) -> int:
	return n << (64 - amt & 63) | BitUtils.ushr(n, amt)

## Xorshift right.
##
## This is the same as [code]n ^ BitUtils.ushr(n, amt)[/code].
static func xsr(n: int, amt: int) -> int:
	return n ^ BitUtils.ushr(n, amt)

## Xorshift left.
##
## This is the same as [code]n ^ (n << amt)[/code], except that this masks
## amt so it is between 0 and 63.
static func xsl(n: int, amt: int) -> int:
	return n ^ (n << (amt & 63))
