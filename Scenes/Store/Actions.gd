extends Node

func countdown_wave(data=null):
	if Store.state('wave.countdown') != 0:
		Store.dec('wave.countdown')
	else:
		Store.commit('next_wave')
		
func next_wave(data=null):
	Store.update('wave', {
		id = h.inc(),
		kills = 0,
		countdown = 3,
		enemies = 0
	})
	
func kill_enemy(score:int):
	Store.inc('wave.kills')
	Store.inc('score', score)


func spawn_enemy(data=null):
	Store.inc('wave.enemies')
