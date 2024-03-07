extends CharacterBody3D
var currentlyNavigatingToPlayer = false
var hasTargetPosition = false 
var speed = 10
var random = RandomNumberGenerator.new()
var catPatrolPoints = [Vector3(22,0,22),Vector3(-22,0,-22),Vector3(-22,0,22),Vector3(22,0,-22),Vector3(0,0,0)]
var targetPosition
var mousePosition
signal catWins

func _physics_process(delta):
	if hasTargetPosition==false:
		targetPosition = catPatrolPoints[random.randi_range(0,4)]
		print ("targetPosition: "+str(targetPosition))
		hasTargetPosition = true
	if mousePosition != null:
		var spaceState = get_world_3d().direct_space_state
		var querry = PhysicsRayQueryParameters3D.create(position,mousePosition)
		var results = spaceState.intersect_ray(querry)
		if results.size()>0:
			if (results["collider"].get_name()) == "Mouse":
				targetPosition = mousePosition
				hasTargetPosition = true
				currentlyNavigatingToPlayer = true
			else:
				currentlyNavigatingToPlayer = false
		$NavigationAgent3D.set_target_position(targetPosition) 
		var nextLocation = $NavigationAgent3D.get_next_path_position()
		velocity = ((nextLocation-position).normalized())*speed
		move_and_slide()


func set_mouse_position(positionVector3):
	mousePosition = positionVector3


func _on_navigation_agent_3d_navigation_finished():
	print ("nav finished "+str(position))
	if currentlyNavigatingToPlayer == true:
		emit_signal("catWins")
	else:
		hasTargetPosition = false
	
