function ua = Coef(fa, f)
%计算加权系数
%输入参数：
%fa——图像矩阵
%f——图像序列
%输出参数：
%ua——加权系数
N = length(f);
s = [];
for i = 1 : N
    fi = f{i};
    si = supoles(fi, f);
    s = [s si];
end
sp = min(s(:));
sa = supoles(fa, f);
ka = sp/sa; 
k = 0;
for i = 1 : N
    fb = f{i};
    s = [];
    for i = 1 : N
        fi = f{i};
        si = supoles(fi, f);
        s = [s si];
    end
    sp = min(s);
    sb = supoles(fb, f);
    kb = sp/sb; 
    k = k + kb;
end
ua = ka/k; 