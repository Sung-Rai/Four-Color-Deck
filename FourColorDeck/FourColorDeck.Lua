--- STEAMODDED HEADER
--- MOD_NAME: Four Color Deck
--- MOD_ID: FourColorDeck
--- PREFIX: FourColor
--- MOD_AUTHOR: [Lemontender]
--- MOD_DESCRIPTION: FabianPEKS' Four-Color Deck made into an installable mod!
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.0.0
--- BADGE_COLOR: fbf173

----------------------------------------------
------------MOD CODE -------------------------

local atlas_key = 'FourColor' -- Format: PREFIX_KEY -- See end of file for notes
local atlas_path = 'FourColorDeck_lc.png' -- Filename for the image in the asset folder
local atlas_path_hc = 'FourColorDeck_hc.png' -- Filename for the high-contrast version of the texture, if existing

local suits = {'clubs', 'spades', 'hearts', 'diamonds'} -- Which suits to replace
local ranks = {'Jack', 'Queen', "King", "Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10"} -- Which ranks to replace

local description = 'Four Color Balatro Cards' -- English-language description, also used as default

-- Changes the color of the UI assets and keywords.
function SMODS.INIT.DecColors()
    local deck_mod = SMODS.findModByID("FourColorDeck")
    local ui_asset = SMODS.Sprite:new("ui_1", deck_mod.path, "ui_assets.png", 18, 18, "asset_atli")
    local ui2asset = SMODS.Sprite:new("ui_2", deck_mod.path, "ui_assets.png", 18, 18, "asset_atli")

    ui_asset:register()
    ui2asset:register()

    G.C.SO_1.Clubs = HEX("00b63b")
	G.C.SO_2.Clubs = HEX("00b63b")
	G.C.SUITS.Clubs = HEX("00b63b")
	
	G.C.SO_1.Diamonds = HEX("3bb3f8")
	G.C.SO_2.Diamonds = HEX("3bb3f8")
	G.C.SUITS.Diamonds = HEX("3bb3f8")
	
	G.C.SO_1.Hearts = HEX("ed2324")
	G.C.SO_2.Hearts = HEX("ed2324")
	G.C.SUITS.Hearts = HEX("ed2324")
	
	G.C.SO_1.Spades = HEX("070707")
	G.C.SO_2.Spades = HEX("070707")
	G.C.SUITS.Spades = HEX("070707")
end


-- Adds the deck skin
SMODS.Atlas{  
    key = atlas_key..'_lc',
    px = 71,
    py = 95,
    path = atlas_path,
    prefix_config = {key = false}, -- See end of file for notes
}

if atlas_path_hc then
    SMODS.Atlas{  
        key = atlas_key..'_hc',
        px = 71,
        py = 95,
        path = atlas_path_hc,
        prefix_config = {key = false}, -- See end of file for notes
    }
end

for _, suit in ipairs(suits) do
    SMODS.DeckSkin{
        key = suit.."_skin",
        suit = suit:gsub("^%l", string.upper),
        ranks = ranks,
        lc_atlas = atlas_key..'_lc',
        hc_atlas = (atlas_path_hc and atlas_key..'_hc') or atlas_key..'_lc',
        loc_txt = {
            ['en-us'] = description
        },
        posStyle = 'deck'
    }
end

-- This changes the colours of the sinful jokers.
SMODS.Atlas {
    key = "Joker",
    path = "Jokers.png",
    px = 71,
    py = 95,
    prefix_config = { key = false }
}

-- Notes:

-- The current version of Steamodded has a bug with prefixes in mods including `DeckSkin`s.
-- By manually including the prefix in the atlas' key, this should keep the mod functional
-- even after this bug is fixed.
