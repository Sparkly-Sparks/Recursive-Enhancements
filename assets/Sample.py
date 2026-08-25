from PIL import Image
import os
from math import floor
def trim(Card,Type):
    Stone=[83,84,85,86,87,157,1346,1347,1417,1418,1489,2625,2628,2696,2699,2700,2701,2770,2771,2772,2773,2774,2841,2842,2843,2912,4258,4328,4329,4399,4400,4471,4616,4687,4688,4758,5962,6033,6562,6632,6633,6634,6644]
    Lucky1=[72,73,74,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,120,121,122,123,124,139,140,143,167,168,169,210,211,214,282,1986,2057,2128,2696,2767,2770,2836,2838,2841,2912,2977,2983,3054,3200,3271,3341,3411,3481,3551,3622,3974,4403,4474,4545,4616,4687,4755,4758,5678,5749,5819,5820,5891,5962,6029,6033,6104,6240,6530,6533,6561,6562,6600,6601,6604,6605,6606,6623,6624,6625,6628,6631,6632,6633,6634,6652,6653,6654,6655,6656,6657,6658,6659,6670,6671,6672]
    Lucky2=[110,268,341,1202,1616,1702,1990,2127,2131,2198,2483,2553,2623,2765,3059,3129,3412,3482,4119,5959,6038,6100,6170,6239,6346,6418,6463,6489,6490]
    Lucky3=[59,60,61,62,63,64,65,568,639,710,781,852,923,994,1065,1136,1207,1278,2414,2485,2556,3478,3549,3620,3691,3762,4117,4188,4259,5964,6035,6106,6177,6248,6319,6679,6680,6681,6682,6683,6684,6685,6686,6687,6688,6689,6712,6713,6714,6715,6716]
    Card=Card.convert("RGBA")
    data=Card.get_flattened_data()
    trimmed=[]
    for i,j in enumerate(data):
        if Type=="Stone":
            if i not in Stone:
                trimmed.append(j)
            else:
                trimmed.append((0,0,0,0))
        if Type=="Lucky":
            if i in Lucky2:
                trimmed.append((j[0],j[1],j[2],204))
            elif i in Lucky1:
                trimmed.append((0,0,0,0))
            elif i in Lucky3 and Glass=True:
                trimmed.append((0,0,0,0))
            else:
                trimmed.append(j)
    Lucky3=str(Lucky3).replace(" ","")
    print(Lucky3)
    Card.putdata(trimmed)
    image=Image.new("RGBA",(71,95),(0,0,0,0))
    image.alpha_composite(Card)
    Card=image
    return Card
current="1"
card_empty=True
if current[0]=="1":
    trim_lucky=True
    if card_empty:
        card_empty=False
        Card=Image.open("Elements/Lucky1.png")
    else:
        Layer=Image.open("Elements/Lucky.png")
        Card=blend(Card,Layer)
    if trim_lucky:
        Card=trim(Card,"Lucky")
        trim_lucky=False
    Card.save("Elements/Luckytest.png")
