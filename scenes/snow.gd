extends AnimatedSprite2D

func _ready() -> void:
	Manager.new_wind_created.connect(update_rotation)
	update_rotation(Manager.wind_angle, Vector2(0,0))
	
func update_rotation(angle:float, _velocity:Vector2):
	self.rotation=angle + deg_to_rad(45 + 90)
	print("angle: ", rad_to_deg(rotation))
