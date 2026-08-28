SMODS.Atlas {
    key = "consumable",
    path = "Tarots.png",
    px = 71, py = 95,
}
SMODS.Consumable:take_ownership('heirophant',
    {
        atlas = "consumable",
        pos = { x = 2, y = 0 },
        config = { max_highlighted = 2, mod_conv = "m_bonus", extra = { enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" } } },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            local plural = { "" , "" }
            if card.ability.max_highlighted ~= 1 then
                plural[1] = "up to "
                plural[2] = "s"
            end
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv:gsub("m_","m_recenh_") }, plural[1], plural[2] } }
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                local card_id = G.hand.highlighted[i].config.center_key
                local variant = card.ability.mod_conv:gsub("m_", "")
                local temp = {}
                local enh_id = "m_recenh_"
                for _, j in ipairs(card.ability.extra.enhancements) do
                    if (card_id:find(j) and j ~= variant) or (not card_id:find(j) and j == variant) then
                        temp[#temp + 1] = j
                        if enh_id == "m_recenh_" then
                            enh_id = enh_id .. j
                        else
                            enh_id = enh_id .. "X" .. j
                        end
                    end
                end
                if #temp == 1 then
                    enh_id = "m_" .. temp[1]
                elseif #temp == 0 then
                    enh_id = "c_base"
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(enh_id)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end,
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
        end
    }
)
SMODS.Consumable:take_ownership('empress',
    {
        atlas = "consumable",
        pos = { x = 1, y = 0 },
        config = { max_highlighted = 2, mod_conv = "m_mult", extra = { enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" } } },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            local plural = { "" , "" }
            if card.ability.max_highlighted ~= 1 then
                plural[1] = "up to "
                plural[2] = "s"
            end
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv:gsub("m_","m_recenh_") }, plural[1], plural[2] } }
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                local card_id = G.hand.highlighted[i].config.center_key
                local variant = card.ability.mod_conv:gsub("m_", "")
                local temp = {}
                local enh_id = "m_recenh_"
                for _, j in ipairs(card.ability.extra.enhancements) do
                    if (card_id:find(j) and j ~= variant) or (not card_id:find(j) and j == variant) then
                        temp[#temp + 1] = j
                        if enh_id == "m_recenh_" then
                            enh_id = enh_id .. j
                        else
                            enh_id = enh_id .. "X" .. j
                        end
                    end
                end
                if #temp == 1 then
                    enh_id = "m_" .. temp[1]
                elseif #temp == 0 then
                    enh_id = "c_base"
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(enh_id)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end,
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
        end
    }
)
SMODS.Consumable:take_ownership('lovers',
    {
        atlas = "consumable",
        pos = { x = 3, y = 0 },
        config = { max_highlighted = 1, mod_conv = "m_wild", extra = { enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" } } },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            local plural = { "" , "" }
            if card.ability.max_highlighted ~= 1 then
                plural[1] = "up to "
                plural[2] = "s"
            end
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv:gsub("m_","m_recenh_") }, plural[1], plural[2] } }
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                local card_id = G.hand.highlighted[i].config.center_key
                local variant = card.ability.mod_conv:gsub("m_", "")
                local temp = {}
                local enh_id = "m_recenh_"
                for _, j in ipairs(card.ability.extra.enhancements) do
                    if (card_id:find(j) and j ~= variant) or (not card_id:find(j) and j == variant) then
                        temp[#temp + 1] = j
                        if enh_id == "m_recenh_" then
                            enh_id = enh_id .. j
                        else
                            enh_id = enh_id .. "X" .. j
                        end
                    end
                end
                if #temp == 1 then
                    enh_id = "m_" .. temp[1]
                elseif #temp == 0 then
                    enh_id = "c_base"
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(enh_id)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end,
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
        end
    }
)
SMODS.Consumable:take_ownership('justice',
    {
        atlas = "consumable",
        pos = { x = 1, y = 1 },
        config = { max_highlighted = 1, mod_conv = "m_glass", extra = { enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" } } },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            local plural = { "" , "" }
            if card.ability.max_highlighted ~= 1 then
                plural[1] = "up to "
                plural[2] = "s"
            end
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv:gsub("m_","m_recenh_") }, plural[1], plural[2] } }
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                local card_id = G.hand.highlighted[i].config.center_key
                local variant = card.ability.mod_conv:gsub("m_", "")
                local temp = {}
                local enh_id = "m_recenh_"
                for _, j in ipairs(card.ability.extra.enhancements) do
                    if (card_id:find(j) and j ~= variant) or (not card_id:find(j) and j == variant) then
                        temp[#temp + 1] = j
                        if enh_id == "m_recenh_" then
                            enh_id = enh_id .. j
                        else
                            enh_id = enh_id .. "X" .. j
                        end
                    end
                end
                if #temp == 1 then
                    enh_id = "m_" .. temp[1]
                elseif #temp == 0 then
                    enh_id = "c_base"
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(enh_id)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end,
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
        end
    }
)
SMODS.Consumable:take_ownership('chariot',
    {
        atlas = "consumable",
        pos = { x = 0, y = 1 },
        config = { max_highlighted = 1, mod_conv = "m_steel", extra = { enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" } } },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            local plural = { "" , "" }
            if card.ability.max_highlighted ~= 1 then
                plural[1] = "up to "
                plural[2] = "s"
            end
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv:gsub("m_","m_recenh_") }, plural[1], plural[2] } }
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                local card_id = G.hand.highlighted[i].config.center_key
                local variant = card.ability.mod_conv:gsub("m_", "")
                local temp = {}
                local enh_id = "m_recenh_"
                for _, j in ipairs(card.ability.extra.enhancements) do
                    if (card_id:find(j) and j ~= variant) or (not card_id:find(j) and j == variant) then
                        temp[#temp + 1] = j
                        if enh_id == "m_recenh_" then
                            enh_id = enh_id .. j
                        else
                            enh_id = enh_id .. "X" .. j
                        end
                    end
                end
                if #temp == 1 then
                    enh_id = "m_" .. temp[1]
                elseif #temp == 0 then
                    enh_id = "c_base"
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(enh_id)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end,
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
        end
    }
)
SMODS.Consumable:take_ownership('tower',
    {
        atlas = "consumable",
        pos = { x = 3, y = 1 },
        config = { max_highlighted = 1, mod_conv = "m_stone", extra = { enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" } } },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            local plural = { "" , "" }
            if card.ability.max_highlighted ~= 1 then
                plural[1] = "up to "
                plural[2] = "s"
            end
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv:gsub("m_","m_recenh_") }, plural[1], plural[2] } }
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                local card_id = G.hand.highlighted[i].config.center_key
                local variant = card.ability.mod_conv:gsub("m_", "")
                local temp = {}
                local enh_id = "m_recenh_"
                for _, j in ipairs(card.ability.extra.enhancements) do
                    if (card_id:find(j) and j ~= variant) or (not card_id:find(j) and j == variant) then
                        temp[#temp + 1] = j
                        if enh_id == "m_recenh_" then
                            enh_id = enh_id .. j
                        else
                            enh_id = enh_id .. "X" .. j
                        end
                    end
                end
                if #temp == 1 then
                    enh_id = "m_" .. temp[1]
                elseif #temp == 0 then
                    enh_id = "c_base"
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(enh_id)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end,
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
        end
    }
)
SMODS.Consumable:take_ownership('devil',
    {
        atlas = "consumable",
        pos = { x = 2, y = 1 },
        config = { max_highlighted = 1, mod_conv = "m_gold", extra = { enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" } } },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            local plural = { "" , "" }
            if card.ability.max_highlighted ~= 1 then
                plural[1] = "up to "
                plural[2] = "s"
            end
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv:gsub("m_","m_recenh_") }, plural[1], plural[2] } }
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                local card_id = G.hand.highlighted[i].config.center_key
                local variant = card.ability.mod_conv:gsub("m_", "")
                local temp = {}
                local enh_id = "m_recenh_"
                for _, j in ipairs(card.ability.extra.enhancements) do
                    if (card_id:find(j) and j ~= variant) or (not card_id:find(j) and j == variant) then
                        temp[#temp + 1] = j
                        if enh_id == "m_recenh_" then
                            enh_id = enh_id .. j
                        else
                            enh_id = enh_id .. "X" .. j
                        end
                    end
                end
                if #temp == 1 then
                    enh_id = "m_" .. temp[1]
                elseif #temp == 0 then
                    enh_id = "c_base"
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(enh_id)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end,
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
        end
    }
)
SMODS.Consumable:take_ownership('magician',
    {
        atlas = "consumable",
        pos = { x = 0, y = 0 },
        config = { max_highlighted = 2, mod_conv = "m_lucky", extra = { enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" } } },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            local plural = { "" , "" }
            if card.ability.max_highlighted ~= 1 then
                plural[1] = "up to "
                plural[2] = "s"
            end
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv:gsub("m_","m_recenh_") }, plural[1], plural[2] } }
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                local card_id = G.hand.highlighted[i].config.center_key
                local variant = card.ability.mod_conv:gsub("m_", "")
                local temp = {}
                local enh_id = "m_recenh_"
                for _, j in ipairs(card.ability.extra.enhancements) do
                    if (card_id:find(j) and j ~= variant) or (not card_id:find(j) and j == variant) then
                        temp[#temp + 1] = j
                        if enh_id == "m_recenh_" then
                            enh_id = enh_id .. j
                        else
                            enh_id = enh_id .. "X" .. j
                        end
                    end
                end
                if #temp == 1 then
                    enh_id = "m_" .. temp[1]
                elseif #temp == 0 then
                    enh_id = "c_base"
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(enh_id)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end,
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
        end
    }
)
