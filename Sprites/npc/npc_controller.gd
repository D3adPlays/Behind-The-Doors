extends Node2D

@onready var diagbox = %"Diag Box"
@onready var box_content: RichTextLabel = %Content
@onready var box_name: RichTextLabel = %Name

@export var npc_name: String;
@export var dialogues: Array[String];

var dialogue_progression: int = 0;

func _ready():
	diagbox.visible = false;
	box_name.text = npc_name;
	box_content.text = dialogues[0];
	
func _process(delta):
	if (Input.is_action_just_pressed("left_click") and diagbox.visible):
		change_dialogue();

func change_dialogue() -> void:
	if (dialogue_progression + 1 == dialogues.size()):
		diagbox.visible = false;
		box_content.text = dialogues[0];
		return;
	diagbox.visible = true;
	dialogue_progression += 1;
	box_content.text = dialogues[dialogue_progression];
	return;

func _on_dialogue_box_body_entered(body):
	box_content.text = dialogues[dialogue_progression];

func _on_dialogue_box_body_exited(body):
	diagbox.visible = false;
