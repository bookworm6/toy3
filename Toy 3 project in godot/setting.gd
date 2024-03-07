extends Node3D
var livingCats

# Called when the node enters the scene tree for the first time.
func _ready():
	livingCats = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass
	$Cat.set_mouse_position($Mouse.position)


func _on_landmine_body_entered(body):
	if body.get_name() == ("Cat") or body.get_name() == ("Cat2") or body.get_name() == ("Cat3"):
		body.hide()
		livingCats-=1
		if livingCats<=0:
			game_over("mouse")
	elif body.get_name() == "Mouse":
		game_over("cats")



func game_over(winnerString):
	pass


func _on_cat_cat_wins():
	game_over("cats")


func _on_cat_3_cat_wins():
	game_over("cats")


func _on_cat_2_cat_wins():
	game_over("cats")
