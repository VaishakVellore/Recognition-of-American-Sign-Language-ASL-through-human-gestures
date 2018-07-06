find_matrix=[];

files = dir('*.csv');
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var=csv(1:44,1:34);
    %YourNewTable = array2table(new_var.');
    new_matrix=table2array(new_var);
    find_matrix=[find_matrix;new_matrix'];
end
disp(find_matrix)
csvwrite('find_all.csv',find_matrix,1,1)