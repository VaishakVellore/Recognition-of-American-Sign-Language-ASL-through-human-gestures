cop_matrix=[];

files = dir('*.csv');
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var=csv(1:44,1:34);
    %YourNewTable = array2table(new_var.');
    new_matrix=table2array(new_var);
    cop_matrix=[cop_matrix;new_matrix'];
end
disp(cop_matrix)
csvwrite('cop_all.csv',cop_matrix,1,1)