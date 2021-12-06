f=[0]*9
gets.scan(/\d/){f[_1.hex]+=1}
256.times{f[(_1+7)%9]+=f[_1%9]}
p f.sum