class_name Directions

class Movement:
	extends RefCounted

	enum Type {NW = -3, N, NE, E, SE, S, SW, W} # E = 0

	# Method that calculates the Direction from a given angle in radians
	static func from_angle (angle: float) -> String:
		# round the angle to the nearest 8th's of a circle
		var idx = roundi(angle * 8 / TAU)
		# return the direction
		return Type.find_key(idx)

	# Alturnate call for from_anlge that takes a Vector2
	static func from_vector (vector: Vector2) -> String: 
		return from_angle(vector.angle())
