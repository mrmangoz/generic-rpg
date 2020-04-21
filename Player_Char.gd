extends Area2D

var movingKey = false
var speed = 5
var currentDir = Vector2()
var moves = {
			'right': Vector2(1, 0),
			'left': Vector2(-1, 0),
			'up': Vector2(0, -1),
			'down': Vector2(0, 1) }



# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport_rect().size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movingKey:
		move(currentDir)


func _input(event):
	if event is InputEventKey and event.pressed: # A key was pressed
		currentDir = Vector2() 
		movingKey = true
		if Input.is_key_pressed(KEY_W):
			currentDir += moves['up']
		if Input.is_key_pressed(KEY_A):
			currentDir += moves['left']
		if Input.is_key_pressed(KEY_S):
			currentDir += moves['down']
		if Input.is_key_pressed(KEY_D):
			currentDir += moves['right']
	if event is InputEventKey and event.pressed == false:
		movingKey = false # The key was released
		
func move(dir):
	position += dir * speed
