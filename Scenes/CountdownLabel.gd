extends Label

func _ready():
	Store.listen('countdown_wave', self, 'on_countdown')

func on_countdown(state):
	var countdown = state.get('wave.countdown') + 1;
	text = str(countdown)
	visible = countdown <= 3

