# 本程序分两部分：
# 第一部分使用pandas分析数据特征；
# 第二部分使用matplot绘制数据累积分布函数Cumulative Distribution Function

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl

# fo = open("Electromagnetic-Lab\9无线信号\data.csv", "r")
data = pd.read_csv("Electromagnetic-Lab\9\data.csv")

# plot中汉字字体的显示控制
mpl.rcParams['font.sans-serif'] = ['DengXian', 'SimHei', 'FangSong']  # 汉字字体,优先使用等线，如果找不到楷体，则使用黑体
mpl.rcParams['font.size'] = 10  # 字体大小
mpl.rcParams['axes.unicode_minus'] = False  # 正常显示负号

# 导入开阔空间（图书馆门口广场）的数据为数组'OpenArea'
OpenArea = np.loadtxt(open("Electromagnetic-Lab\9\OpenArea.csv","rb"),delimiter=",",skiprows=0)
plt.figure(1)
# 数据分布直方图
hist, bin_edges = np.histogram(OpenArea)
plt.subplot(211)
plt.hist(OpenArea, bin_edges) 
plt.title("图书馆门口广场直方图") 
# 累积分布图
cdf = np.cumsum(hist)
plt.subplot(212)
plt.plot(cdf)
plt.title("图书馆门口广场CDF")
plt.show()

Inside = np.loadtxt(open("Electromagnetic-Lab\9\Inside.csv","rb"),delimiter=",",skiprows=0)
plt.figure(2)
# 数据分布直方图
hist, bin_edges = np.histogram(Inside)
plt.subplot(211)
plt.hist(Inside, bin_edges) 
plt.title("教三室内直方图") 
# 累积分布图
cdf = np.cumsum(hist)
plt.subplot(212)
plt.plot(cdf)
plt.title("教三室内CDF")
plt.show()

Shadow = np.loadtxt(open("Electromagnetic-Lab\9\Shadow.csv","rb"),delimiter=",",skiprows=0)
plt.figure(3)
# 数据分布直方图
hist, bin_edges = np.histogram(Shadow)
plt.subplot(211)
plt.hist(Shadow, bin_edges) 
plt.title("科学会堂和主楼之间的道路直方图") 
# 累积分布图
cdf = np.cumsum(hist)
plt.subplot(212)
plt.plot(cdf)
plt.title("科学会堂和主楼之间的道路CDF")
plt.show()

AlongBuilding = np.loadtxt(open("Electromagnetic-Lab\9\AlongBuilding.csv","rb"),delimiter=",",skiprows=0)
plt.figure(4)
# 数据分布直方图
hist, bin_edges = np.histogram(AlongBuilding)
plt.subplot(211)
plt.hist(AlongBuilding, bin_edges) 
plt.title("教三南侧道路直方图") 
# 累积分布图
cdf = np.cumsum(hist)
plt.subplot(212)
plt.plot(cdf)
plt.title("教三南侧道路CDF")
plt.show()



'''数据分布特征'''
# 第一组：图书馆门口广场
print("图书馆门口广场：")
print(data.OpenArea.describe())
# 第二组：教三室内
print("教三室内：")
print(data.Inside.describe())
# 第三组：科学会堂和主楼之间的道路
print("科学会堂和主楼之间的道路：")
print(data.Shadow.describe())
# 第四组：教三南侧道路
print("教三南侧道路：")
print(data.AlongBuilding.describe())
