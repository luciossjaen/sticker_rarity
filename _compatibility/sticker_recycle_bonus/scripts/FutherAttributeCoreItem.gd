extends "res://mods/Sticker_Recycle_Bonus/scripts/AttributeCoreItem.gd"

func get_template_rarity_color():
	var attribute:StickerAttribute = load(template_path)
	var rarity_colours = DLC.mods_by_id["lucioss_rarity_tiers"].get_rarity_colors()
	return rarity_colours[attribute.rarity].to_html()

func get_name()->String:
	return Loc.trf(name, {
			"rarity":get_template_rarity_color()
		})
		
func get_rarity():
	var attribute:StickerAttribute = load(template_path)
	return attribute.rarity
