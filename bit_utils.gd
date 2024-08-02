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

# Bitwise left rotation.
static func rotl(n, amt):
	amt &= 63;
	return n << amt | ((n & 0x7FFF_FFFF_FFFF_FFFF) >> 64 - amt | (n & -0x8000_0000_0000_0000) / (-1 << 64 - amt))

# Bitwise right rotation.
static func rotr(n, amt):
	amt &= 63;
	return n << 64 - amt | ((n & 0x7FFF_FFFF_FFFF_FFFF) >> amt | (n & -0x8000_0000_0000_0000) / (-1 << amt))

# Xorshift right.
static func xsr(n, amt):
	amt &= 63;
	return n ^ ((n & 0x7FFF_FFFF_FFFF_FFFF) >> amt | (n & -0x8000_0000_0000_0000) / (-1 << amt))

# Xorshift left.
static func xsl(n, amt):
	return n ^ (n << (amt & 63))
