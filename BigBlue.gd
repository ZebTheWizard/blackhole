extends KinematicBody2D

var motion = Vector2()
var speed = 100;


func _physics_process(delta):
	var mousepoint = get_global_mouse_position()
	var vector = (mousepoint - position).normalized() * speed
	if (mousepoint - position).length() > 5:
		move_and_collide(vector)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
