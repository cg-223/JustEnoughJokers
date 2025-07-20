local oldjokers
local oldupd = love.update
local shallow_cmp = function(tbla, tblb)
    if #tbla ~= #tblb then
        return false
    end
    for i, v in pairs(tbla) do
        if tblb[i] ~= v then
            return false
        end
    end
    return true
end
function love.update(dt)
    oldupd(dt)
    if G.jokers then
        if oldjokers then
            if not shallow_cmp(oldjokers, G.jokers.cards) then
                oldjokers = {}
                for i, v in pairs(G.jokers.cards) do
                    oldjokers[i] = v
                end
                SMODS.calculate_context({ card_moved = true })
            end
        else
            oldjokers = {}
            for i, v in pairs(G.jokers.cards) do
                oldjokers[i] = v
            end
        end
    end
end
