
function SVM
clc;    % Clear the command window.
workspace;  % Make sure the workspace panel is showing.
TrainSet = cell([],1);
TestSet = cell([],1);
p=1;
q=1;
X=[]; %train set
T=[]; %test set
Actual=cell([],1);  %actual class
% Define a starting folder.
start_path = fullfile(matlabroot, '.\att_faces\');
% Ask user to confirm or change.
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
    return;
end
% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
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
% Process all image files in those folders.
for k = 2 : numberOfFolders
    % Get this folder and print it out.
    thisFolder = listOfFolderNames{k};
    
    fprintf('Processing folder %s\n', thisFolder);
    
    filePattern = sprintf('%s/*.pgm', thisFolder);
    baseFileNames = dir(filePattern);
    numberOfImageFiles = length(baseFileNames);
    % Now we have a list of all files in this folder.
    
    if numberOfImageFiles >= 1
        % Go through all those image files.
        div =  numberOfImageFiles/2;
        for  f= 1 : div
            fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            fprintf('Processing image file train %s\n', fullFileName);
            image = imread(fullFileName);
            vimage = reshape(double(image), 1, []);
            TrainSet{p}   = vimage;
            X=[X;vimage];
            p=p+1;
        end
        for  f=(div+1) : numberOfImageFiles
            fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            fprintf('     Processing image file test %s\n', fullFileName);
            image = imread(fullFileName);
            vimage = reshape(double(image), 1, []);
            TestSet{q}   = vimage; % array of images
            T=[T;vimage];
            Actual{q} = double(n);
            disp(Actual{q});
            q=q+1;
            
        end
    else
        fprintf('Folder %s has no image files in it.\n', thisFolder);
    end
    n=n+1;
end
[w,w0] = trainSVM(X);
[t,t0] = trainSVM(T);
accuracy_onlytrain = testSVM(T,w,w0,Actual);
accuracy_traintest = testSVM(X,t,t0,Actual);
disp((accuracy_onlytrain+accuracy_traintest)/2);
end


function [m1,m2] = trainSVM(x)
m1=zeros(40,10304);
m2=zeros(40,1);
for i=1:+5:200
    z=-ones(200,1);
    z(i:i+4) = 1;
    H = (x * x') .* (z * z');
    f= -ones(200,1);
    A= -eye(200);
    a=zeros(200,1);
    B=[[z]';[zeros(200-1,200)]];
    b= zeros(200,1);
    lb= zeros(200,1);
    ub= zeros(200,1);
    ub(:) = 100;
    alpha = quadprog(H+eye(200)*0.001, f, A, a, B, b,lb,ub);
    w= (alpha.*z)'*x;
    w=w';
    wo=(1/z(i,:))-w'*x(i,:)';
    m1(round(1+i/5),:)=w;
    m2(round(1+i/5),:)=wo;
end
end

function accuracy = testSVM(t,w,wo,Actual)
result = zeros(40,1);
testclass = zeros(40,1);
count =0;
for i=1:200
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
    accuracy = (count/200)*100;
end
end