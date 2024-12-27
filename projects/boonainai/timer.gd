extends Timer

var banana1 = preload('res://bananas/banana1.tscn')
var banana2 = preload('res://bananas/banana2.tscn')
var bananas = preload('res://bananas/bananas.tscn')

func _on_timer_timeout():
	print('banna')
	randomize()
	var bananass = [banana1, banana2, bananas]
	var kinds = bananass[randi() % bananass.size()]
	var banana = kinds.instantiate()
	banana.position = Vector2(randi_range(10, 990), randi_range(10, 590))
	add_child(banana)
	self.wait_time = randf_range(0.1,0.9)
