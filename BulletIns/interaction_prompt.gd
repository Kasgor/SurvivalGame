extends Bulletin

var prompt_text:=""

func initialize(prompt):
	if prompt is String:
		prompt_text = prompt


func _ready():
	$Label.text =prompt_text
