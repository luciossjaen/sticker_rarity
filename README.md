# Sticker Rarities Revamped

This mod reimagines the rarity tiers of the current sticker attributes in the game as well as adding completely new attributes and rarity tiers to all stickers.

This mod originally started as a test project to get used to the Engine and modding this game, but quickly became a passion project that got extended way further than first expected.

When we first played the game and got our first uncommon and rare stickers, we assumed that there will be even rarer ones, which was not the case. So why not just add them myself then~

# Content

This extension adds **23 (10 unique) new sticker attributes** to the game and slightly **updates 15 existing sticker attributes** to support the newly added attribute tiers **"Epic"** and **"Legendary"** to give players more options in combining different attributes on a single sticker.

To support the new rarity tiers, this mod also rebalances the droprate of different sticker attributes tiers. More information can be found  below.

## Epic / Legendary stickers

The game was modified to now support and provide Common, Uncommon, Rare, Epic and Legendary stickers and corresponding attributes. For this, the drop chance for each rarity had to be updated:


#### Old Values
|Old|Common|Uncommon|Rare|Epic|Legendary|
|----|------|--------|----|----|---------|
|Default|93.75%|5%|1.25%|/|/|
|Bootleg|16.7%|66.6%|16.7%|/|/|

#### New Values
|New|Common|Uncommon|Rare|Epic|Legendary|
|----|------|--------|----|----|---------|
|Default|87.5%|8%|3%|1%|0.5%|
|Bootleg|10%|45%|25%|15%|5%|

Stickers also require more slots to support those new rarity tiers. Therefore additionally to the usual 2 Uncommon and 1 Rare sticker slot, each sticker can also have 1 Epic and 1 Legendary attribute, increasing the total slots to 5.

To balance this a bit, the chance to have multiple attributes generated on a sticker was slightly decreased. Stickers with a higher rarity have a bigger chance to generate more attributes though.

## Updated existing attributes

As mentioned, 15 of the default attributes where updated and increased in rarity to have a bigger variety of attributes in every rarity tier. This also allows you to create previously unknown combinations on a single sticker.

The following sticker attributes where updated:

|Attribute|Old Rarity|New Rarity|Notes
|---|---|---|---|
Extra Hit|uncommon|rare|/|
Multitarget|uncommon|rare|/|
Priority Chance|uncommon|rare|Weight (0.2 → 1)|
Priority per empty slot|uncommon|rare|Weight (0.2 → 1)|
|---|---|---|---|
AP Refund 1|rare|epic|/|
Use at Round Ending|rare|epic|/|
Use after Attacks|rare|epic|Weight (0.2 → 1)|
Extra Slot|rare|epic|/|
Shared with allies|rare|epic|/|
Evasion %|rare|epic|Weight (0.2 → 1)|
Evasion % per empty slot|rare|epic|Weight (0.2 → 1)|
Use move again|rare|epic|/|
Use random move|rare|epic|/|
|---|---|---|---|
Compatibility|rare|legendary|/|
AP Refund all|rare|legendary|Chance (1-5% → 5%-10%)

## Newly added attributes

Next to updating the attributes we already have, installing this mod als adds quite a few new attributes to the game that you can encounter. The new attributes all have the default weight, which allows you to pull all attributes evenly on your stickers.

This list will provide an overview of the new attributes, their assigned (sticker) profiles and a short description.

|Attribute|Rarity|Profiles|Description|
|---|---|---|---|
Duration Reducer|epic|Attack|[5-25%] Chance to reduce target status durations by 1.
Elemental Resistance|epic|Passive|[5-15%] reduced damage taken from {Element}*-type attacks.
Low Health Crit|epic|Attack|Guaranteed critical hit when own HP below [5-25%].
Create Gemstone Wall|epic|Non-Passive|[15-25%] Chance to create a Gemstone wall.
AP Generator|legendary|Passive|[5-15%] Chance to generate 1 AP when hit.
AP Steal|legendary|Attack|[5-15%] Chance to steal 1 AP from target(s).
Duration Extender|legendary|Non-Passive|[5-25%] to extend now status durations by 1.
Reaction Negator|legendary|Passive|[5-20%] Chance to negate all reactions when hit.
Treasure Trove|legendary|Non-Passive|[1-10%] Chance to find treasure*.

* Elemental Resistance can appear as any element individually.
* The treasure is generated from the better loot pool of Treasure Dig.

##FAQ

**Is this compatible with existing savefiles?**
> Yes, but some of your stickers might have the wrong rarity since the attributes on existing stickers are updated, but the stickers themselves aren't since those are saved externally. To fix this, this mod provides the `update_sticker_rarities`-command. This command will scan and update the rarities of all your stickers to reflect their attribute rarities in your selected savefile.

**Can this mod be removed safely?**
> Unfortunately, the mod cannot be removed without messing up the savefile, since the rarities assigned to stickers  dont exist in the game and crash it, when you try to load the game with unsupported rarities. But the mod also provides a solution for it. If you want to remove this mod safely, you can run the `cleanly_remove_rarity_tiers`-command. This command cleans up the selected savefile of all content from this mod that would crash on start-up with vanilla settings. This includes:
>> - removing all modded attributes from stickers
>> - resetting the rarities of stickers based on their remaining attributes (vanilla rarities considered)
>> - removing overflowing attributes, if the amount does not match vanilla max. attributes (per rarity)

**How can the new attributes be obtained?**
> The mod edits the vanilla drop-tables (as seen above) to include the new attributes and rarities in the vanilla generation. Therefore you can find the new additions anywhere where you can get vanilla stickers (vending machines, level-ups, crates, etc.)

**Is this mod compatible with other mods?**
>I took a long time to test other (popular) mods in combination with this one. There are currently no incompatbilities known, but you can let me know, if you encounter any. Since most mods expand the vanilla features in a safe way, mods like [Vending Machine+](https://modworkshop.net/mod/42332) and [Loot Table Plus](https://modworkshop.net/mod/42166) integrate the content of this mod without any issues.
>
>Since cross-compatibility between mods with a similar target in content are important though, I went out of my way to make this mod 100% compatible with [Sticker Recycle Bonus](https://modworkshop.net/mod/42336). When both mods are installed, you are able to recycle and attach all of our attributes to new stickers the same way you already do it in the recycle mod with vanilla stickers. Sticker Tiers Revamped provides their own attribute cores and cost-tables for the compatibility and makes sure that the limits of slots are still enforced with attaching new attributes to your stickers. For more information about this, visit the mentioned mod above. Enjoy!

#Requirements
- Cassette Beasts v1.5
- No special tags for savefiles or network play








