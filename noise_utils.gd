@tool
class_name NoiseUtils

static func noise1D(x, s):
	x += s * 5.9604644775390625E-8;
	var xFloor = int(x) if (x >= 0.0) else int(x) - 1
	
	var rise = 1 - ((int(x + x) if (x >= 0.0) else int(x + x) - 1) & 2);
	x -= xFloor;
	var h = ((s + xFloor ^ -7046029254386353131) * -3335678366873096957) * 1.734723475976807E-18
	x *= x - 1.0;
	return rise * x * x * h;

static func octaveNoise1D(x, s):
	return noise1D(x, s) * 0.6666666666666666 + noise1D(x * 1.9, s) * 0.3333333333333333;
