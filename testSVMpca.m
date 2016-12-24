function accuracy = testSVMpca(t,w,wo,Actual)
result = zeros(40,1);
testclass = zeros(40,1);
count =0;
for i=1:80
    x=t(i,:);
    for j=1:40
        r = w(j,:) * x' + wo(j,:);
        %disp(size(r));
        result(j,1)=r;
        testclass(j,1)=j;
    end
    [M,I] =max(result);
    testcase= testclass(I,:);
    %disp(testcase);
    %disp(Actual{i});
    if(testcase == Actual{i})
        count=count+1;
    end
    accuracy = (count/80)*100;
end
end