extends CharacterBody2D

@export var MAX_SPEED = 800;
@export var ACCELERATION = 300;
@export var FRICTION = 1200;

@onready var axis = Vector2.ZERO

@onready var box_name = $"../DialogueZone/CanvasLayer/NinePatchRect/Name"
@onready var box_chat = $"../DialogueZone/CanvasLayer/NinePatchRect/Chat"
@onready var diag_box = $"../DialogueZone/CanvasLayer/NinePatchRect"
	
var dialogue = [
	["Mage", "Bonjour aventurier"],
	["Mage", "Si tu es ici,"],
	["Mage", "Je suppose que tu veux savoir..."],
	["Mage", "CE QU'IL Y A DERRIRE LA PORTE !!!"],
	["Mage", "..."]];
var not_first = false;
var text_box = false;
	
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
	
func move():
	axis = get_input_axis();
	apply_movement();
	move_and_slide();
	apply_friction();
	
func _physics_process(delta):
	move()
	change_dialogue()

func find_in_dialogue(str):
	for i in range(dialogue.size()):
		var index = dialogue[i].find(box_chat.text);
		if (index != -1):
			return i;
	return -1;

func change_dialogue():
	if (Input.is_action_just_pressed("left_click") and text_box):
		var index = find_in_dialogue(box_chat.text);
		if (index != -1):
			if (index + 1 < dialogue.size()):
				box_name.text = dialogue[index + 1][0];
				box_chat.text = dialogue[index + 1][1];
			else:
				box_name.text = dialogue[0][0];
				box_chat.text = dialogue[0][1];

func _on_area_2d_body_entered(body):
	if (not_first):
		diag_box.show()
		box_name.text = dialogue[0][0];
		box_chat.text = dialogue[0][1];
		text_box = true;
	else:
		not_first = true;

func _on_area_2d_body_exited(body):
	diag_box.hide();
	text_box = false;
