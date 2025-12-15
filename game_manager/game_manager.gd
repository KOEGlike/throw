extends Node

class_name GameManager

@onready var timer:Timer=Timer.new()

var wind_velocity:Vector2
var wind_angle:float

signal new_wind_created(angle:float, velocity:Vector2)

func _ready() -> void:
	add_child(timer)
	timer.wait_time=10
	timer.timeout.connect(new_wind)
	timer.autostart=true
	timer.start(timer.wait_time)
	new_wind()
	
func new_wind():
	wind_angle=randf_range(-PI, PI);
	wind_velocity=Vector2.from_angle(wind_angle) * 20
	new_wind_created.emit(wind_angle, wind_velocity)
	print("new wind:",wind_velocity)
