extends Node2D

@onready var fade_transiton = $FadeTransiton
@onready var follower = $Background/Follower

# Called when the node enters the scene tree for the first time.
func _ready():
	fade_transiton.play("Fade_In");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follower.global_position = get_global_mouse_position();
	pass


func _on_quitter_pressed() -> void:
	get_tree().quit(0);
	pass # Replace with function body.

func _on_options_pressed() -> void:
	print("Opening options...");
	pass # Replace with function body.

