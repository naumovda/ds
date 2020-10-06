gender = lambda n: 'female' if n==1 else 'male'

names = {
    3: ('миллард', 'милларда','миллардов'),
    2: ('миллион', 'миллиона','миллионов'),
    1: ('тысяча', 'тысячи','тысяч'),
    0: ('', '','')
}

def index(n):
    if n == 1:
        return 0
    elif n in [2, 3, 4]:
        return 1
    else:
        return 2

def divide(n):
    res = []
    while n > 0:
        res.append(n%1000)
        n //= 1000
    return res

def digit(n, gender):
    d = {
        0: {'male':'ноль', 'female':'ноль'},
        1: {'male':'один', 'female':'одна'},
        2: {'male':'два', 'female':'две'},
        3: {'male':'три', 'female':'три'},
        4: {'male':'четыре', 'female':'четыре'},
        5: {'male':'пять', 'female':'пять'},
        6: {'male':'шесть', 'female':'шесть'},
        7: {'male':'семь', 'female':'семь'},
        8: {'male':'восемь', 'female':'восемь'},
        9: {'male':'девять', 'female':'девять'},
        10: {'male':'десять', 'female':'десять'},
        11: {'male':'одиннадцать', 'female':'одиннадцать'},
        12: {'male':'двенадцать', 'female':'двенадцать'},
        13: {'male':'тринадцать', 'female':'тринадцать'},
        14: {'male':'четырнадцать', 'female':'четырнадцать'},
        15: {'male':'пятнадцать', 'female':'пятнадцать'},
        16: {'male':'шестнадцать', 'female':'шестнадцать'},
        17: {'male':'семнадцать', 'female':'семнадцать'},
        18: {'male':'восемнадцать', 'female':'восемнадцать'},
        19: {'male':'девятнадцать', 'female':'девятнадцать'},
        20: {'male':'двадцать', 'female':'двадцать'},
        30: {'male':'тридцать', 'female':'тридцать'},
        40: {'male':'сорок', 'female':'сорок'},
        50: {'male':'пятьдесят', 'female':'пятьдесят'},
        60: {'male':'шестьдесят', 'female':'шестьдесят'},        
        70: {'male':'семьдесят', 'female':'семьдесят'},
        80: {'male':'восеьдесят', 'female':'восеьдесят'},
        90: {'male':'девяносто', 'female':'девяносто'},
        100: {'male':'сто', 'female':'сто'},
        200: {'male':'двести', 'female':'двести'},
        300: {'male':'триста', 'female':'триста'},
        400: {'male':'четыреста', 'female':'четыреста'},
        500: {'male':'пятьсот', 'female':'пятьсот'},
        600: {'male':'шестьсот', 'female':'шестьсот'},
        700: {'male':'семьсот', 'female':'семьсот'},
        800: {'male':'восемьсот', 'female':'восемьсот'},
        900: {'male':'девятьсот', 'female':'девятьсот'}
    } 
    return d[n][gender]

d = divide(2120511)

s = ''
for i in range(len(d)-1,-1,-1):    
    d3 = d[i]//100*100
    if d3: s += digit(d3, gender(i)) + ' '

    d4 = d[i]%100
    if 9<d4<20:
        s += digit(d4, gender(i)) + ' '
    else:
        d4_1 = d4//10*10
        if d4_1: s += digit(d4_1, gender(i)) + ' '
        d4_2 = d4%10
        if d4_2: s += digit(d4_2, gender(i)) + ' '
    
    if d[i]:
        s += names[i][index(d[i]%10)] + ' '

print(s)