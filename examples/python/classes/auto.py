class Race:
    '''Рейс'''
    def __init__(self, route, price, places):
        self.route = route
        self.prices = price
        self.places = places
        self.dates = {}

    def reserv(self, date, places):
        reserved = self.dates[date]
        if places + reserved > self.places:
            raise Exception
        else:
            self.dates[date] = reserved + places

class Order:
    NEW = "New"
    RESERVED = "Reserved"
    PAYED = "Payed"
    CANCELED = "Canceled"

    def __init__(self, town, race, date, places, carrage):
        self.town = town
        self.race = race
        self.date = date
        self.places = places
        self.carrage = carrage
        self.state = Order.NEW

    def reserv(self):
        if self.state == Order.NEW:
            try:
                self.race.reserv()
                self.state = Order.RESERVED
            except:
                raise Exception    
        else:
            raise Exception

class System:
    t1 = "Spas-Klepiki"
    t2 = "Tuma"
    t3 = "Kasimov"

    rc1 = Race(t1, 150, 20)
    rc2 = Race(t2, 450, 10)
    rc3 = Race(t3, 750, 20)

    orders = []

    def order(self, race, town, date, places, carrage):
        new_order = Order(town, race, date, places, carrage)
        self.orders.append(new_order)

    def reserv(self, order):
        order.reserv()

