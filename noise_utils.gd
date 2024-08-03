# MIT License
# Written in 2024 by Tommy Ettinger.

## Tools for 1D noise given a seed.
##
## Based on Quilez Basic Noise, [url]https://www.shadertoy.com/view/3sd3Rs[/url].
@tool
class_name NoiseUtils

## Gets continuous 1D noise given a distance and seed.
##
## x is a 1D distance, and s is any int seed.
## You could also use [method octave_noise_1d], which calls this more than once
## to obtain higher quality and less repetitive results.
static func noise_1d(x: float, s: int) -> float:
	x += s * 5.9604644775390625E-8;
	var xFloor = int(x) if (x >= 0.0) else int(x) - 1
	
	var rise = 1 - ((int(x + x) if (x >= 0.0) else int(x + x) - 1) & 2);
	x -= xFloor;
	var h = ((s + xFloor ^ -7046029254386353131) * -3335678366873096957) * 1.734723475976807E-18
	x *= x - 1.0;
	return rise * x * x * h;

## Gets higher-quality continuous 1D noise given a distance and seed.
##
## x is a 1D distance, and s is any int seed.
## This uses 1 or more calls to [method noise_1d] using different frequencies,
## and amplitudes which are called "octaves."
static func octave_noise_1d(x: float, s: int, octaves: int = 2) -> float:
	var noise = 0.0
	octaves = max(1, octaves)
	for n in range(octaves - 1, -1, -1):
		noise += noise_1d(x, s + n) * (1 << n);
		x *= 1.9
	return noise / ((1 << octaves) - 1.0)
