extends Area2D


var items = {}
var rng = RandomNumberGenerator.new()
var activated = false
onready var animator = get_node("AnimationPlayer")
onready var potSprite = get_node("Sprite")

export (int) var newFrame


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func drop_items():
	for pickup in self.items:
		var temp = load(pickup)
		for i in range(self.items[pickup]):
			var node = temp.instance()
			node.position.x = self.position.x
			node.position.y = self.position.y
			rng.randomize()
			node.set_linear_velocity(Vector2(rng.randi_range(-500, 500), rng.randi_range(-500, 500)))
			get_tree().get_current_scene().get_child(0).add_child(node)
			

func _physics_process(delta):
	var currBodies = get_overlapping_bodies() # Get a list of bodies currently intersecting it
	if currBodies.size() != 0: # If the list isnt empty
		if !activated: # If this pot has't been previously broken
			for item in currBodies: # Loop through the list, if the player is intersecting 
									# (should be changed to sword, etc...) destroy the pot)
				if item.name == "Player":
					animator.play("Destroy")
					potSprite.set_frame(3)
					newFrame = potSprite.frame
					activated = true
					self.drop_items()
		

func _on_body_enter():
	print("hello")
