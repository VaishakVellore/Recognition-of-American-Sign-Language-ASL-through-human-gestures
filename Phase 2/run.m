clc;
clear;
hearing_matrix=[];
sensor_names=["ALX","ALY","ALZ","ARX","ARY","ARZ","EMG0L","EMG1L","EMG2L","EMG3L","EMG4L","EMG5L","EMG6L","EMG7L","EMG0R","EMG1R","EMG2R","EMG3R","EMG4R","EMG5R","EMG6R","EMG7R","GLX","GLY","GLZ","GRX","GRY","GRZ","ORL","OPL","OYL","ORR","OPR","OYR"];

column_first=[];
files = dir('*.csv');
m=1;
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var1=csv(:,1:34);
    if size(new_var1,1)>45
        continue
    end
    if size(new_var1,1)<35
        continue
    end
    old_matrix=table2array(new_var1);
    size_old=size(old_matrix);
    if size_old(:,1)<45
        var1=[old_matrix; zeros((45-size_old(:,1)),34)];
    else
        var1=old_matrix;
    end
    hearing_matrix=[hearing_matrix;var1'];
    for k=1:34
       s=" ";
       column1=strcat("ACTION",s,num2str(m),s,sensor_names(k)); 
       column_first=[column_first;column1];
       %k=k+1;
    end
end

%disp(hearing_matrix);
%sTable = array2table(hearing_matrix,'RowNames',B)
%csvwrite('hearing_all.csv',hearing_matrix,0,0);

final_matrix=[];
final_matrix=horzcat(column_first,hearing_matrix);
 final_table=array2table(final_matrix);
 %writetable(final_table,'hearing.csv','WriteRowNames',false);


sorted_by_feature=[];
for feature=1:34
for i=1:size(hearing_matrix,1)
    if mod(i,34)==feature
        sorted_by_feature=[sorted_by_feature; hearing_matrix(i,:)];
    end
    
end
end
for i=1:size(hearing_matrix,1)
    if mod(i,34)==0
        sorted_by_feature=[sorted_by_feature; hearing_matrix(i,:)];
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For accelerometer
feature_number=[1,2,3,4,5,6];
feature_extracted=[];
feature_acc=[];
for i=1:size(feature_number,2)
    factor=size(hearing_matrix,1)/34;
    feature_extracted=sorted_by_feature((feature_number(:,i)-1)*factor+1:(feature_number(:,i))*factor,:)
    mean_feature=mean(feature_extracted,2);
    rms_feature = sqrt(mean(feature_extracted.^2,2))/size(feature_extracted,1);
    var_feature=var(feature_extracted,0,2);
    ZCR=mean(abs(diff(sign(feature_extracted))),2);
    mean_abs_dev_feature=mad(feature_extracted,0,2);
    %integration_feature=trapz(feature_extracted,2);
    %signal_magnitude_area=sum(feature_extracted,2);
    %eps=0.000001;
    %Entropy_feature = -sum(A.*log(A+eps));
    %Entropy_feature=Entropy_feature';
      
    feature_acc=horzcat(feature_acc,mean_feature,rms_feature,var_feature,[ZCR;0],mean_abs_dev_feature);
end
% for i=1:size(feature_acc,2)
%     figure(i);
%     histogram(feature_acc(:,i),16);
% end
    
%csvwrite('feature.csv',feature_extracted,0,0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For gyroscope: Standard deviation, RMS, ZCR and ABSDIFF
feature_number=[23,24,25,26,27,28];
feature_extracted=[];
feature_gyr=[];
for i=1:size(feature_number,2)
    factor=size(hearing_matrix,1)/34;
    feature_extracted=sorted_by_feature((feature_number(:,i)-1)*factor+1:(feature_number(:,i))*factor,:)
    rms_feature = sqrt(mean(feature_extracted.^2,2))/size(feature_extracted,1);
    std_feature=std(feature_extracted,0,2);
    ZCR=mean(abs(diff(sign(feature_extracted))),2);
    mean_abs_dev_feature=mad(feature_extracted,0,2);
    %integration_feature=trapz(feature_extracted,2);
    %signal_magnitude_area=sum(feature_extracted,2);
    %eps=0.000001;
    %Entropy_feature = -sum(A.*log(A+eps));
    %Entropy_feature=Entropy_feature';
      
    feature_gyr=horzcat(feature_gyr,rms_feature,std_feature,var_feature,[ZCR;0],mean_abs_dev_feature);
end
% for i=1:size(feature_acc,2)
%     figure(i);
%     histogram(feature_acc(:,i),16);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %For EMG: RMS, Integrated EMG(IEMG) ,Mean Absolute Value (MAV) ,Variance, Zero Crossing
feature_number=[7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22];
feature_extracted=[];
feature_emg=[];
for i=1:size(feature_number,2)
    factor=size(hearing_matrix,1)/34;
    feature_extracted=sorted_by_feature((feature_number(:,i)-1)*factor+1:(feature_number(:,i))*factor,:); 
    mav_feature=mean(abs(feature_extracted),2);
    rms_feature = sqrt(mean(feature_extracted.^2,2))/size(feature_extracted,1);
    var_feature=var(feature_extracted,0,2);
    ZCR=mean(abs(diff(sign(feature_extracted))),2);
      
    feature_emg=horzcat(feature_emg,mav_feature,rms_feature,var_feature,[ZCR;0]);
end
% for i=1:size(feature_acc,2)
%     figure(i);
%     histogram(feature_acc(:,i),16);
% end

%
% %feature_matrix=horzcat(feature_acc_gyro,feature_emg_or);
% %csvwrite('features_hearing.csv',feature_matrix,0,0);
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For OR 29,30,31,32,33,34 :First 5-FFT coefficients,Spectral energy,Standard deviation
%ZCR,Zero-crossing rate,Absolute difference
feature_number=[29,30,31,32,33,34];
feature_extracted=[];
feature_or=[];
for i=1:size(feature_number,2)
    factor=size(hearing_matrix,1)/34;
    feature_extracted=sorted_by_feature((feature_number(:,i)-1)*factor+1:(feature_number(:,i))*factor,:); 
    fft_feature=fft(feature_extracted);
    rms_feature = sqrt(mean(feature_extracted.^2,2))/size(feature_extracted,1);
    std_feature=std(feature_extracted,0,2);
    ZCR=mean(abs(diff(sign(feature_extracted))),2);
    energy = sum(abs(fft_feature).^2,2); 
    feature_or=horzcat(feature_or,rms_feature,std_feature,[ZCR;0],energy);
end
% for i=1:size(feature_acc,2)
%     figure(i);
%     histogram(feature_acc(:,i),16);
% end

feature_matrix=horzcat(feature_acc,feature_gyr,feature_emg,feature_or);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Plotting graphs for features
% for i=1:12
% figure(i);
% histogram(feature_matrix(:,i),16);
% title(strcat('hearing feature ', num2str(i)));
% xlabel('Mean value');
% ylabel('Frequency');
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Finding PCA on hearing feature matrix
% % covariance=cov(feature_matrix);
[coeff,score,latent] = pca(feature_matrix);
%h = biplot(coeff(:,1:2));
N=1:148;
legendCell = cellstr(num2str(N', 'N=%-d'))
biplot(coeff(:,1:2),'Scores',score(:,1:2),'Varlabels',legendCell);

%projection=feature_matrix*coeff;
% % %plot(score*coeff);
% % plot(projection);
% % labels=[];
% % for i=1:108
% %     labels=[labels,"feature "+i];
% % end
% % legend(labels);

