extends WaveData

#export (int) var wave = 0 setget set_wave

#export (Resource) var rounds

export (int) var number

onready var stars = get_node('/root/Gameplay/StarField')
	

func calculate_waves():
	var wave = Store.state('wave.id')
	var multiplier = wave * 0.15
	var amount = round(wave * 5) + 1
	if amount < 0:
		return 0
	return amount
	
	
func can_add_enemy():
	var waves = calculate_waves()
	var kills = Store.state('wave.kills')
	var enemies = Store.state('wave.enemies')
	print("%s, %s, %s" % [kills, waves, enemies])
	if kills == waves:
		Store.commit('countdown_wave')
		print('DONE')
		#self.wave += 1
	#	self.wave += 1
	return enemies < waves
	
func _ready():
#	rounds = WaveData.new()
	stars.emitting = true
