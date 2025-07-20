local rars = {
    1, 2, 3, 4
}

local function are_jokers_sorted()
    local jkrs = {}
    for i, v in pairs(G.jokers.cards) do
        if type(v.config.center.rarity) == "number" and rars[v.config.center.rarity] then
            table.insert(jkrs, v.config.center.rarity)
        end
    end

    for i = 1, #jkrs - 1 do
        local rar1, rar2 = jkrs[i], jkrs[i + 1]
        if not (rar1 and rar2) then
            break
        end
        if rar1 > rar2 then
            return
        end
    end
    return true
end



SMODS.Joker {
    atlas = "JEJJokers",
    key = "cleanfreak",
    rarity = 3,
    pos = {
        x = 2,
        y = 0
    },
    config = {
        can_juice_again = true,
        extra = {
            xmult = 3,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        local sortedhook = function()
            if are_jokers_sorted() then
                return true
            else
                card.ability.can_juice_again = true
            end
        end
        if are_jokers_sorted() and card.ability.can_juice_again then
            card.ability.can_juice_again = false
            juice_card_until(card, sortedhook, true)
        end
        if context.joker_main then
            if are_jokers_sorted() then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}
