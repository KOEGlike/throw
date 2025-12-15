extends StaticBody2D

class_name Target

@onready var label: Label = $Label

var count=0:
	set(val):
		count=val
		label.text=str(val);
	get:
		return count;
