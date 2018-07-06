clc;
clear;
files = dir('*.csv');
i=1;
decision_tree_accuracy = zeros(1,10);
svm_res_accuracy = zeros(1,10);


for file=files'
csv=readtable(file.name,"ReadRowNames",false);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Pre-processing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
random_dataset = csv(randperm(size(csv, 1)), :);
split = floor(size(random_dataset,1)/3);
var=split*2+1;
train_data = random_dataset(1:split*2,:);
test_data = random_dataset(var:end,1:end);
test_set = test_data(:,1:end-1);
test_labels = test_data(:,end:end);
train_set = train_data(:,1:end-1);
train_labels = train_data(:,end:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% DECISION TREE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dt = fitctree(train_set,train_labels);
p = predict(dt, test_set);
decision_tree_accuracy(i) = sum(table2array(test_labels)==p)/size(table2array(test_labels),1);

[confMat1,order1] = confusionmat(table2array(test_labels), p);
recall_dt(i)=confMat1(1,1)/sum(confMat1(1,:));
precision_dt(i) = confMat1(1,1)/sum(confMat1(:,1));
f1_score_dt(i) = 2*recall_dt(i)*precision_dt(i)/(recall_dt(i)+precision_dt(i));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

svm = fitcecoc(train_set,train_labels);
v = predict(svm, test_set);
svm_res_accuracy(i) = sum(table2array(test_labels)==v)/size(test_labels,1);

[confMat2,order2] = confusionmat(table2array(test_labels), v);
recall_svm(i)=confMat2(1,1)/sum(confMat2(1,:));
precision_svm(i) = confMat2(1,1)/sum(confMat2(:,1));
f1_score_svm(i) = 2*recall_svm(i)*precision_svm(i)/(recall_svm(i)+precision_svm(i));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% NEURAL NETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
net = patternnet(5);
net = train(net,table2array(train_set)', table2array(train_labels)');
y = round(net(table2array(test_set)'));
[confMat3,order3] = confusionmat(table2array(test_labels), y');
recall_nn(i)=confMat3(1,1)/sum(confMat3(1,:));
precision_nn(i) = confMat3(1,1)/sum(confMat3(:,1));
f1_score_nn(i) = 2*recall_nn(i)*precision_nn(i)/(recall_nn(i)+precision_nn(i));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%NEXT FILE ITERATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i= i+1;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%AVERAGE R and P DT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Average_Recall_User_DT = mean(recall_dt);
Average_Precision_User_DT = mean(precision_dt); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%AVERAGE R and P SVM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Average_Recall_User_SVM = mean(recall_svm);
Average_Precision_User_SVM = mean(precision_svm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%AVERAGE R and P NN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Average_Recall_User_NN = mean(recall_nn);
Average_Precision_User_NN = mean(precision_nn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% AVERAGE F1 DT and SVM and NN %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Average_F1_User_DT = mean(f1_score_dt);
Average_F1_User_SVM = mean(f1_score_svm);
Average_F1_User_NN = mean(f1_score_nn);