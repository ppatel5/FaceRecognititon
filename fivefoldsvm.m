function fivefoldsvm
clc;    % Clear the command window.
workspace;  % Make sure the workspace panel is showing.

fold1=1;
fold2=1;
fold3=1;
fold4=1;
fold5=1;

foldtrain1=1;
foldtrain2=1;
foldtrain3=1;
foldtrain4=1;
foldtrain5=1;

crossValidationTrainDatafold1 = [];
crossValidationTrainDatafold2 = [];
crossValidationTrainDatafold3 = [];
crossValidationTrainDatafold4 = [];
crossValidationTrainDatafold5 = [];

crossValidationTestDatafold1 = [];
crossValidationTestDatafold2 = [];
crossValidationTestDatafold3 = [];
crossValidationTestDatafold4 = [];
crossValidationTestDatafold5 = [];

Actualfold1=cell([],1);  %actual class
Actualfold2=cell([],1);
Actualfold3=cell([],1);
Actualfold4=cell([],1);
Actualfold5=cell([],1);

Actualtrainfold1=cell([],1);  %actual class
Actualtrainfold2=cell([],1);
Actualtrainfold3=cell([],1);
Actualtrainfold4=cell([],1);
Actualtrainfold5=cell([],1);

start_path = fullfile(matlabroot, '.\att_faces\');
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
    return;
end
allSubFolders = genpath(topLevelFolder);
remain = allSubFolders;
listOfFolderNames = {};
while true
    [singleSubFolder, remain] = strtok(remain, ';');
    if isempty(singleSubFolder)
        break;
    end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames);
n=1;
startOfRow= 1;
for fold = 1:1:5
    n=1;
    for k = 2 : numberOfFolders
        
        thisFolder = listOfFolderNames{k};
        
        filePattern = sprintf('%s/*.pgm', thisFolder);
        baseFileNames = dir(filePattern);
        numberOfImageFiles = length(baseFileNames);
        crossValidationFolds = 5;
        numberOfRowsPerFold = numberOfImageFiles / crossValidationFolds;
        if numberOfImageFiles >= 1
%             Go through all those image files.
            testRows = startOfRow:startOfRow+numberOfRowsPerFold-1;
            if (startOfRow == 1)
                trainRows = [max(testRows)+1:numberOfImageFiles];
            else
                trainRows = [1:startOfRow-1 max(testRows)+1:numberOfImageFiles];
            end
            
            for f=1:1:8
                fullFileName = fullfile(thisFolder, baseFileNames(trainRows(f)).name);
                image = imread(fullFileName);
                vimage = reshape(double(image), 1, []);
                
                if(fold==1)
                    Actualtrainfold1{foldtrain1} = double(n);
                    foldtrain1 = foldtrain1+1;
                    crossValidationTrainDatafold1 = [crossValidationTrainDatafold1 ;vimage];
                elseif(fold==2)
                    Actualtrainfold2{foldtrain2} = double(n);
                    foldtrain2 = foldtrain2+1;
                    crossValidationTrainDatafold2 = [crossValidationTrainDatafold2 ;vimage];
                elseif(fold==3)
                    Actualtrainfold3{foldtrain3} = double(n);
                    foldtrain3 = foldtrain3+1;
                    crossValidationTrainDatafold3 = [crossValidationTrainDatafold3 ;vimage];
                elseif(fold==4)
                    Actualtrainfold4{foldtrain4} = double(n);
                    foldtrain4 = foldtrain4+1;
                    crossValidationTrainDatafold4 = [crossValidationTrainDatafold4 ;vimage];
                else
                    Actualtrainfold5{foldtrain5} = double(n);
                    foldtrain5 = foldtrain5+1;
                    crossValidationTrainDatafold5 = [crossValidationTrainDatafold5 ;vimage];
                end
            end
            for  f=1:1:2
                fullFileName = fullfile(thisFolder, baseFileNames(testRows(f)).name);
                image = imread(fullFileName);
                vimage = reshape(double(image), 1, []);
                
                if(fold==1)
                    Actualfold1{fold1} = double(n);
                    fold1 = fold1+1;
                    crossValidationTestDatafold1 = [crossValidationTestDatafold1 ;vimage];
                elseif(fold==2)
                    Actualfold2{fold2} = double(n);
                    fold2 = fold2+1;
                    crossValidationTestDatafold2 = [crossValidationTestDatafold2 ;vimage];
                elseif(fold==3)
                    Actualfold3{fold3} = double(n);
                    fold3 = fold3+1;
                    crossValidationTestDatafold3 = [crossValidationTestDatafold3 ;vimage];
                elseif(fold==4)
                    Actualfold4{fold4} = double(n);
                    fold4 = fold4+1;
                    crossValidationTestDatafold4 = [crossValidationTestDatafold4 ;vimage];
                else
                    Actualfold5{fold5} = double(n);
                    fold5 = fold5+1;
                    crossValidationTestDatafold5 = [crossValidationTestDatafold5 ;vimage];
                end
            end
        else
            fprintf('Folder %s has no image files in it.\n', thisFolder);
        end
        n=n+1;
    end
    startOfRow=startOfRow+2;
end

% pca and svm fold 1
[wfold1,w0fold1] = trainSVM(crossValidationTrainDatafold1);
disp('train done');
accuracyfold1 = testSVM(crossValidationTestDatafold1,wfold1,w0fold1,Actualfold1);

[wfold2,w0fold2] = trainSVM(crossValidationTrainDatafold2);
disp('train done');
accuracyfold2 = testSVM(crossValidationTestDatafold2,wfold2,w0fold2,Actualfold2);

[wfold3,w0fold3] = trainSVM(crossValidationTrainDatafold3);
disp('train done');
accuracyfold3 = testSVM(crossValidationTestDatafold3,wfold3,w0fold3,Actualfold3);

[wfold4,w0fold4] = trainSVM(crossValidationTrainDatafold4);
disp('train done');
accuracyfold4 = testSVM(crossValidationTestDatafold4,wfold4,w0fold4,Actualfold4);

[wfold5,w0fold5] = trainSVM(crossValidationTrainDatafold5);
disp('train done');
accuracyfold5 = testSVM(crossValidationTrainDatafold5,wfold5,w0fold5,Actualfold5);

disp(accuracyfold1);
disp(accuracyfold2);
disp(accuracyfold3);
disp(accuracyfold4);
disp(accuracyfold5);
disp((accuracyfold1+accuracyfold2+accuracyfold3+accuracyfold4+accuracyfold5)/5);
end

function [m1,m2] = trainSVM(x)
m1=zeros(40,10304);
m2=zeros(40,1);
for i=1:+8:320
    z=-ones(320,1);
    z(i:i+7) = 1;
%     disp(size(x));
%     disp(size(z));
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

function accuracy = testSVM(t,w,wo,Actual)
result = zeros(40,1);
testclass = zeros(40,1);
count =0;
for i=1:80
    x=t(i,:);
    for j=1:40
        r = w(j,:) * x' + wo(j,:);
%         disp(size(r));
        result(j,1)=r;
        testclass(j,1)=j;
    end
    [M,I] =max(result);
    testcase= testclass(I,:);
%     disp(testcase);
%     disp(Actual{i});
    if(testcase == Actual{i})
        count=count+1;
    end
    accuracy = (count/80)*100;
end
end
















