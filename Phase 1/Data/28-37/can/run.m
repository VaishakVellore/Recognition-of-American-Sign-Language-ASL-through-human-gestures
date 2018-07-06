can_matrix=[];

files = dir('*.csv');
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var=csv(1:44,1:34);
    %YourNewTable = array2table(new_var.');
    new_matrix=table2array(new_var);
    can_matrix=[can_matrix;new_matrix'];
end
disp(can_matrix)

csvwrite('can_all.csv',can_matrix,1,1)