extends StickerAttribute
class_name FurtherStickerAttribute

export (int, "Common,Uncommon,Rare,Epic,Legendary") var new_rarity:int = 1
export (Array, Resource) var attribute_profile:Array = []

func notify(_move, _fighter, _id:String, _args):
	pass

