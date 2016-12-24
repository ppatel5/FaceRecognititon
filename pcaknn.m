% function pcaknn
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
            % Go through all those image files.
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
%pca and knn fold 1
% [ytrainfold1 ,ytestfold1] = pca(crossValidationTrainDatafold1,crossValidationTestDatafold1);
% accuracyfold1 = knn(ytestfold1.', ytrainfold1.',Actualtrainfold1,Actualfold1);
% 
% %pca and knn fold 2
% [ytrainfold2 ,ytestfold2] = pca(crossValidationTrainDatafold2,crossValidationTestDatafold2);
% accuracyfold2 = knn(ytestfold2.', ytrainfold2.',Actualtrainfold2,Actualfold2);
% 
% %pca and knn fold 1
% [ytrainfold3 ,ytestfold3] = pca(crossValidationTrainDatafold3,crossValidationTestDatafold3);
% accuracyfold3 = knn(ytestfold3.', ytrainfold3.',Actualtrainfold3,Actualfold3);
% 
% %pca and knn fold 1
% [ytrainfold4 ,ytestfold4] = pca(crossValidationTrainDatafold4,crossValidationTestDatafold4);
% accuracyfold4 = knn(ytestfold4.', ytrainfold4.',Actualtrainfold4,Actualfold4);
% 
% %pca and knn fold 1
% [ytrainfold5 ,ytestfold5] = pca(crossValidationTrainDatafold5,crossValidationTestDatafold5);
% accuracyfold5 = knn(ytestfold5.', ytrainfold5.',Actualtrainfold5,Actualfold5);
% 
% disp(accuracyfold1);
% disp(accuracyfold2);
% disp(accuracyfold3);
% disp(accuracyfold4);
% disp(accuracyfold5);
% disp((accuracyfold1+accuracyfold2+accuracyfold3+accuracyfold4+accuracyfold5)/5);
% 
% 
% end
% 
% function [ytrainfold,ytestfold] = pca(train,test)
%     muTrain = mean(train);
%     muTest = mean(test);
%     Xtraincenterd =bsxfun(@minus,train,muTrain);
%     Xtestcenterd =bsxfun(@minus,test,muTest);
%     C = cov(Xtraincenterd);
%     [V,D] = eig(C);
%     [D, i] = sort(diag(D), 'descend');
%      V = V(:,i);
%      E = V(1:end ,1:80);
%     ytrainfold = E.' * Xtraincenterd.';
%     ytestfold = E.' * Xtestcenterd.';
% end
% 
% function accuracy = knn(test,train,actualtrain,actualtest)
%      D = pdist2(test,train, 'euclidean');
%      [D,idx] = sort(D, 2, 'ascend');
% 
%      K = 1;
%      D = D(:,1:K);
%      idx = idx(:,1:K);
%      for i=1:1:80
%          idx(i) = actualtrain{idx(i)};
%      end
%      count=0;
%      for i=1:1:80
%         if(idx(i) == actualtest{i})
%             count=count+1;
%         end
%      end
%       accuracy = (count/80)*100;
% end
% 










