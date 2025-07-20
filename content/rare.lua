local rars = {
    1,2,3,4
}

SMODS.Joker {
    atlas = "JEJJokers",
    key = "cleanfreak",
    rarity = 3,
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = {
            xmult = 3,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.xmult}}
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local jkrs = {}
            for i, v in pairs(G.jokers.cards) do
                if type(v.config.center.rarity) == "number" and rars[v.config.center.rarity] then
                    table.insert(jkrs, v.config.center.rarity)
                end
            end

            for i = 1, #jkrs-1 do
                local rar1, rar2 = jkrs[i], jkrs[i+1]
                if not (rar1 and rar2) then
                    break
                end
                if rar1 > rar2 then
                    return
                end
            end
  
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}