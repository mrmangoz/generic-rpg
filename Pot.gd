extends "res://Containers.gd"

func _ready(): # When entering new scene, set the pot to its correct frame
	potSprite.set_frame(newFrame)
	rng.randomize()
	self.items["res://Coin.tscn"] = (rng.randi_range(1, 2))
	rng.randomize()
	self.items["res://Heart.tscn"] = (rng.randi_range(1,2))
