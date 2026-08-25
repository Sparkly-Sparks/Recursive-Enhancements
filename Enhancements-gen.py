#This is the python code used to generate the "enhancements.lua" file (and the localization file).

Bases=["Lucky","Gold","Stone","Steel","Glass","Wild","Mult","Bonus"]
Desc='return[descriptions=[Tarot=[c_heirophant={name="The Hierophant",text={"Adds or removes","the {C:attention}#2#{} enhancement","from {}#3#{}{C:attention}#1#{} selected card{}#4#{}",},},c_empress={name="The Empress",text={"Adds or removes","the {C:attention}#2#{} enhancement","from {}#3#{}{C:attention}#1#{} selected card{}#4#{}",},},c_lovers={name="The Lovers",text={"Adds or removes","the {C:attention}#2#{} enhancement","from {}#3#{}{C:attention}#1#{} selected card{}#4#{}",},},c_justice={name="Justice",text={"Adds or removes","the {C:attention}#2#{} enhancement","from {}#3#{}{C:attention}#1#{} selected card{}#4#{}",},},c_chariot={name="The Chariot",text={"Adds or removes","the {C:attention}#2#{} enhancement","from {}#3#{}{C:attention}#1#{} selected card{}#4#{}",},},c_tower={name="The Tower",text={"Adds or removes","the {C:attention}#2#{} enhancement","from {}#3#{}{C:attention}#1#{} selected card{}#4#{}",},},c_devil={name="The Devil",text={"Adds or removes","the {C:attention}#2#{} enhancement","from {}#3#{}{C:attention}#1#{} selected card{}#4#{}",},},c_magician={name="The Magician",text={"Adds or removes","the {C:attention}#2#{} enhancement","from {}#3#{}{C:attention}#1#{} selected card{}#4#{}",},},],Enhanced=[m_recenh_key_slot=[name=name_slot,text=[text_slot]],enhance_slot]]]'
Desc_card='m_recenh_key_slot=[name=name_slot,text=[text_slot]],enhance_slot'
Enhancements_file='SMODS.Atlas{ key = "enhancement", path = "Enhancements.png", px = 71, py = 95 }\n'

def coords(num):
    num1=0
    num2=0
    while num>15:
        num1+=1
        num-=16
    num2=num
    return ([num1,num2])

def convert(num):
    digit=1
    power=0
    amount=0
    while num>0:
        if num>=digit*2:
            digit*=2
            power+=1
        elif num==1:
            amount+=1
            num-=1
        else:
            num-=digit
            digit=1
            amount+=10**power
            power=0
    return amount

file=open("enhancements/enhancements.lua","w")
file2=open("localization/en-us.lua","w")

for i in Bases:
    Desc=Desc.replace("key_slot",i.lower())
    Desc=Desc.replace("name_slot",'"'+i+'"')
    Desc=Desc.replace("[text_slot]",'{}')
    Desc=Desc.replace("enhance_slot",Desc_card)

