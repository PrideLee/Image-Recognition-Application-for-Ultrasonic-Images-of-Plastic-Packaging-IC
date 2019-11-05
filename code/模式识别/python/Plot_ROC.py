from numpy import *
import csv
import matplotlib.pyplot as plt

csvFile = open(r"E:\毕业设计\声扫模式识别\data\ROC.csv", "r")
reader = csv.reader(csvFile)  # 返回的是迭代类型
data = []
for item in reader:
    data.append(item)
csvFile.close()

predStrengths = data[0]
classLabels = data[1]
classLabels = [float(i) for i in classLabels]
# variable to calculate AUC
ySum = 0.0
# 对正样本的进行求和
numPosClas = sum(array(classLabels) == 1.0)
# 正样本的概率
yStep = 1 / float(numPosClas)
# 负样本的概率
xStep = 1 / float(len(classLabels) - numPosClas)

# 开始创建模版对象
fig = plt.figure()
fig.clf()
ax = plt.subplot(111)
# cursor光标值
cur = (1.0, 1.0)
# loop through all the values, drawing a line segment at each point
for index in predStrengths:
    index = int(index)
    if classLabels[index] == 1.0:
        delX = 0
        delY = yStep
    else:
        delX = xStep
        delY = 0
        ySum += cur[1]
    # draw line from cur to (cur[0]-delX, cur[1]-delY)
    # 画点连线 (x1, x2, y1, y2)
    # print(cur[0], cur[0]-delX, cur[1], cur[1]-delY)
    ax.plot([cur[0], cur[0] - delX], [cur[1], cur[1] - delY], c='b')
    cur = (cur[0] - delX, cur[1] - delY)
ax.plot([cur[0], cur[0] - delX], [cur[1], cur[1] - delY], c='b', label='original data')
cur = (1.0, 1.0)
predStrengths = data[2]
classLabels = data[3]
classLabels = [float(i) for i in classLabels]
# variable to calculate AUC
ySum = 0.0
# 对正样本的进行求和
numPosClas = sum(array(classLabels) == 1.0)
# 正样本的概率
yStep = 1 / float(numPosClas)
# 负样本的概率
xStep = 1 / float(len(classLabels) - numPosClas)
# loop through all the values, drawing a line segment at each point
for index in predStrengths:
    index = int(index)
    if classLabels[index] == 1.0:
        delX = 0
        delY = yStep
    else:
        delX = xStep
        delY = 0
        ySum += cur[1]
    # draw line from cur to (cur[0]-delX, cur[1]-delY)
    # 画点连线 (x1, x2, y1, y2)
    # print(cur[0], cur[0]-delX, cur[1], cur[1]-delY)
    ax.plot([cur[0], cur[0] - delX], [cur[1], cur[1] - delY], c='r')
    cur = (cur[0] - delX, cur[1] - delY)
ax.plot([cur[0], cur[0] - delX], [cur[1], cur[1] - delY], c='r', label='balance data')
cur = (1.0, 1.0)
predStrengths = data[4]
classLabels = data[5]
classLabels = [float(i) for i in classLabels]
# variable to calculate AUC
ySum = 0.0
# 对正样本的进行求和
numPosClas = sum(array(classLabels) == 1.0)
# 正样本的概率
yStep = 1 / float(numPosClas)
# 负样本的概率
xStep = 1 / float(len(classLabels) - numPosClas)
# loop through all the values, drawing a line segment at each point
for index in predStrengths:
    index = int(index)
    if classLabels[index] == 1.0:
        delX = 0
        delY = yStep
    else:
        delX = xStep
        delY = 0
        ySum += cur[1]
    # draw line from cur to (cur[0]-delX, cur[1]-delY)
    # 画点连线 (x1, x2, y1, y2)
    # print(cur[0], cur[0]-delX, cur[1], cur[1]-delY)
    ax.plot([cur[0], cur[0] - delX], [cur[1], cur[1] - delY], c='g')
    cur = (cur[0] - delX, cur[1] - delY)
ax.plot([cur[0], cur[0] - delX], [cur[1], cur[1] - delY], c='g', label='comprehensive recalling')
# 画对角的虚线线
ax.plot([0, 1], [0, 1], 'b--')
plt.xlabel('False positive rate')
plt.ylabel('True positive rate')
plt.title('ROC curve for AdaBoost horse colic detection system')
# 设置画图的范围区间 (x1, x2, y1, y2)
ax.axis([0, 1, 0, 1])
plt.legend(loc = 'upper right')
plt.show()



