extends ReferenceRect



var _enemy = load('res://Scenes/LittleRed.tscn')
onready var _game = get_node('/root/Gameplay')

func _ready():
	for i in range(0, 10):
		var enemy = _enemy.instance()
		
		var x = rand_range(0, rect_size.x)
		var y = rand_range(0, rect_size.y)
		
		enemy.position.x = x
		enemy.position.y = y
		#enemy.global_position.x = x
		#enemy.global_position.y = y
		_game.call_deferred('add_child', enemy)
