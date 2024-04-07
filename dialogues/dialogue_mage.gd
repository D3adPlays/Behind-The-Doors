extends CanvasLayer

var dialogue = [
	["Mage", "Bonjour aventurier"],
	["Mage", "Si tu es ici,"],
	["Mage", "Je suppose que tu veux savoir..."],
	["Mage", "CE QU'IL Y A DERRIRE LA PORTE"]
	];
	
func start():
	$NinePatchRect/Name.text = dialogue[0][0]
	$NinePatchRect/Chat.text = dialogue[0][1]
	
func _ready():
	start();
	$NinePatchRect.hide();
	
