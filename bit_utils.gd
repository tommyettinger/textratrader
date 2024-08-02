@tool
class_name BitUtils

# Arithmetic shift right.
static func shr(n, amt):
	amt &= 63;
	return ((n & 0x7FFF_FFFF_FFFF_FFFF) >> amt | -((n & -0x8000_0000_0000_0000) / (-1 << amt)))

# Unsigned (logical) shift right.
static func ushr(n, amt):
	amt &= 63;
	return ((n & 0x7FFF_FFFF_FFFF_FFFF) >> amt | (n & -0x8000_0000_0000_0000) / (-1 << amt))
