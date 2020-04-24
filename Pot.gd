extends Area2D

export (bool) var broken = false
export (int) var newFrame
onready var animator = get_node("AnimationPlayer")
onready var potSprite = get_node("Sprite")

func _ready(): # When entering new scene, set the pot to its correct frame
	potSprite.set_frame(newFrame)

func _physics_process(delta):
	var currBodies = get_overlapping_bodies() # Get a list of bodies currently intersecting it
	if currBodies.size() != 0: # If the list isnt empty
		if !broken: # If this pot has't been previously broken
			for item in currBodies: # Loop through the list, if the player is intersecting (should be changed to sword, etc...) destroy the pot)
				if item.name == "Player":
					animator.play("Destroy")
					potSprite.set_frame(3)
					newFrame = potSprite.frame
					broken = true
		

