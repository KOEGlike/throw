extends Area2D

class_name Snowball

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var throwable: Throwable = $Throwable
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

func _on_body_entered(body: Node2D) -> void:
	sprite_2d.visible=false
	cpu_particles_2d.restart()
	
func setup(speed:float, angle:float) -> void:
	throwable.velocity= Vector2.from_angle(angle) * speed


func _on_cpu_particles_2d_finished() -> void:
	self.queue_free()
