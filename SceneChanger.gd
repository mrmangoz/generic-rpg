extends CanvasLayer

signal scene_changed()

onready var animation_player = self.get_node("AnimationPlayer")
onready var black = self.get_node("Control/blackRect")
onready var globalVars = get_node("/root/Global")

func _ready():
	pass


func change_scene(path, delay = 0.5): # Fade out > change scene > fade in
	#print("changing")
	globalVars.canMove = false
	#yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")


func _on_AnimationPlayer_animation_finished(anim_name):
	pass
