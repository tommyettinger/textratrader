# MIT License
# Written in 2024 by Tommy Ettinger.

## Tools for 1D noise given a seed.
##
## Based on Quilez Basic Noise, [url]https://www.shadertoy.com/view/3sd3Rs[/url].
@tool
class_name NoiseUtils

## Gets continuous 1D noise given a distance and seed; has obviously-symmetrical sections.
##
## Based on Quilez Basic Noise, [url]https://www.shadertoy.com/view/3sd3Rs[/url].
##
## x is a 1D distance, and s is any int seed.
## You could also use [method octave_noise_1d], which calls this more than once
## to obtain higher quality and less repetitive results.
static func noise_1d(x: float, s: int) -> float:
    x += s * 5.9604644775390625E-8;
    var xFloor = floori(x)
    
    var rise = 1 - ((int(x + x) if (x >= 0.0) else int(x + x) - 1) & 2);
    x -= xFloor;
    var h = ((s + xFloor ^ -7046029254386353131) * -3335678366873096957) * 1.734723475976807E-18
    x *= x - 1.0;
    return rise * x * x * h;

## Gets higher-quality continuous 1D noise given a distance and seed, using [method noise_1d].
##
## Based on Quilez Basic Noise, [url]https://www.shadertoy.com/view/3sd3Rs[/url].
##
## x is a 1D distance, and s is any int seed.
## This uses 1 or more calls to [method noise_1d] using different frequencies,
## and amplitudes which are called "octaves."
static func octave_noise_1d(x: float, s: int, octaves: int = 2) -> float:
    var noise = 0.0
    octaves = max(1, octaves)
    for n in range(octaves - 1, -1, -1):
        noise += noise_1d(x, s + n) * (1 << n);
        x = (x + 1.618) * 1.9
    return noise / ((1 << octaves) - 1.0)

## Gets continuous 1D noise given a distance and seed; very smooth.
##
## Sway smoothly using bicubic interpolation between 4 points (the two integers before t and the two after).
## This pretty much never produces steep changes between peaks and valleys; this may make it more useful for things
## like generating terrain that can be walked across in a side-scrolling game.
##
## t is the distance traveled; should change by less than 1 between calls, and should be less than about 10000 .
## s is the seed, and can be any int, but it should be randomized somehow when you want a different curve.
## Returns a smoothly-interpolated swaying value between -1 and 1, both exclusive.
static func wobble(t: float, s: int) -> float:
    var i: int = floori(t)
    # what we add here ensures that at the very least, the upper half will have some non-zero bits.
    s += i;
    # to avoid frequent multiplication and replace it with addition by constants, we track 3 variables, each of
    # which updates with a different large, negative long increment. when we want to get a result, we just XOR
    # m, n, and o, and use only the upper bits (by multiplying by a tiny fraction).
    var m: int = s * -3335678366873096957
    var n: int = s * -6068174398545744893
    var o: int = s * -8306560040656073257

    var a: float = (m ^ n ^ o)
    var b: float = (m - 3335678366873096957 ^ n - 6068174398545744893 ^ o - 8306560040656073257)
    var c: float = (m - 6671356733746193914 ^ n + 6310395276618061830 ^ o + 1833623992397405102)
    var d: float = (m + 8439708973090260745 ^ n + 242220878072316937  ^ o - 6472936048258668155)

    # get the fractional part of t.
    t -= i
    # this is bicubic interpolation, inlined
    var p = (d - c) - (a - b);
    # 7.7.228014483236334E-20 , or 0x1.5555555555428p-64 , is just inside {@code -2f/3f/Long.MIN_VALUE} .
    # it gets us about as close as we can go to 1.0 .
    return (t * (t * t * p + t * (a - b - p) + c - a) + b) * 7.228014E-20

## Gets higher-quality continuous 1D noise given a distance and seed, using [method wobble].
##
## x is a 1D distance, and s is any int seed.
## This uses 1 or more calls to [method noise_1d] using different frequencies,
## and amplitudes which are called "octaves."
static func octave_wobble(x: float, s: int, octaves: int = 2) -> float:
    var noise = 0.0
    octaves = max(1, octaves)
    for n in range(octaves - 1, -1, -1):
        noise += noise_1d(x, s) * (1 << n);
        x = (x + 1.618) * 1.9
        # golden ratio stuff
        s -= 7046029254386353131
    return noise / ((1 << octaves) - 1.0)
