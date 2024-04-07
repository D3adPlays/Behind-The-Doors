extends Node2D

@export var noise_texture: NoiseTexture2D;
@onready var glow: PointLight2D = $Glow;
var noise: Noise;
var last_time: float = 0.0;
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("default");
	pass

func _process(delta: float):
	last_time += delta;
	noise = noise_texture.noise
	glow.texture_scale = 2 + (noise.get_noise_2d(0, last_time * 10) * 2);
	glow.energy = 1 + noise.get_noise_2d(0, last_time * -10);
	pass
