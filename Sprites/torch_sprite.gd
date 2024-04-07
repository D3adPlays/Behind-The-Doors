extends Node2D

@export var noise_texture: NoiseTexture2D;
@onready var glow: PointLight2D = $Glow;
var noise: Noise;
var last_time: float = 0.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	last_time += delta;
	noise = noise_texture.noise
	glow.texture_scale = 2 + (noise.get_noise_2d(0, last_time * 10) * 2);
	glow.energy = 1 + noise.get_noise_2d(0, last_time * -10);
	pass
