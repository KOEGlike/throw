extends Area2D

class_name Snowball

@onready var throwable: Throwable = $Throwable

func _on_body_entered(body: Node2D) -> void:
	self.queue_free()
	
func setup(speed:float, angle:float) -> void:
	throwable.velocity= Vector2.from_angle(angle) * speed
