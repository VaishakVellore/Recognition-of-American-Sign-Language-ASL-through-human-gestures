hearing_matrix=[];

files = dir('*.csv');
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var=csv(1:44,1:34);
    %YourNewTable = array2table(new_var.');
    new_matrix=table2array(new_var);
    hearing_matrix=[hearing_matrix;new_matrix'];
end
disp(hearing_matrix)
csvwrite('hearing_all.csv',hearing_matrix,1,1)