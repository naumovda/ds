class Figure:
    def __init__(self, x=0, y=0, visible=False):
        print("Base constructor")
        self.x = x
        self.y = y
        self.visible = visible

    def show(self):
        self.visible = True

    def hide(self):
        self.visible = False

    def isVisible(self):
        return self.visible

    def move_to(self, x, y):
        self.x = x
        self.y = y

    def move_offset(self, dx, dy):
        self.x += dx
        self.y += dy

    def __str__(self):
        raise NotImplementedError

class Point(Figure):
    def __init__(self, x=0, y=0, visible=False, color=None):
        print("Point constructor")        
        super().__init__(x, y, visible)
        self.color = color 

    def __str__(self):
        return f"({self.x}, {self.y}, visible={self.visible}, color={self.color})"    

class LineSegment(Figure):
    def __init__(self, x, y, x1, y1, visible=False, color="WHITE"):
        print("Line Segment constructor")        
        super().__init__(x, y, visible)
        self.points = []
        self.points.append(Point(x, y, visible, color))
        self.points.append(Point(x1, y1, visible, color))

    def move_offset(self, dx, dy):
        super().move_offset(dx, dy)
        for point in self.points:
            point.move_offset(dx, dy)

    def __str__(self):
        p1 = self.points[0]
        p2 = self.points[1]
        return f"({p1.x}, {p1.y}, {p1.x}, {p2.y}, visible={self.visible}, color={p1.color})"    

if __name__ == "__main__":
    # f = Figure(10, -10)
    # print(f"x = {f.x}, y={f.y} visible={f.visible}")

    # p = Point(20, -15, True, "BLACK")
    # print(f"x = {p.x}, y={p.y} visible={p.visible}, color={p.color}")
    # print(p)

    line = LineSegment(0, 0, 10, 10)
    print(line)
    line.move_offset(5, 5)
    print(line) 


