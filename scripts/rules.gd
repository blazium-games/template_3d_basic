extends RefCounted

func slab_ready(mesh_assigned: bool) -> bool:
	return mesh_assigned

func eye_current(flag: bool) -> bool:
	return flag

var spare_energy := 1.0

func second_lamp(energy: float) -> bool:
	return energy > 0.0

func may_annex(distance: float) -> bool:
	return distance >= 0.0 and distance <= 1.6 and second_lamp(spare_energy)
