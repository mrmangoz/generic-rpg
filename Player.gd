extends KinematicBody2D


export (int) var speed 
var currVel 
var height
var width
var currTree
var movements
var playAnim 

onready var globalVars = get_node("/root/Global")
onready var sceneChg = get_node("/root/SceneChanger")
onready var playerInv = get_node("/root/Inventory")

# Calls every time the scene changes
func _ready():
	
	position = globalVars.storedPos
	#print("Current Tree: " + currTree.get_name())
	self.visible = true
	globalVars.canMove = true
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	print(playerInv.playerItems)

# The basic process is as follows:
# Detect which side of the screen the player has left
# Stop the player moving
# Store relevant x/y coord to position play on new screen
# Calculate new x/y coord and make it 10 away to prevent accidental screen change
# Make player invisible
# Set position for new screen
# Change the scene
# Make player visible
# Allow player to move

### POTENTIAL ISSUES ###
# If there is a pickup of some kind in the opposite door way of the room the
# player leaves, they will be teleported on top of it before the scene changes
# and the pickup is removed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# The current parent node
	currTree = get_tree().get_current_scene().get_child(0)
	# if off the right
	if self.position.x >= width and currTree.rightPointer != null:
		globalVars.storedPos.x = 10
		globalVars.storedPos.y = position.y
		sceneChangeSteps(currTree.rightPointer)
		
	# if off the left
	if self.position.x <= 0 and currTree.leftPointer != null:
		globalVars.storedPos.x = width-10
		globalVars.storedPos.y = position.y
		sceneChangeSteps(currTree.leftPointer)
	
	# if off the bottom
	if self.position.y >= height and currTree.downPointer != null:
		globalVars.storedPos.y = 10
		globalVars.storedPos.x = position.x
		sceneChangeSteps(currTree.downPointer)
	
	# if off the top
	if self.position.y <= 0 and currTree.upPointer != null:
		globalVars.storedPos.y = height - 10
		globalVars.storedPos.x = position.x
		sceneChangeSteps(currTree.upPointer)
		
# Modular code bby
func sceneChangeSteps(pointer):
	self.visible = false
	position = globalVars.storedPos
	SceneChanger._change_scene(currTree.get_name(), pointer)
	

# Called every frame
# Designated for physics-type operations
func _physics_process(delta):
	currVel = Vector2()
	if globalVars.canMove:
		if Input.is_key_pressed(KEY_W):
			currVel.y -= 1 
		if Input.is_key_pressed(KEY_A):
			currVel.x -= 1
		if Input.is_key_pressed(KEY_S):
			currVel.y += 1
		if Input.is_key_pressed(KEY_D):
			currVel.x += 1
		if currVel.length() > 0:
			currVel = currVel.normalized() * speed
			if currVel.y != 0:
				playAnim = "walk_up"
				if currVel.y > 0:
					playAnim = "walk_down"
			if currVel.x != 0:
				playAnim = "walk_right"
				if currVel.x < 0:
					playAnim = "walk_left"
			
			$AnimationPlayer.play(playAnim)
		else:
			$AnimationPlayer.stop()
		position += currVel * delta


func save_scene():
	pass
	#for i in 

func load_scene():
	pass
