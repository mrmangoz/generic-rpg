extends CanvasLayer

#signal scene_changed()

var rooms = {
	Screen1 = "res://Screen1.tscn",
	Screen2 = "res://Screen2.tscn",
	Screen3 = "res://Screen3.tscn"
}

onready var animationPlayer = self.get_node("AnimationPlayer")
onready var black = self.get_node("Control/blackRect")
onready var globalVars = get_node("/root/Global")

func _ready():
	pass

func _change_scene(currentScene, nextScene):
	globalVars.canMove = false
	if rooms.has(currentScene) and rooms.has(nextScene):
		var levelHandler = get_tree().get_root().get_node("main")

		
		# Pack current Scene
		print("--------")
		for itemEx in levelHandler.get_child(0).get_children():
			print(itemEx.get_name() + ", parent: " + itemEx.get_parent().get_name() + ", owner: " + itemEx.get_owner().get_name())
		var packScene = PackedScene.new()
		var finishedScene = packScene.pack(levelHandler.get_child(0))
		var error = ResourceSaver.save("res://" + currentScene + "saved.tscn", packScene)
		if error != OK:
			push_error("An error occurred while saving the scene to disk.")
		else:
			pass
			#print("Packed and Saved")


		# Free Current Scene
		animationPlayer.play("fade")
		yield(animationPlayer, "animation_finished")
		levelHandler.get_child(0).queue_free()
		#print("Room freed")


		#Update saved scene in dictionary
		rooms[currentScene] = "res://" + currentScene + "saved.tscn"
		#print("Tree updated: " + rooms[currentScene])


		# Instance next Scene
		levelHandler.add_child(load(rooms[nextScene]).instance())
		#print(rooms[nextScene] + " Loaded")
		animationPlayer.play_backwards("fade")
		yield(animationPlayer, "animation_finished")
		globalVars.canMove = true
	else:
		print("Failed list check")







######## Backup in case shit gets fucked ###########

# func change_scene(path, delay = 0.5): # Fade out > change scene > fade in)
# 	globalVars.canMove = false
# 	#yield(get_tree().create_timer(delay), "timeout")
# 	animation_player.play("fade")
# 	yield(animation_player, "animation_finished")
# 	assert(get_tree().change_scene(path) == OK)
# 	animation_player.play_backwards("fade")
# 	yield(animation_player, "animation_finished")
# 	emit_signal("scene_changed")

# func store_scene():
# 	var packedScene = PackedScene.new()
# 	var currScene = get_tree().get_current_scene()
# 	var scene_root = currScene
# 	_set_owner(scene_root, scene_root)
# 	packedScene.pack(scene_root)
# 	var error = ResourceSaver.save('user://SavedScene1.tscn', packedScene) # or .scn to avoid people messing with it
# 	if error != OK:
# 		push_error("An error occurred while saving the scene to disk.")
		
# func _set_owner(node, root):
# 	if node != root:
# 		node.owner = root
# 	for child in node.get_children():
# 		_set_owner(child, root)
	
# func load_scene(scenename, path):
# 	var tempPath = 'res://Saved' + scenename + '.tscn'
# 	var loadedScene = load(tempPath).instance()
# 	var nodeToLoadInto = get_node(get_tree().path)
