about_matrix=[];

files = dir('*.csv');
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var=csv(1:44,1:34);
    new_matrix=table2array(new_var);
    about_matrix=[about_matrix;new_matrix'];
end
disp(about_matrix)

csvwrite('about_all.csv',about_matrix,1,1)

