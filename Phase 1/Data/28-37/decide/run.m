decide_matrix=[];

files = dir('*.csv');
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var=csv(1:44,1:34);
    %YourNewTable = array2table(new_var.');
    new_matrix=table2array(new_var);
    decide_matrix=[decide_matrix;new_matrix'];
end
disp(decide_matrix)
csvwrite('decide_all.csv',decide_matrix,1,1)