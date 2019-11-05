# Image-Recognition-Application-for-Ultrasonic-Images-of-Plastic-Packaging-IC
- Aerospace plastic packaging components are in high demand as reliability, and scanning acoustic microscope screening test is an effective tool to ensure them reability in space environment. I use image processing and machine learning technology to segment and recognize the failure ultrasonic image of plastic components.
- The data exist a sort of unbalance and cost sensitive problem, I introduce cost-sensitive learning. Calculating the integrated adjustment ratio to balance the sample distribution and making classifier sensitive. Based on YOLO-v3 network to classified the components, then according failure standards, I utilize image processing technology to extract features. Besides I also train and compare differen classifers accuracy.
- Finally, relying on above research, I developed a failure recognition tool of plastic part acoustic scanning image to reduce the operating pressure and special knowledge requirements of technicians.

**You can download the full report from [here](https://github.com/PrideLee/Image-Recognition-Application-for-Ultrasonic-Images-of-Plastic-Packaging-IC/blob/master/Image%20Recognition%20Application%20for%20Ultrasonic%20Images%20of%20Plastic%20Packaging%20IC.pdf).**

## 摘要
航天用元器件对可靠性的要求极为严格，超声波扫描显微镜检筛选试验是保证元器件在空间环境下不发生失效的有效手段。然而，传统的塑封器件超声波扫描显微镜检技术极大依赖于技术人员的主观感觉和知识经验，识别准确率有限且易发生“误拒”的风险。本文首次利用图像处理和机器学习技术对塑封器件扫描图片进行失效识别，该方法不需要技术人员过多的参与，提高了识别精度与效率，同时具有较强的创新性和现实的研究价值。

塑封器件在空间环境中的应用存在较大的失效风险，塑封分层是元器件十分常见的失效形式，超声波扫描显微镜检技术能够准确的筛选出存在分层的元器件。对此本论文参考国军标等相关标准，设计标红区域面积比率作为失效特征描述子，并利用图像处理的方法提取失效特征。针对失效元器件数据的样本分布不平衡性和普通分类器假设所有分类错误代价一致的局限，本论文引入代价敏感学习机制。通过计算综合调整比，利用下采样的方法使样本分布平衡化，同时使分类器具有代价敏感性。结果表明经过代价敏感和样本分布平衡化处理后，分类器的查准率和查全率均得到了明显提升。此外本论文还对比了几种常见学习器的性能，分析结果知，AdaBoost、支持向量机、PNN 概率神经网络、GRNN 广义回归神经网络均有较好的分类性能，可以用于实际的塑封器件超声波扫描显微图片失效识别中。

本论文根据上述相关工作成果，编写塑封器件声扫失效图像识别工具，实现塑封器件超声波扫描显微图片分割、失效特征提取及失效识别过程的可视化，减轻技术人员的操作压力和认知负担。同时友好的人机交互功能也使得本论文的工作更具实际的商用价值和现实的研究意义。

**关键词：航天用塑封器件，超声波扫描，图像识别，代价敏感**

<div align=center><img width="700" height="500" src="https://github.com/PrideLee/Image-Recognition-Application-for-Ultrasonic-Images-of-Plastic-Packaging-IC/blob/master/reform_1.png"/></div>

<div align=center><img width="700" height="400" src="https://github.com/PrideLee/Image-Recognition-Application-for-Ultrasonic-Images-of-Plastic-Packaging-IC/blob/master/tool.png"/></div>


