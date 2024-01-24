extends "res://mods/Sticker_Recycle_Bonus/scripts/AttributeCoreItem.gd"

func get_template_rarity_color():
	var attribute:StickerAttribute = load(template_path)
	var rarity_colours:Dictionary = {
		Rarity.RARITY_COMMON:Color.black, 
		Rarity.RARITY_UNCOMMON:Color("225d31"), 
		Rarity.RARITY_RARE:Color("35379d"),
		Rarity.RARITY_EPIC:Color("BA55D3"),
		Rarity.RARITY_LEGENDARY:Color("DAA520")
	}
	return rarity_colours[attribute.rarity].to_html()

func get_name()->String:
	return Loc.trf(name, {
			"rarity":get_template_rarity_color()
		})
		
func get_rarity():
	var attribute:StickerAttribute = load(template_path)
	return attribute.rarity
