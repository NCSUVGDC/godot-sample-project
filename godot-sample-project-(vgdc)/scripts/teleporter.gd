extends Area2D

# This teleporter is an Area2D, which uses collision layers but is intangible.

@export var target: Vector2

# Using the node tab of the right panel, we attach this built in signal.
# This signal is triggered when a body on an active layer of the collision 
# mask enters the CollisionShape2D.
func _on_body_entered(body):
	# update the global position of the body
	body.global_position = target
