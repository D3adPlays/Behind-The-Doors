extends Node2D

@onready var main = get_tree().root;
@onready var projectile = load("res://scenes/bullet.tscn");
@onready var player = $".";

func get_gun_rotation():
	var mouse_pos = get_viewport().get_mouse_position();
	var u: Vector2 = Vector2(0, 1).normalized();
	var v: Vector2 = Vector2(player.global_position.x - mouse_pos.x, player.global_position.y - mouse_pos.y).normalized()
	var u_norm = sqrt((u.x ** 2) + (u.y ** 2));
	var v_norm = sqrt((v.x ** 2) + (v.y ** 2));
	var scalaire = (u.x * v.x) + (u.y * v.y);
	
	rotation_degrees = acos(scalaire / (u_norm * v_norm)) * (180 / PI);
	if (mouse_pos.x - player.global_position.x < 0):
		rotation_degrees *= -1;
		if ($gun_sprite.scale.y < 0):
			$gun_sprite.scale.y *= -1;
	

func shoot():
	var instance = projectile.instantiate();
	
	instance.dir = rotation;
	instance.spawnPos = $gun_sprite/Marker2D.global_position;
	instance.spawnRot = global_rotation;
	main.add_child.call_deferred(instance);

func _on_timer_timeout():
	get_gun_rotation();
	shoot();
