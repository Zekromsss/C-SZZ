class_name player extends CharacterBody2D 

var cardinal_direction : Vector2 = Vector2.DOWN#人物朝向
var direction : Vector2 = Vector2.ZERO 		   #人物运动向量
var move_speed : float = 100.0
var state : String = "idle"					   #行走或静止状态

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $PlayerSprite

func _process(delta: float) -> void:
	
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	velocity = direction *move_speed 
	
	if SetState() == true or SetCardinalDirection() == true:
		UpdataAnimaterPlayer()
func _physics_process(delta):move_and_slide()

func SetCardinalDirection ( ) -> bool:
	var new_cardirection : Vector2 = cardinal_direction
	
	if direction == Vector2.ZERO:
		return false
		
	if direction.y == 0:
		new_cardirection = Vector2.LEFT if direction.x < 0  else Vector2.RIGHT
	elif direction.x == 0:
		new_cardirection = Vector2.UP if direction.y < 0  else Vector2.DOWN
	
	if new_cardirection == cardinal_direction:
		return false
	
	cardinal_direction = new_cardirection
	sprite.scale.x = -1 if cardinal_direction==Vector2.LEFT  else 1
	return true
func SetState () -> bool:
	var new_state : String = "idle"  if direction == Vector2.ZERO  else "walk"
	if new_state == state:
		return false
	state = new_state
	return true
	
func UpdataAnimaterCardinalDirection () -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
func UpdataAnimaterPlayer () -> void:
	animation_player.play( state + "_" + UpdataAnimaterCardinalDirection())
