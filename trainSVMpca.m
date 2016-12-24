function [m1,m2] = trainSVMpca(x)
m1=zeros(40,80);
m2=zeros(40,1);
for i=1:+8:320
    z=-ones(320,1);
    z(i:i+7) = 1;
    disp(size(x));
    disp(size(z));
    H = (x * x') .* (z * z');
    f= -ones(320,1);
    A= -eye(320);
    a=zeros(320,1);
    B=[[z]';[zeros(320-1,320)]];
    b= zeros(320,1);
    lb= zeros(320,1);
    ub= zeros(320,1);
    ub(:) = 100;
    alpha = quadprog(H+eye(320)*0.001, f, A, a, B, b,lb,ub);
    w= (alpha.*z)'*x;
    w=w';
    wo=(1/z(i,:))-w'*x(i,:)';
    m1(round(1+i/8),:)=w;
    m2(round(1+i/8),:)=wo;
end
end