extends RigidBody2D


var rng = RandomNumberGenerator.new()
onready var playerInv = get_node("/root/Inventory")
var pickable = false
var pickableTimer = 0.5

func _ready():
	self.contact_monitor = true;
	self.contacts_reported = 10;

func _physics_process(delta):
	var currBodies = self.get_colliding_bodies() # Get a list of bodies currently intersecting it
	if currBodies.size() != 0: # If the list isnt empty
		for item in currBodies: # Loop through the list, if the player is intersecting 
									# (should be changed to sword, etc...) destroy the pot)
			if item.name == "Player":
					###
					#animator.play("Collect") Once animations have been added
					#potSprite.set_frame(3)
					#newFrame = potSprite.frame
					#activated = true
					#self.drop_items()
					###
				if !pickable:
					#wait for pickup timer
					self.pickable = true
				playerPickup()
					

func playerPickup():
	var selfNamePath = self.get_filename()
	if playerInv.playerItems.has(selfNamePath):
		playerInv.playerItems[selfNamePath] += 1
	else:
		playerInv.playerItems[selfNamePath] = 1
						
	self.queue_free()
