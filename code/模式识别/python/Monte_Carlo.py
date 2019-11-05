import pandas as pd
import os
import matplotlib.pyplot as plt
import numpy as np
import random

trainFile = r'E:\毕业设计\声扫模式识别\data\fail_original_data.csv'
pwd = os.getcwd()
os.chdir(os.path.dirname(trainFile))
trainData = pd.read_csv(os.path.basename(trainFile))
#
#
# y0 = trainData['fail'].tolist()
# y = [x for x in y0 if str(x) != 'nan']
# count = [0 for i in range(10)]
# for j in y:
#     site = int(np.floor(j/0.1))
#     if site == 10:
#         site = 9
#     count[site] += 1
# fre = [count[k]/(len(y)+1) for k in range(len(count))]
# count_sim = [int(802 * m + np.random.normal(10, 1, 1)) for m in fre]
# sim_result_fail = []
# for n in range(10):
#     down = n * 0.1
#     upper = n * 0.1 + 0.1
#     sim_result_fail += [round(random.uniform(down, upper), 3) for k in range(count_sim[n])]
# x = [i for i in range(len(y))]
# f1 = plt.figure(1)
# plt.subplot(121)
# plt.scatter(x, y, 5)
# val = [round(0.1*v, 2) for v in range(10)]
# plt.subplot(122)
# plt.bar(val, count, 0.03)
# f2 = plt.figure(2)
# x2 = range(len(sim_result_fail))
# plt.subplot(121)
# plt.scatter(x2, sim_result_fail, 0.01)
# plt.subplot(122)
# plt.bar(val, count_sim, 0.03)
#
# y0 = trainData['unfail'].tolist()
# y = [x for x in y0 if str(x) != 'nan']
# count = [0 for i in range(10)]
# for j in y:
#     site = int(np.floor(j/0.02))
#     if site == 10:
#         site = 9
#     count[site] += 1
# fre = [count[k]/(len(y)+1) for k in range(len(count))]
# count_sim = [int(1176 * m + np.random.normal(10, 1, 1)) for m in fre]
# sim_result_unfail = []
# for n in range(10):
#     down = n * 0.02
#     upper = n * 0.02 + 0.02
#     sim_result_unfail += [round(random.uniform(down, upper), 3) for k in range(count_sim[n])]
# x = [i for i in range(len(y))]
# f1 = plt.figure(3)
# plt.subplot(121)
# plt.scatter(x, y, 5)
# val = [round(0.02*v, 2) for v in range(10)]
# plt.subplot(122)
# plt.bar(val, count, 0.006)
# f2 = plt.figure(4)
# x2 = range(len(sim_result_unfail))
# plt.subplot(121)
# plt.scatter(x2, sim_result_unfail, 0.01)
# plt.subplot(122)
# plt.bar(val, count_sim, 0.006)
# plt.show()

# zero = [0 for i in range(4476)]
# label_fail = [1 for w in range(len(sim_result_fail))]
# label_unfail = [-1 for w in range(len(sim_result_unfail))]
# label_zero = [-1 for w in range(len(zero))]
# sim_data = sim_result_fail + sim_result_unfail + zero
# sim_data_label = label_fail + label_unfail + label_zero
# list_random = random.sample(range(0, len(sim_data_label)), len(sim_data_label))
# random_data_original = np.array([[sim_data[r]] for r in list_random])
# random_label_original = np.array([[sim_data_label[r]] for r in list_random])
# sim_data_random_original = np.hstack((random_data_original, random_label_original))
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_unbalance_original_data.txt", sim_data_random_original, fmt=['%.4f']*sim_data_random_original.shape[1], newline='\n')
#
# list_random_fail = random.sample(range(0, 800), 800)
# random_data_fail = [sim_result_fail[r] for r in list_random_fail]
# list_random_unfail = random.sample(range(0, 700), 700)
# random_data_unfail = [sim_result_unfail[r] for r in list_random_unfail]
# zero = [0 for i in range(100)]
# sim_data_balance = random_data_fail + random_data_unfail + zero
# label_fail = [1 for w in range(800)]
# label_unfail = [-1 for w in range(800)]
# label_balance = label_fail + label_unfail
# random_data_balance = np.array([[sim_data_balance[r]] for r in range(1600)])
# random_label_balance = np.array([[label_balance[r]] for r in range(1600)])
# sim_data_balance_original = np.hstack((random_data_balance, random_label_balance))
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_balance_data.txt", sim_data_balance_original, fmt=['%.4f']*sim_data_balance_original.shape[1], newline='\n')
#
# list_random = random.sample(range(0, 800), 800)
# recalling_data_unfail = [sim_result_unfail[r] for r in list_random[0:160]]
# recalling_label_unfail = [-1 for r in range(160)]
# sim_data_recalling = random_data_fail + recalling_data_unfail
# recalling_label = label_fail + recalling_label_unfail
# recalling_data = np.array([[sim_data_recalling[r]] for r in range(960)])
# label_recalling = np.array([[recalling_label[r]] for r in range(960)])
# data_recalling = np.hstack((recalling_data, label_recalling))
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_recalling_data.txt", data_recalling, fmt=['%.4f']*data_recalling.shape[1], newline='\n')
#
# list_random = random.sample(range(0, 960), 960)
# random_data_train = np.array([[sim_data_recalling[r]] for r in list_random[0:760]])
# random_label_train = np.array([[recalling_label[r]] for r in list_random[0:760]])
# sim_data_random_train = np.hstack((random_data_train, random_label_train))
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_balance_train.txt", sim_data_random_train, fmt=['%.4f']*sim_data_random_train.shape[1],newline='\n')
# # sim_data_random = pd.DataFrame({'area_ratio': random_data, 'label': random_label})
# # sim_data_random.to_csv(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo.csv", encoding="utf-8")
# random_data_test = np.array([[sim_data_recalling[r]] for r in list_random[760:len(list_random)]])
# random_label_test = np.array([[recalling_label[r]] for r in list_random[760:len(list_random)]])
# sim_data_random_test = np.hstack((random_data_test, random_label_test))
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_balance_test.txt", sim_data_random_test, fmt=['%.4f']*sim_data_random_test.shape[1],newline='\n')



