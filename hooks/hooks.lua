local smods_has_enhancement = SMODS.has_enhancement
function SMODS.has_enhancement(playing_card, enhancement, ...)
    return playing_card.config.center_key:find(enhancement:gsub("m_","")) and playing_card.config.center_key:find("m_recenh") and true or smods_has_enhancement(playing_card, enhancement, ...)
end
