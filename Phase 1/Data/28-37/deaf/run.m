deaf_matrix=[];

files = dir('*.csv');
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var=csv(1:44,1:34);
    %YourNewTable = array2table(new_var.');
    new_matrix=table2array(new_var);
    deaf_matrix=[deaf_matrix;new_matrix'];
end
disp(deaf_matrix)
csvwrite('deaf_all.csv',deaf_matrix,1,1)