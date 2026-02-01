extends CharacterBody2D


var direction_x :float
var speed :=50
@export var jump_strength : =10
@export var gravity:=10
signal shoot(pos:Vector2,dir)

const gun_direction = {
	Vector2i(1,0):0,
	Vector2i(1,1):1,
	Vector2i(0,1):2,
	Vector2i(-1,1):3,
	Vector2i(-1,0):4,
	Vector2i(-1,-1):5,
	Vector2i(0,-1):6,
	Vector2i(1,-1):7
}

func get_input():
	direction_x = Input.get_axis("left","right")
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_strength
	if Input.is_action_just_pressed("shoot") and $ReloadTimer.time_left==0:
		shoot.emit(position,get_local_mouse_position().normalized())
		$ReloadTimer.start()
func apply_gravity(delta):
	velocity.y  +=gravity*delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_input()
	velocity.x = direction_x*speed
	apply_gravity(delta)
	move_and_slide()
	animation()
	
func animation():
	$Legs.flip_h = direction_x<0
	if is_on_floor():
		$Run.current_animation = "Run" if direction_x else "idle"
	else :
		$Run.current_animation="jump"
	var raw_dir = get_local_mouse_position().normalized()
	var adjusted_dir = Vector2i(round(raw_dir.x),round(raw_dir.y))
	$Torso.frame = gun_direction[adjusted_dir]
				 
