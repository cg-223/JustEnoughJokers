SMODS.Joker {
    key = "chart",
    rarity = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    config = {
        extra = { mult = 2 }
    },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() >= 2 and context.other_card:get_id() <= 10 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

SMODS.Joker {
    key = "calandar",
    rarity = 2,
    config = {
        extra = {
            xmult = 3,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local sum = 0
            for _, v in pairs(context.scoring_hand) do
                local rank = v:get_id()
                if rank >= 2 and rank <= 10 then
                    sum = sum + rank
                end
            end
            if sum >= 1 and sum <= 31 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Joker {
    key = "mcdonalds",
    rarity = 2,
    config = {
        extra = {
            dollarslimit = 5,
            dollars = 2,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollarslimit } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}

local old = ease_dollars
function ease_dollars(mod, instant)
    local n = SMODS.find_card("j_cmp_mcdonalds")[1]
    if n then
        return old(math.min(mod, n.ability.extra.dollarslimit), instant)
    end
    return old(mod, instant)
end

SMODS.Consumable {
    key = "shark",
    set = "Spectral",
    config = {
        extra = {
            dollars = 100,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    use = function(self, card, area, copier)
        ease_dollars(card.ability.extra.dollars)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Joker {
    key = "michelin",
    rarity = 2,
    config = {
        extra = {
            loss = 3,
            gain = 20,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.loss, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                dollars = -card.ability.extra.loss
            }
        end
        if context.end_of_round and context.cardarea == G.jokers then
            return {
                dollars = card.ability.extra.gain
            }
        end
    end
}

SMODS.Consumable {
    key = "investment",
    set = "Spectral",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    config = {
        extra = {
            dollars = 5,
        }
    },
    use = function(self, card, area, copier)
        ease_dollars(-card.ability.extra.dollars)
        if G.GAME.cg_should_double then
            G.GAME.cg_should_double = G.GAME.cg_should_double * 2
        else
            G.GAME.cg_should_double = 2
        end
    end,
    can_use = function(self, card)
        return true
    end
}

local old = ease_dollars
function ease_dollars(mod, instant)
    if G.GAME.cg_should_double and mod > 0 then
        mod = mod * G.GAME.cg_should_double
        G.GAME.cg_should_double = nil
    end
    return old(mod, instant)
end

SMODS.Joker {
    rarity = 3,
    key = "c4",
    config = {
        extra = {
            xmult = 1.3,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.xmult}}
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return {xmult = card.ability.extra.xmult}
        elseif context.destroy_card then
            if context.destroy_card == G.play.cards[#G.play.cards] then
                return {remove = true}
            end
        end
    end
}

SMODS.Joker {
    rarity = 1,
    key = "pizzahut",
    config = {
        extra = {
            dollars = 7,
            time = 20,
            start_time = nil,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.dollars, card.ability.extra.time, (card.ability.extra.start_time and (card.ability.extra.time - (love.timer.getTime() - card.ability.extra.start_time))) or "inactive"}}
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            card.ability.extra.start_time = love.timer.getTime()
        elseif context.blind_defeated then
            local diff = love.timer.getTime() - (card.ability.extra.start_time or 0)
            card.ability.extra.start_time = nil
            if diff < card.ability.extra.time then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end
}
