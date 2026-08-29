SMODS.Joker:take_ownership('vampire',
    {
        config = { extra = { Xmult_gain = 0.1,Xmult = 1,enhancements = {"bonus","mult","wild","glass","steel","stone","gold","lucky"} } },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
        end,
        calculate = function(self, card, context)
            if context.before and not context.blueprint then
                local enhanced = {}
                for _, scored_card in ipairs(context.scoring_hand) do
                    if next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff and not scored_card.vampired then
                        if next(SMODS.get_enhancements(scored_card)):find("recenh") then
                            for _, i in ipairs(card.ability.extra.enhancements) do
                                if next(SMODS.get_enhancements(scored_card)):find(i) then
                                    enhanced[#enhanced + 1] = true
                                end
                            end
                        else
                            enhanced[#enhanced + 1] = true
                        end
                        scored_card.vampired = true
                        scored_card:set_ability('c_base', nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:juice_up()
                                scored_card.vampired = nil
                                return true
                            end
                        }))
                    end
                end
                if #enhanced > 0 then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain * #enhanced
                        return
                            {
                                message = localize { type = 'variable', key = 'a_xmult_plus', vars = { #enhanced / 10 } },
                                colour = G.C.MULT,
                            }
                end
            end
            if context.joker_main then
                return { xmult = card.ability.extra.Xmult }
            end
        end

    }
)
SMODS.Joker:take_ownership('midas_mask',
    {
        calculate = function(self, card, context)
            local enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" }
            if context.before and not context.blueprint then
                local faces = 0
                for _, scored_card in ipairs(context.scoring_hand) do
                    if scored_card:is_face() then
                        faces = faces + 1
                        local card_id = scored_card.config.center_key
                        local variant = "gold"
                        local temp = {}
                        local enh_id = "m_recenh_"
                        for _, j in ipairs(enhancements) do
                            if (card_id:find(j) or j == variant) then
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
                        scored_card:set_ability(enh_id, nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:juice_up()
                                return true
                            end
                        }))
                    end
                end
                if faces > 0 then
                    return {
                        message = localize('k_gold'),
                        colour = G.C.MONEY
                    }
                end
            end
        end
    }
)

SMODS.Joker:take_ownership('drivers_license',
    {
        key = "drivers_license",
        unlocked = false,
        blueprint_compat = true,
        rarity = 3,
        cost = 7,
        pos = { x = 0, y = 7 },
        config = { extra = { xmult = 3, driver_amount = 16, enhancements = { "bonus", "mult", "wild", "glass", "steel", "stone", "gold", "lucky" } } },
        loc_vars = function(self, info_queue, card)
            local driver_tally = 0
            local enh_id = ""
            for _, playing_card in pairs(G.playing_cards or {}) do
                if next(SMODS.get_enhancements(playing_card)) then
                    enh_id = next(SMODS.get_enhancements(playing_card))
                    if enh_id:find("m_recenh_") then
                        for _, enhancement in pairs(self.config.extra.enhancements) do
                            if enh_id:find(enhancement) then driver_tally = driver_tally + 1 end
                        end
                    else
                        driver_tally = driver_tally + 1
                    end
                end
            end
            return { vars = { card.ability.extra.xmult, driver_tally } }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local driver_tally = 0
                local enh_id = ""
                for _, playing_card in pairs(G.playing_cards or {}) do
                    if next(SMODS.get_enhancements(playing_card)) then
                        enh_id = next(SMODS.get_enhancements(playing_card))
                        if enh_id:find("m_recenh_") then
                            for _, enhancement in pairs(self.config.extra.enhancements) do
                                if enh_id:find(enhancement) then driver_tally = driver_tally + 1 end
                            end
                        else
                            driver_tally = driver_tally + 1
                        end
                    end
                end
                if driver_tally >= card.ability.extra.driver_amount then
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end,
        locked_loc_vars = function(self, info_queue, card)
            return { vars = { 16 } }
        end,
        check_for_unlock = function(self, args)
            if args.type == 'modify_deck' then
                local driver_tally = 0
                local enh_id = ""
                for _, playing_card in ipairs(G.playing_cards or {}) do
                    if next(SMODS.get_enhancements(playing_card)) then
                        enh_id = next(SMODS.get_enhancements(playing_card))
                        if enh_id:find("m_recenh_") then
                            for _, enhancement in pairs(self.config.extra.enhancements) do
                                if enh_id:find(enhancement) then driver_tally = driver_tally + 1 end
                            end
                        else
                            driver_tally = driver_tally + 1
                        end
                    end
                end
                if driver_tally >= 16 then
                    return true
                end
            end
            return false
        end
    }
)
