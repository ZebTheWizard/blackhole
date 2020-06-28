extends Timer



var _enemy = load('res://Scenes/LittleRed.tscn')
onready var game = get_node('/root/Gameplay')


func spawn_enemy(scene, x, y):
	var enemy = scene.instance()
	enemy.position.x = x
	enemy.position.y = y
	game.call('add_child', enemy)
	Store.commit('spawn_enemy')
	

func _on_Timer_timeout():
	randomize()
	var spawn = get_children()[randi() % get_child_count()]
	var pos = spawn.rect_position
	var size = spawn.rect_size
	var x = rand_range(pos.x, pos.x + size.x)
	var y = rand_range(pos.y, pos.y + size.y)
	if game.can_add_enemy():
		spawn_enemy(_enemy, x, y)
