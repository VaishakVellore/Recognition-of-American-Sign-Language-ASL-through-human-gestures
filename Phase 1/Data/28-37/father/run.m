father_matrix=[];

files = dir('*.csv');
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var=csv(1:44,1:34);
    %YourNewTable = array2table(new_var.');
    new_matrix=table2array(new_var);
    father_matrix=[father_matrix;new_matrix'];
end
disp(father_matrix)
csvwrite('father_all.csv',father_matrix,1,1)
