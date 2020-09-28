def fun(a, b):
    return a*2 + b

class Lamp:
    Material = "Glass"   

    def __init__(self, color="White"):
        print('New lamp is created')
        self.State = False  
        self.__color = color 
        
    @property
    def color(self):
        return self.__color
    
    @color.setter
    def color(self, value):
        if value == "Black":
            raise Exception
        self.__color = value      

    def TurnOn(self):
        self.State = True        
        print('Lamp is on!')

    def TurnOff(self):
        self.State = False        
        print('Lamp is off!')

    def IsTurnedOn(self):
        return self.State

    def __str__(self):
        return f"Lamp({self.State}, color: {self.color})"

    def __bool__(self):
        return self.State

lamp1 = Lamp("Red")
lamp1.color = "Blue"
print(lamp1.color)
# lamp1.color = "Black"
print(dir(lamp1))

# print(lamp1.Material)
# lamp1.Material = "Plastic"
# print(lamp1.Material)

# Lamp.Material = "Plastic"

# lamp2 = Lamp()
# print(lamp2)

# print(lamp2.Color)
# print(lamp2.Material)

# # None [] "" () {} 
# # if lamp1.IsTurnedOn():
# lamp1.TurnOn()

# # if lamp1.__bool__()
# if lamp1:
#     print('Let it be light!')
# else: 
#     print('Dark...')

# lamp1.TurnOn()
# print(fun)
Lamp.TurnOn(lamp1)
print(lamp1._Lamp__color)

# lamp1.TurnOn()

# if lamp1.IsTurnedOn():
#     print('Let it be light!')
# else: 
#     print('Dark...')

# lamp1.TurnOff()

# print(dir(lamp1))
