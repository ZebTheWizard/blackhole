extends Label

func _ready():
	visible = false
	Store.listen('next_wave', self, 'on_next_wave')

func on_next_wave(state):
	text = str(state.get('wave.id'));
	visible = true

