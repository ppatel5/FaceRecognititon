function pcalda
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

Actualfold1=[];  %actual class
Actualfold2=[];
Actualfold3=[];
Actualfold4=[];
Actualfold5=[];
Actualtrainfold1=[];  %actual class
Actualtrainfold2=[];
Actualtrainfold3=[];
Actualtrainfold4=[];
Actualtrainfold5=[];
% Define a starting folder.
start_path = fullfile(matlabroot, '.\att_faces\');
% Ask user to confirm or change.
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
            testRows = startOfRow:startOfRow+numberOfRowsPerFold-1;
            if (startOfRow == 1)
                trainRows = [max(testRows)+1:numberOfImageFiles];
            else
                trainRows = [1:startOfRow-1 max(testRows)+1:numberOfImageFiles];
            end
            %end
            for f=1:1:8
                fullFileName = fullfile(thisFolder, baseFileNames(trainRows(f)).name);
                image = imread(fullFileName);
                vimage = reshape(double(image), 1, []);
                if(fold==1)
                    Actualtrainfold1(foldtrain1) = double(n);
                    foldtrain1 = foldtrain1+1;
                    crossValidationTrainDatafold1 = [crossValidationTrainDatafold1 ;vimage];
                elseif(fold==2)
                    Actualtrainfold2(foldtrain2) = double(n);
                    foldtrain2 = foldtrain2+1;
                    crossValidationTrainDatafold2 = [crossValidationTrainDatafold2 ;vimage];
                elseif(fold==3)
                    Actualtrainfold3(foldtrain3) = double(n);
                    foldtrain3 = foldtrain3+1;
                    crossValidationTrainDatafold3 = [crossValidationTrainDatafold3 ;vimage];
                elseif(fold==4)
                    Actualtrainfold4(foldtrain4) = double(n);
                    foldtrain4 = foldtrain4+1;
                    crossValidationTrainDatafold4 = [crossValidationTrainDatafold4 ;vimage];
                else
                    Actualtrainfold5(foldtrain5) = double(n);
                    foldtrain5 = foldtrain5+1;
                    crossValidationTrainDatafold5 = [crossValidationTrainDatafold5 ;vimage];
                end
            end
            for  f=1:1:2
                fullFileName = fullfile(thisFolder, baseFileNames(testRows(f)).name);
                fprintf('     Processing image file test %s\n', fullFileName);
                image = imread(fullFileName);
                vimage = reshape(double(image), 1, []);
                if(fold==1)
                    Actualfold1(fold1) = double(n);
                    fold1 = fold1+1;
                    crossValidationTestDatafold1 = [crossValidationTestDatafold1 ;vimage];
                elseif(fold==2)
                    Actualfold2(fold2) = double(n);
                    fold2 = fold2+1;
                    crossValidationTestDatafold2 = [crossValidationTestDatafold2 ;vimage];
                elseif(fold==3)
                    Actualfold3(fold3) = double(n);
                    fold3 = fold3+1;
                    crossValidationTestDatafold3 = [crossValidationTestDatafold3 ;vimage];
                elseif(fold==4)
                    Actualfold4(fold4) = double(n);
                    fold4 = fold4+1;
                    crossValidationTestDatafold4 = [crossValidationTestDatafold4 ;vimage];
                else
                    Actualfold5(fold5) = double(n);
                    fold5 = fold5+1;
                    crossValidationTestDatafold5 = [crossValidationTestDatafold5 ;vimage];
                end
            end
        else
        end
        n=n+1;
    end
    startOfRow=startOfRow+2;
end

%pca and knn fold 1
[ytrainfold1 ,ytestfold1] = pca(crossValidationTrainDatafold1,crossValidationTestDatafold1);
accuracyfold1 = knn(ytestfold1.', ytrainfold1.',Actualtrainfold1,Actualfold1);

%pca and knn fold 2
[ytrainfold2 ,ytestfold2] = pca(crossValidationTrainDatafold2,crossValidationTestDatafold2);
accuracyfold2 = knn(ytestfold2.', ytrainfold2.',Actualtrainfold2,Actualfold2);

%pca and knn fold 1
[ytrainfold3 ,ytestfold3] = pca(crossValidationTrainDatafold3,crossValidationTestDatafold3);
accuracyfold3 = knn(ytestfold3.', ytrainfold3.',Actualtrainfold3,Actualfold3);

%pca and knn fold 1
[ytrainfold4 ,ytestfold4] = pca(crossValidationTrainDatafold4,crossValidationTestDatafold4);
accuracyfold4 = knn(ytestfold4.', ytrainfold4.',Actualtrainfold4,Actualfold4);

%pca and knn fold 1
[ytrainfold5 ,ytestfold5] = pca(crossValidationTrainDatafold5,crossValidationTestDatafold5);
accuracyfold5 = knn(ytestfold5.', ytrainfold5.',Actualtrainfold5,Actualfold5);

[ytrainfold1 ,ytestfold1] = ldaf(ytrainfold1,ytestfold1,Actualtrainfold1);
accuracyfold1 = knn(ytestfold1.', ytrainfold1.',Actualtrainfold1,Actualfold1);

[ytrainfold2 ,ytestfold2] = ldaf(ytrainfold2,ytestfold2,Actualtrainfold2);
accuracyfold2 = knn(ytestfold2.', ytrainfold2.',Actualtrainfold2,Actualfold2);

[ytrainfold3 ,ytestfold3] = ldaf(ytrainfold3,crossValiytestfold3dationTestDatafold3,Actualtrainfold3);
accuracyfold3 = knn(ytestfold3.', ytrainfold3.',Actualtrainfold3,Actualfold3);

[ytrainfold4 ,ytestfold4] = ldaf(ytrainfold4,ytestfold4,Actualtrainfold4);
accuracyfold4 = knn(ytestfold4.', ytrainfold4.',Actualtrainfold4,Actualfold4);

[ytrainfold5 ,ytestfold5] = ldaf(ytrainfold5,ytestfold5,Actualtrainfold5);
accuracyfold5 = knn(ytestfold5.', ytrainfold5.',Actualtrainfold5,Actualfold5);
disp('pca')
disp(accuracyfold1);
disp(accuracyfold2);
disp(accuracyfold3);
disp(accuracyfold4);
disp(accuracyfold5);
disp((accuracyfold1+accuracyfold2+accuracyfold3+accuracyfold4+accuracyfold5)/5);

%lda and knn fold 1
[ytrainfoldlda1 ,ytestfoldlda1] = ldaf(ytrainfold1,ytestfold1,Actualtrainfold1);
accuracyfold1 = knn(ytestfoldlda1.', ytrainfoldlda1.',Actualtrainfold1,Actualfold1);

[ytrainfoldlda2 ,ytestfoldlda2] = ldaf(ytrainfold2,ytestfold2,Actualtrainfold2);
accuracyfold2 = knn(ytestfoldlda2.', ytrainfoldlda2.',Actualtrainfold2,Actualfold2);

[ytrainfoldlda3 ,ytestfoldlda3] = ldaf(ytrainfold3,ytestfold3,Actualtrainfold3);
accuracyfold3 = knn(ytestfoldlda3.', ytrainfoldlda3.',Actualtrainfold3,Actualfold3);

[ytrainfoldlda4 ,ytestfoldlda4] = ldaf(ytrainfold4,ytestfold4,Actualtrainfold4);
accuracyfold4 = knn(ytestfoldlda4.', ytrainfoldlda4.',Actualtrainfold4,Actualfold4);

[ytrainfoldlda5 ,ytestfoldda5] = ldaf(ytrainfold5,ytestfold5,Actualtrainfold5);
accuracyfold5 = knn(ytestfoldda5.', ytrainfoldlda5.',Actualtrainfold5,Actualfold5);

disp('lda')
disp(accuracyfold1);
disp(accuracyfold2);
disp(accuracyfold3);
disp(accuracyfold4);
disp(accuracyfold5);
disp((accuracyfold1+accuracyfold2+accuracyfold3+accuracyfold4+accuracyfold5)/5);

end


function accuracy = knn(test,train,actualtrain,actualtest)
    for p=1:80
        for q=1:320
           G = test(p,:);
           G2 = train(q,:);
           Dist(p,q) = sqrt(sum((G - G2) .^ 2));
        end
    end
    for p=1:80
        for q=1:320
            if Dist(p,q)== min(Dist(p,:))
                 idx(p) = q;
            end
        end
    end
     for i=1:1:80
         idx(i) = actualtrain(idx(i),1);
     end
     count=0;
     for i=1:1:80
        if(idx(i) == actualtest(i))
            count=count+1;
        end
     end
      accuracy = (count/80)*100;
end

function [ytrainfold,ytestfold] = pca(train,test)
    muTrain = mean(train);
    muTest = mean(test);
    Xtraincenterd =bsxfun(@minus,train,muTrain);
    Xtestcenterd =bsxfun(@minus,test,muTest);
    C = cov(Xtraincenterd);
    [V,D] = eig(C);
    [D, i] = sort(diag(D), 'descend');
     V = V(:,i);
     E = V(1:end ,1:80);
    ytrainfold = E.' * Xtraincenterd.';
    ytestfold = E.' * Xtestcenterd.';
end

function [ytrain, ytest]=ldaf(traindata,testdata,Actualtrainfold)
c1 = traindata(1:8,:);
c2 = traindata(9:16,:);
c3 = traindata(17:24,:);
c4 = traindata(25:32,:);
c5 = traindata(33:40,:);
c6 = traindata(41:48,:);
c7 = traindata(49:56,:);
c8 = traindata(57:64,:);
c9 = traindata(65:72,:);
c10 = traindata(73:80,:);
c11 = traindata(81:88,:);
c12 = traindata(89:96,:);
c13 = traindata(97:104,:);
c14 = traindata(105:112,:);
c15 = traindata(113:120,:);
c16 = traindata(121:128,:);
c17 = traindata(129:136,:);
c18 = traindata(137:144,:);
c19 = traindata(145:152,:);
c20 = traindata(153:160,:);
c21 = traindata(161:168,:);
c22 = traindata(169:176,:);
c23 = traindata(177:184,:);
c24 = traindata(185:192,:);
c25 = traindata(193:200,:);
c26 = traindata(201:208,:);
c27 = traindata(209:216,:);
c28 = traindata(217:224,:);
c29 = traindata(225:232,:);
c30 = traindata(233:240,:);
c31 = traindata(241:248,:);
c32 = traindata(249:256,:);
c33 = traindata(257:264,:);
c34 = traindata(265:272,:);
c35 = traindata(273:280,:);
c36 = traindata(281:288,:);
c37 = traindata(289:296,:);
c38 = traindata(297:304,:);
c39 = traindata(305:312,:);
c40 = traindata(313:320,:);

mu_total = mean(traindata);
mu_testtotal =  mean(testdata);
mu = [ mean(c1);mean(c2);mean(c3);mean(c4);mean(c5);mean(c6);mean(c7);mean(c8);mean(c9);mean(c10); 
        mean(c11);mean(c12);mean(c13);mean(c14);mean(c15);mean(c16);mean(c17);mean(c18);mean(c19);mean(c20); 
        mean(c21);mean(c22);mean(c23);mean(c24);mean(c25);mean(c26);mean(c27);mean(c28);mean(c29);mean(c30); 
        mean(c31);mean(c32);mean(c33);mean(c34);mean(c35);mean(c36);mean(c37);mean(c38);mean(c39);mean(c40) ];
Sw = (traindata - mu(Actualtrainfold,:))'*(traindata - mu(Actualtrainfold,:));
Sb = (ones(40,1) * mu_total - mu)' * (ones(40,1) * mu_total - mu);
[V, D] = eig(Sw\Sb);
[D, i] = sort(diag(D), 'descend');
V = V(:,i);
Xtraincenterd = bsxfun(@minus, traindata, mu_total);
Xtestcenterd =  bsxfun(@minus, testdata, mu_testtotal);
Efold = V(1:end ,1:39);
%Efold = real(Efold1);
ytrain = Efold.' *  Xtraincenterd.';
ytest =  Efold.' *  Xtestcenterd.';
end
