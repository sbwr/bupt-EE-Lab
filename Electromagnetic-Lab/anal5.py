import math
# group1
a = 40; b = 80; lam = 32
# group2
a = 30; b = 70; lam = 32
# group3
a = 30; b = 60; lam = 32
print("极大")
for k in [0, 1, 2, 3, 4]:
    tmp = k * lam/(a + b)
    if(tmp < 1): # 极大点(°)
        print(round( math.asin(tmp)/math.pi*180, 3))
print("极小")
for k in [0, 1, 2, 3, 4]:
    tmp = (2*k + 1) * lam / (a + b) /2
    if(tmp < 1): # 极小点(°)
        print(round( math.asin(tmp)/math.pi*180, 3))