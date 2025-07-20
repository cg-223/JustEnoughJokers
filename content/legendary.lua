local function num_jokers()
    if JEJ.jokers then
        return JEJ.jokers
    end
    JEJ.jokers = 0
    for i, v in pairs(G.P_CENTERS) do
        if string.sub(i, 1, 2) == "j_" then
            JEJ.jokers = JEJ.jokers + 1
        end
    end
    return JEJ.jokers
end



SMODS.Joker {
    key = "cg223",
    atlas = "JEJJokers",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    rarity = 4,
    loc_vars = function(self, info_queue, card)
        card.ability.extra.chips = card.ability.extra.extra * num_jokers()
        return { vars = { card.ability.extra.extra, card.ability.extra.chips } }
    end,
    config = {
        extra = {
            chips = 0,
            extra = 25,
        }
    },
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.chips = card.ability.extra.extra * num_jokers()
            return {chips = card.ability.extra.chips}
        end
    end
}
