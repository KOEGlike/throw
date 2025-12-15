extends Node

class_name Throwable

@export var node:Node2D

@export_category("Params")
@export var velocity: Vector2=Vector2(0,0)
@export var mass: float=10
@export var cross_section_area:float=1
@export var air_density:float=1.2
@export var drag_coefficient:float=1

@onready var k:float=((cross_section_area * air_density * drag_coefficient)/mass)/2
var g=-ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var state:State=State.new(node.position, velocity)

class State:
	var position:Vector2
	var velocity:Vector2
	
	func _init(position:Vector2, velocity:Vector2) -> void:
		self.position=position
		self.velocity=velocity
		
	func add(other: State) -> State:
		return State.new(self.position + other.position, self.velocity + other.velocity)
	

class StateDerived:
	var velocity:Vector2
	var acceleration:Vector2
	
	func _init(velocity:Vector2, acceleration:Vector2) -> void:
		self.velocity=velocity
		self.acceleration=acceleration
	
	func multipl_by_time(time: float) -> State:
		return State.new(time * velocity, time * acceleration)
		
	func multipl_by_scalar(s: float) -> StateDerived:
		return StateDerived.new(s * velocity, s * acceleration)
	
	func add(other: StateDerived) -> StateDerived:
		return StateDerived.new(self.velocity + other.velocity, self.acceleration + other.acceleration)

func derivation_function(state:State) -> StateDerived:
	var acceleration:Vector2=Vector2()
	acceleration = -k * state.velocity.length() * state.velocity
	acceleration.y -= g
	return StateDerived.new(state.velocity, acceleration)
	
func rk4(state: State, delta:float) -> State:
	var k1=derivation_function(state)
	var k2=derivation_function(state.add(k1.multipl_by_time(delta/2)))
	var k3=derivation_function(state.add(k2.multipl_by_time(delta/2)))
	var k4=derivation_function(state.add(k3.multipl_by_time(delta)))
	
	return state.add(k1.add(k2.multipl_by_scalar(2)).add(k3.multipl_by_scalar(2)).add(k4).multipl_by_time(delta/6))
	
func apply_wind(state:State) -> State:
	return State.new(state.position, state.velocity-Manager.wind_velocity)

func _physics_process(delta: float) -> void:
	state.position=node.position
	state.velocity=velocity
	
	state=rk4(state, delta)
	state=apply_wind(state)
	
	node.position=state.position
	velocity = state.velocity
	
	
	
	
	
	
