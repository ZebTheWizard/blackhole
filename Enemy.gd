extends KinematicBody2D

export (int) var speed = 400 setget set_speed
export (int) var lives = 1 setget set_lives
export (int) var particles = 1 setget set_particles
export (int) var reward = 10 setget set_reward
export (int) var cost = 1 setget set_cost

func set_speed(value):
	speed = value
	update()
	
func set_lives(value):
	lives = value
	update()
	
func set_particles(value):
	particles = value
	update()
	
func set_reward(value):
	reward = value
	update()
	
func set_cost(value):
	cost = value
	update()

var motion = Vector2()




func _physics_process(delta):
	#var screen = get_viewport_rect().size
	#var mousepoint = get_local_mouse_position()
	var mousepoint = Vector2(0, 0)
	var vector = (mousepoint - position).normalized() * speed * delta
	#if (mousepoint - position).length() > 5:
	move_and_collide(vector)
	

func on_click():
	self.lives -= 1
	if (lives <= 0):
		Store.commit('kill_enemy', reward)
		queue_free()


func _on_LittleRed_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			on_click()

