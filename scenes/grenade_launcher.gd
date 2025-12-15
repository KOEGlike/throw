extends Node2D

const SNOWBALL = preload("uid://dfefqdoyqgw40")

@onready var spawn_point: Node2D = $SpawnPoint
@onready var sprite_2d: Sprite2D = $Sprite2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var instance:Snowball = SNOWBALL.instantiate();
		spawn_point.add_child(instance)
		instance.global_position = spawn_point.global_position
		instance.setup(-700, rotation)
	elif event is InputEventMouseMotion:
		var diff=self.get_global_transform_with_canvas().get_origin() - event.position
		self.rotation = atan2(diff.y, diff.x)
		sprite_2d.flip_v=abs(self.rotation)>PI/2
		
