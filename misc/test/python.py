

s: float = 20
m: float = 255 # $(brightnessctl max); 
c: float = 0


def t(d: float) -> float:
    b: float = 1 + 1 / s
    p: float = (b ** (c / m * s + d) - 1) / (b ** s - 1)
    return round(p * m)

for i in range(s + 1):
    # print(c)
    # c = a(1)
    c = m / s * i # $(brightnessctl get); 
    print(t(0))
