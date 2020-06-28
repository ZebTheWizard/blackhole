extends Node

signal update(state)


class StoreObject:
	var _data:Dictionary
		
	func _init(data:Dictionary):
		_data = data
		
	func _to_string() -> String:
		return '[' + get_class()  + ': ' + str(get_instance_id()) + ']' + str(_data)
	
	func text(path:=".") -> String:
		return str(get(path))
	
	func dec(path, amount=1):
		var value = get(path)
		update(path, value - amount)
		
	func inc(path, amount=1):
		var value = get(path)
		update(path, value + amount)
	
	func update(path, value):
		var paths = path.split('.')
		var vars = [] 
		var query = {}
		
		if path[0] == '.':
			for i in range(1,paths.size()):
				vars.append(paths[i])
		else:
			for i in range(0,paths.size()):
				vars.append(paths[i])
		
		if path != '.':
			var ref = query
			for i in range(vars.size() - 1):
				ref[vars[i]] = {}
				ref = ref[vars[i]]
			ref[vars[vars.size() - 1]] = value
		h.merge_dict(State.state, query)
	
	func get(path:=".") -> Object:
		var res = _data
		var paths = path.split('.')
		var vars = [] 
		
		
		if path[0] == '.':
			for i in range(1,paths.size()):
				vars.append(paths[i])
		else:
			for i in range(0,paths.size()):
				vars.append(paths[i])
		
		if path != '.':
			for key in vars:
				if typeof(res) == 18 and res.has(key):
					res = res.get(key)
				elif typeof(res) == 19:
					res = res[int(key)]
				else:
					return null
		if typeof(res) == 18:
			return StoreObject.new(res)
		return res

func update(path, value):
	StoreObject.new(State.state).update(path, value)
	
func inc(path, amount=1):
	StoreObject.new(State.state).inc(path, amount)
	
func dec(path, amount=1):
	StoreObject.new(State.state).dec(path, amount)

func state(path:="."):
	var state = StoreObject.new(State.state)
	if path == ".":
		return state
	return state.get(path)

func setState(value:Dictionary) -> StoreObject:
	h.merge_dict(State.state, value, true, "Cannot set state. Key not defined.")
	var current = state()
	emit_signal("update", current)
	return current
	
func commit(action:String, data=null) -> void:
	if _Actions.has_method(action):
		_Actions.call(action, data)
		if has_user_signal(action):
			emit_signal(action, state())
	
func listen(channel:String, obj:Object, method:String) -> void:
	if _Actions.has_method(channel):
		if not has_user_signal(channel):
			add_user_signal(channel, [{name = 'state', type = TYPE_OBJECT}])
		self.connect(channel, obj, method)
	else:
		push_error("Invalid action")
	
func _ready() -> void:
	emit_signal("update", state())
