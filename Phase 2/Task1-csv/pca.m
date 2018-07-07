about_table = readtable('about.csv','ReadRowNames',false);
and_table = readtable('and.csv','ReadRowNames',false);
can_table = readtable('can.csv','ReadRowNames',false);
cop_table = readtable('cop.csv','ReadRowNames',false);
deaf_table = readtable('deaf.csv','ReadRowNames',false);
decide_table = readtable('decide.csv','ReadRowNames',false);
father_table = readtable('father.csv','ReadRowNames',false);
find_table = readtable('find.csv','ReadRowNames',false);
goOut_table = readtable('goOut.csv','ReadRowNames',false);
hearing_table = readtable('hearing.csv','ReadRowNames',false);

figure(1);
about_x=table2array(about_table(:,2:end));
covx = cov(about_x);
[COEFF,latent,explained] = pcacov(covx)
%subplot(3,1,1);
plot(COEFF(:,1)*latent(1,:));
xlabel("Eigenvector index")
ylabel("Eigenvector x Eigenvalue")
title("Gesture: ABOUT");
hold on;

figure(1);
%subplot(3,1,2);
plot(COEFF(:,2)*latent(2,:));
xlabel("Eigenvector index")
ylabel("Eigenvector x Eigenvalue")
title("Gesture: ABOUT");
hold on;

figure(1);
%subplot(3,1,3);
plot(COEFF(:,3)*latent(3,:));
xlabel("Eigenvector index")
ylabel("Eigenvector x Eigenvalue")
title("Gesture: ABOUT");
hold on;

figure(2);
plot(COEFF(:,1:7)'*latent(1:7,:));
xlabel("Eigenvector index")
ylabel("Eigenvector x Eigenvalue")
title("Gesture: ABOUT");
hold on;


% and_x=table2array(and_table(:,2:end));
% covx = cov(and_x);
% [COEFF,latent,explained] = pcacov(covx)
% new_COEFF=COEFF(:,1:31);
% subplot(3,1,2);
% plot(COEFF(:,1)*latent(1,:));
% xlabel("Eigenvector index")
% ylabel("Eigenvector x Eigenvalue")
% title("Gesture: AND");
% hold on;
% 
% can_x=table2array(can_table(:,2:end));
% covx = cov(can_x);
% [COEFF,latent,explained] = pcacov(covx)
% new_COEFF=COEFF(:,1:31);
% subplot(3,1,3);
% plot(COEFF(:,1)*latent(1,:));
% xlabel("Eigenvector index")
% ylabel("Eigenvector x Eigenvalue")
% title("Gesture: CAN");
% hold on;