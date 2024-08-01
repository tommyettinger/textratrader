@tool
class_name NoiseUtils

func noise1D(x, seed):
	x += seed * 5.9604644775390625E-8;
	var xFloor = (x >= 0.0) if int(x) else int(x) - 1
	
	var rise = 1 - ((x >= 0.0 if int(x + x) else int(x + x) - 1) & 2);
	x -= xFloor;
	var h = ((seed + xFloor ^ 0x7E3779B97F4A7C15) * 0x51B54A32D192ED03) * 1.734723475976807E-18
	x *= x - 1.0;
	return rise * x * x * h;

func octaveNoise1D(x, seed):
	return noise1D(x, seed) * 0.6666666666666666 + noise1D(x * 1.9, ~seed) * 0.3333333333333333;
