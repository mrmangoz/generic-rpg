extends Area2D


export (int) var speed
var currVel 
var height
var width
var currTree

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport_rect().size / 2
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var currTree = get_tree().get_current_scene()
	if self.position.x >= width and currTree.rightPointer != null:
		SceneChanger.change_scene(currTree.rightPointer)
	if self.position.x <= 0 and currTree.leftPointer != null:
		get_tree().change_scene(currTree.leftPointer)
	if self.position.y >= height and currTree.downPointer != null:
		get_tree().change_scene(currTree.downPointer)
	if self.position.y <= 0 and currTree.upPointer != null:
		get_tree().change_scene(currTree.upPointer)


func _physics_process(delta):
	currVel = Vector2()
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
	position += currVel