# with open(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_recalling_data.txt") as original_data:
#     lines = original_data.readlines()
#     data = []
#     for line in lines:
#         temp = [float(i) for i in line.split()]
#         data.append(temp[0])
# data_a = np.array([[data[r]] for r in range(len(lines))])
# label = [1 for j in range(800)] + [-1 for j in range(160)]
# label_a = np.array([[label[r]] for r in range(len(lines))])
# data_recalling = np.hstack((data_a, label_a))
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_recalling.txt", data_recalling, fmt=['%.4f']*data_recalling.shape[1], newline='\n')
# list_random = random.sample(range(0, 960), 960)
# random_data_train = np.array([[data[r]] for r in list_random[0:760]])
# random_label_train = np.array([[label[r]] for r in list_random[0:760]])
# sim_data_random_train = np.hstack((random_data_train, random_label_train))
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_train.txt", sim_data_random_train, fmt=['%.4f']*sim_data_random_train.shape[1], newline='\n')
# # sim_data_random = pd.DataFrame({'area_ratio': random_data, 'label': random_label})
# # sim_data_random.to_csv(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo.csv", encoding="utf-8")
# random_data_test = np.array([[data[r]] for r in list_random[760:len(list_random)]])
# random_label_test = np.array([[label[r]] for r in list_random[760:len(list_random)]])
# sim_data_random_test = np.hstack((random_data_test, random_label_test))
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_test.txt", sim_data_random_test, fmt=['%.4f']*sim_data_random_test.shape[1], newline='\n')
#

# with open(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_recalling.txt") as original_data:
#     lines = original_data.readlines()
#     data = []
#     label = []
#     for line in lines:
#         temp = [float(i) for i in line.split()]
#         data.append(temp[0])
#         label.append(temp[1])
# list_random = random.sample(range(0, len(lines)), len(lines))
# data_a = [data[i] for i in list_random]
# label_a = [label[i] for i in list_random]
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\data_recalling.txt", data_a, newline='\n')
# np.savetxt(r"E:\毕业设计\声扫模式识别\data\label_recalling.txt", label_a, newline='\n')
# original_data.close()

with open(r"E:\毕业设计\声扫模式识别\data\Monte_Carlo_balance_data.txt") as original_data:
    lines = original_data.readlines()
    data = []
    label = []
    for line in lines:
        temp = [float(i) for i in line.split()]
        data.append(temp[0])
        label.append(temp[1])
list_random = random.sample(range(0, len(lines)), len(lines))
cut_off = int(0.8 * len(list_random))
data_train = np.array([[data[i]] for i in list_random[0:cut_off]])
label_train = np.array([[label[i]] for i in list_random[0:cut_off]])
data_original_train = np.hstack((data_train, label_train))
np.savetxt(r"E:\毕业设计\声扫模式识别\data\data_balance_train.txt", data_original_train, fmt=['%.4f']*data_original_train.shape[1], newline='\n')
data_test = np.array([[data[i]] for i in list_random[cut_off:len(list_random)]])
label_test = np.array([[label[i]] for i in list_random[cut_off:len(list_random)]])
data_original_test = np.hstack((data_test, label_test))
np.savetxt(r"E:\毕业设计\声扫模式识别\data\data_balance_test.txt", data_original_test, fmt=['%.4f']*data_original_test.shape[1], newline='\n')

original_data.close()