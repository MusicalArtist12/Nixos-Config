import os
import math
import random
import re
import matplotlib.pyplot as plt
import numpy as np

from collections.abc import Callable

print("""
import os
import math
import random
import re
import matplotlib.pyplot as plt
import numpy as np

graph_function(lambda x: (x**2 + 2*x + 1), (-10, 10), (-10, 10))
flip_a_coin()
roll_a_d(20)
""")
def flip_a_coin():
    return random.randint(0, 1)

def roll_a_d(count: int):
    return random.randint(1, count)



def graph_function(fun: Callable[[int], int], x_range: tuple[int, int], y_range: tuple[int, int], resolution: int = 5):
    if x_range[1] <= x_range[0]:
        print("x_range should be in the format (low, high)")
        return
    if y_range[1] <= y_range[0]:
        print("y_range should be in the format (low, high)")
        return

    x = np.linspace(x_range[0], x_range[1], abs(x_range[1] - x_range[0]) * resolution)
    y = fun(x)
    plt.axvline(x=0, linewidth=1.5, color="black")
    plt.axhline(y=0, linewidth=1.5, color="black")
    plt.plot(x, y)
    plt.xlabel("x")
    plt.ylabel("f(x)")
    plt.xlim(x_range[0], x_range[1])
    plt.ylim(y_range[0], y_range[1])
    plt.grid(True)
    plt.show()