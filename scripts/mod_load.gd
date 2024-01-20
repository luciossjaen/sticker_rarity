extends ContentInfo

var baseitem_patch    = preload("res://mods/RarityTiers/scripts/BaseItem_patch.gd")
var stickeritem_patch    = preload("res://mods/RarityTiers/scripts/StickerItem_patch.gd")
var itemfactory_patch = preload("res://mods/RarityTiers/scripts/ItemFactory_patch.gd")
var stickerattribute_patch = preload("res://mods/RarityTiers/scripts/StickerAttribute_patch.gd")
var raritycolor_patch = preload("res://mods/RarityTiers/scripts/_RarityColor_patch.gd")


func _init():
	baseitem_patch.patch()
	stickeritem_patch.patch()
	itemfactory_patch.patch()
	stickerattribute_patch.patch()
	#raritycolor_patch.patch()
	
	
	var compatibility = preload("res://data/sticker_attributes/compatibility.tres")
	compatibility.rarity = 4
	
	var ap_all = preload("res://data/sticker_attributes/ap_refund_all.tres")
	ap_all.rarity = 3
	
	
