extends Area2D

var items = {}
var rng = RandomNumberGenerator.new()
@export var activated = false
@onready var animator = get_node("AnimationPlayer")
@onready var potSprite = get_node("Sprite2D")
@export var newFrame: int 

# loop through the items in the container and instance them, with the scene as the parent
# Currently adds random velocity to add dynamicness
# Should probably sort a system for less random, more direction velocity
func drop_items():
	for pickup in self.items:
		print(pickup)
		var temp = load(pickup)
		for i in range(self.items[pickup]):
			var nNode = temp.instantiate()
			nNode.position.x = self.position.x
			nNode.position.y = self.position.y
			rng.randomize()
			nNode.set_linear_velocity(Vector2(rng.randi_range(-500, 500), rng.randi_range(-500, 500)))
			var parent_node = get_tree().get_root().get_node("main").get_child(0)
			parent_node.add_child(nNode)
			nNode.set_owner(parent_node) # Necessary for persistence in packedscenes
			
			
			

func _physics_process(delta):
	var currBodies = get_overlapping_bodies() # Get a list of bodies currently intersecting it
	if currBodies.size() != 0: # If the list isnt empty
		if !self.activated: # If this pot has't been previously broken
			for item in currBodies: # Loop through the list, if the player is intersecting 
									# (should be changed to sword, etc...) destroy the pot)
				if item.name == "Player":
					animator.play("Destroy")
					potSprite.set_frame(3)
					newFrame = potSprite.frame
					activated = true
					self.drop_items()
		
