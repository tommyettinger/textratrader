# MIT License
# Written in 2024 by Tommy Ettinger.

## Tools for 1D noise given a seed.
@tool
class_name NoiseUtils

## Gets continuous noise given a distance and seed.
##
## x is a 1D distance, and s is any int seed.
static func noise_1d(x: float, s: int) -> float:
	x += s * 5.9604644775390625E-8;
	var xFloor = int(x) if (x >= 0.0) else int(x) - 1
	
	var rise = 1 - ((int(x + x) if (x >= 0.0) else int(x + x) - 1) & 2);
	x -= xFloor;
	var h = ((s + xFloor ^ -7046029254386353131) * -3335678366873096957) * 1.734723475976807E-18
	x *= x - 1.0;
	return rise * x * x * h;

## Gets higher-quality continuous noise given a distance and seed.
##
## x is a 1D distance, and s is any int seed.
## This uses 2 calls to [method noise_1d] using different frequencies,
## which are called "octaves."
static func octave_noise_1d(x: float, s: int) -> float:
	return noise_1d(x, s) * 0.6666666666666666 + noise_1d(x * 1.9, s) * 0.3333333333333333;
