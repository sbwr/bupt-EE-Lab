import pandas as pd

# fo = open("Electromagnetic-Lab\9无线信号\data.csv", "r")
data = pd.read_csv("Electromagnetic-Lab\9无线信号\data.csv")
# 第一组：图书馆门口广场
print("图书馆门口广场：")
print(data.OpenArea.describe())
# 第二组：教三室内
print("教三室内：")
print(data.Inside.describe())
# 第三组：科学会堂和主楼之间的道路
print("科学会堂和主楼之间的道路：")
print(data.Shadow.describe())
# 第四组：教一南侧道路
print("教一南侧道路：")
print(data.AlongBuilding.describe())
