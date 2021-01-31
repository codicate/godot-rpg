extends Resource
class_name Item

var items = ["Medkit", "22mm Ammo", "Pill"]

export(String) var name = ""
export(Texture) var texture
export(bool) var stackable = false
export(int) var value
export(String) var description = ""

var amount = 1
