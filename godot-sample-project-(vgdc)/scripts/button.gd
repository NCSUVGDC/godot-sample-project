extends Area2D

var button_ready = false

func _process(_delta):
	if button_ready and Input.is_action_just_pressed("interact"):
		Globals.create_block.emit()

func _on_body_entered(body):
	button_ready = true
	$ButtonPrompt.visible = true

func _on_body_exited(body):
	button_ready = false
	$ButtonPrompt.visible = false