for i in range(256):
    current=str(convert(i))
    current="0"*(8-len(current))+current
    if i in [0,1,2,4,8,16,32,64,128]:
        continue
    Bonus=Mult=Wild=Glass=Steel=Stone=Gold=Lucky=False
    if current[7]=="1":
        Bonus=True
    if current[6]=="1":
        Mult=True
    if current[5]=="1":
        Wild=True
    if current[4]=="1":
        Glass=True
    if current[3]=="1":
        Steel=True
    if current[2]=="1":
        Stone=True
    if current[1]=="1":
        Gold=True
    if current[0]=="1":
        Lucky=True
    pos=coords(i)
    selected=[]

    for j,num in enumerate(current):
        if num=="1":
            selected.append(Bases[j])

    num=len(selected)-1
    name=""
    key=""

    while num>=0:
        if key=="":
            key=selected[num].lower()
        else:
            key+="X"
            key+=selected[num].lower()
        name+=selected[num]+" "
        num-=1

    name+="Card"
    key=key
    print(i,name,key,pos)
    Card='SMODS.Enhancement { key = key_slot, name = name_slot, atlas = "enhancement", pos = { x = pos_slot1, y = pos_slot2 }, config = { config_slot extra_slot1 }, attribute_slot, vars_slot, calculate_slot1 }'
    Card=Card.replace("key_slot",'"'+key+'"')
    Card=Card.replace("name_slot",'"'+name+'"')
    Card=Card.replace("pos_slot1",str(pos[0]))
    Card=Card.replace("pos_slot2",str(pos[1]))
    Desc=Desc.replace("key_slot",key)
    Desc=Desc.replace("name_slot",'"'+name+'"')
    num=1
    if Bonus:
        if Stone:
            Desc=Desc.replace("text_slot",f'["[C:chips]+HHH{num}HHH[] chips"], text_slot')
        else:
            Desc=Desc.replace("text_slot",f'["[C:chips]+HHH{num}HHH[] extra chips"], text_slot')
        num+=1
        Card=Card.replace("config_slot","bonus = 30, config_slot")
        Card=Card.replace("vars_slot","loc_vars = function(self, info_queue, card) vars_extra_slot return { vars = { vars_info } } end")
        Card=Card.replace("vars_info","card.ability.bonus, vars_info")

    if Mult:
        Desc=Desc.replace("text_slot",f'["[C:mult]+HHH{num}HHH[] Mult"], text_slot')
        num+=1
        Card=Card.replace("config_slot","mult = 4, config_slot")
        Card=Card.replace("vars_slot","loc_vars = function(self, info_queue, card) vars_extra_slot return { vars = { vars_info } } end")
        Card=Card.replace("vars_info","card.ability.mult, vars_info")

    if Wild:
        Desc=Desc.replace("text_slot",'["Can be used","as any suit"], text_slot')
        Card=Card.replace("attribute_slot","any_suit = true, attribute_slot")

    if Glass:
        Desc=Desc.replace("text_slot",f'["[X:mult,C:white]XHHH{num}HHH[] Mult","[C:green]HHH{num+1}HHH in HHH{num+2}HHH[] chance to","destroy card"], text_slot')
        num+=3
        Card=Card.replace("config_slot","Xmult = 2, config_slot")
        Card=Card.replace("extra_slot1","extra = { odds = 4 extra_slot2 }")
        Card=Card.replace("attribute_slot","shatters = true, attribute_slot")
        Card=Card.replace("calculate_slot1","calculate = function(self, card, context)  calculate_slot2  if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.odds) then card.glass_trigger = true return { remove = true } end end")
        Card=Card.replace("vars_slot","loc_vars = function(self, info_queue, card) vars_extra_slot return { vars = { vars_info } } end")
        Card=Card.replace("vars_info","card.ability.Xmult, numerator, denominator, vars_info")
        Card=Card.replace("vars_extra_slot","local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, self.key) vars_extra_slot")

    if Steel:
        Desc=Desc.replace("text_slot",f'["[X:mult,C:white]XHHH{num}HHH[] Mult","while this card","stays in hand"], text_slot')
        num+=1
        Card=Card.replace("config_slot","h_x_mult = 1.5, config_slot")
        Card=Card.replace("vars_slot","loc_vars = function(self, info_queue, card) vars_extra_slot return { vars = { vars_info } } end")
        Card=Card.replace("vars_info","card.ability.h_x_mult, vars_info")

    if Stone:
        if not Bonus:
            Desc=Desc.replace("text_slot",f'["[C:chips]+HHH{num}HHH[] Chips", text_slot')
            num+=1
            Card=Card.replace("config_slot","bonus = 50, config_slot")
            Card=Card.replace("vars_slot","loc_vars = function(self, info_queue, card) vars_extra_slot return { vars = { vars_info } } end")
            Card=Card.replace("vars_info","card.ability.bonus, vars_info")
        else:
            Card=Card.replace("bonus = 30","bonus = 80")
        if Wild:
            Card=Card.replace("attribute_slot","replace_base_card = true,no_rank = true,always_scores = true, attribute_slot")
            if Bonus:
                Desc=Desc.replace("text_slot",'["no rank"], text_slot')
            else:
                Desc=Desc.replace("text_slot",'"no rank"], text_slot')
        else:
            Card=Card.replace("attribute_slot","replace_base_card = true,no_rank = true,no_suit = true,always_scores = true, attribute_slot")
            if Bonus:
                Desc=Desc.replace("text_slot",'["no rank or suit"], text_slot')
            else:
                Desc=Desc.replace("text_slot",'"no rank or suit"], text_slot')

    if Gold:
        Desc=Desc.replace("text_slot",f'["[C:money]$HHH{num}HHH[] if this","card is held in hand","at end of round"], text_slot')
        num+=1
        Card=Card.replace("config_slot","h_dollars = 3, config_slot")
        Card=Card.replace("vars_slot","loc_vars = function(self, info_queue, card) vars_extra_slot return { vars = { vars_info } } end")
        Card=Card.replace("vars_info","card.ability.h_dollars, vars_info")

    if Lucky:
        Desc=Desc.replace("text_slot",f'["[C:green]HHH{num}HHH in HHH{num+3}HHH[] chance","for [C:mult]+HHH{num+2}HHH[] Mult","[C:green]HHH{num+1}HHH in HHH{num+5}HHH[] chance","to win [C:money]$HHH{num+4}HHH"]')
        Card=Card.replace(" extra_slot2",", mult = 20, dollars = 20, mult_odds = 5, dollars_odds = 15 extra_slot2")
        Card=Card.replace("extra_slot1","extra = { mult = 20, dollars = 20, mult_odds = 5, dollars_odds = 15 extra_slot2 }")
        Card=Card.replace("vars_slot","loc_vars = function(self, info_queue, card) vars_extra_slot return { vars = { vars_info } } end")
        Card=Card.replace("vars_info","mult_numerator, dollars_numerator, card.ability.extra.mult, mult_denominator, card.ability.extra.dollars, dollars_denominator, vars_info")
        Card=Card.replace("vars_extra_slot","local mult_numerator, mult_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.mult_odds, self.key) local dollars_numerator, dollars_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.dollars_odds, self.key) vars_extra_slot")
        Card=Card.replace("calculate_slot2","if context.main_scoring and context.cardarea == G.play then local ret = {} if SMODS.pseudorandom_probability(card, 'vremade_lucky_mult', 1, card.ability.extra.mult_odds) then card.lucky_trigger = true ret.mult = card.ability.extra.mult end if SMODS.pseudorandom_probability(card, 'vremade_lucky_money', 1, card.ability.extra.dollars_odds) then card.lucky_trigger = true ret.dollars = card.ability.extra.dollars end return ret end")
        Card=Card.replace("calculate_slot1","calculate = function(self, card, context) if context.main_scoring and context.cardarea == G.play then local ret = {} if SMODS.pseudorandom_probability(card, 'vremade_lucky_mult', 1, card.ability.extra.mult_odds) then card.lucky_trigger = true ret.mult = card.ability.extra.mult end if SMODS.pseudorandom_probability(card, 'vremade_lucky_money', 1, card.ability.extra.dollars_odds) then card.lucky_trigger = true ret.dollars = card.ability.extra.dollars end return ret end end")

    Card=Card.replace(" config_slot","")
    Card=Card.replace(", attribute_slot","")
    Card=Card.replace(", vars_slot","")
    Card=Card.replace(", vars_info","")
    Card=Card.replace("vars_info","")
    Card=Card.replace(", vars_extra_slot","")
    Card=Card.replace(" vars_extra_slot","")
    Card=Card.replace("extra_slot1 ","")
    Card=Card.replace("extra_slot2 ","")
    Card=Card.replace(", calculate_slot1 ","")
    Card=Card.replace("calculate_slot2 ","")
    Desc=Desc.replace("HHH","#")
    Desc=Desc.replace(", text_slot","")
    Desc=Desc.replace("enhance_slot",Desc_card)
    Desc=Desc.replace("[","{")
    Desc=Desc.replace("]","}")
    Enhancements_file+=Card+"\n"
Desc=Desc.replace(",m_recenh_key_slot={name=name_slot,text={text_slot}},enhance_slot","")
print(Desc)
file.write(Enhancements_file)
file2.write(Desc)
file.close()
file2.close()
