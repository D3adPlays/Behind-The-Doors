extends CharacterBody2D

@export var ACCELERATION = 400;
@export var FRICTION = 1200;

@onready var axis = Vector2.ZERO


@onready var box_name = $"../DialogueZone/CanvasLayer/NinePatchRect/Name"
@onready var box_chat = $"../DialogueZone/CanvasLayer/NinePatchRect/Chat"
@onready var diag_box = $"../DialogueZone/CanvasLayer/NinePatchRect"
@onready var animated_sprite = %AnimatedSprite

var dialogue = [
	["Mage", "Bonjour aventurier"],
	["Mage", "Si tu es ici,"],
	["Mage", "Je suppose que tu veux savoir..."],
	["Mage", "CE QU'IL Y A DERRIRE LA PORTE !!!"],
	["Mage", "..."]];
var not_first = false;
var text_box = false;
var lastdir: int = 0;
	
func get_input_axis():
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized();
	
func get_sign():
	var velocity_sign = Vector2.ZERO;	if (velocity.x > 0):
		velocity_sign.x = 1;
	else:
		velocity.x = -1;
	if (velocity.y > 0):
		velocity_sign.y = 1;
	else:
		velocity.y = -1;
	return velocity_sign;

func apply_friction():
	var velocity_sign = get_sign(); 
	
	if (abs(velocity.x) > 200):
		velocity.x = 100 * velocity_sign.x;
	else:
		velocity.x = 0;
	if (abs(velocity.y) > 200):
		velocity.y = 100 * velocity_sign.y;
	else:
		velocity.y = 0;
	
func apply_movement():
	velocity.x += axis.x * ACCELERATION;
	velocity.y += axis.y * ACCELERATION;
	if (velocity.x != 0 || velocity.y != 0):
		animated_sprite.play("walking");
	else:
		animated_sprite.play("default");
	if velocity.x < 0 && lastdir == 0:
		animated_sprite.scale.x *= -1
		lastdir = 1;
	elif velocity.x > 0 && lastdir == 1:
		animated_sprite.scale.x *= -1;
		lastdir = 0;


func move():
	axis = get_input_axis();
	apply_movement();
	move_and_slide();
	apply_friction();
	
func _physics_process(delta):
	move()
