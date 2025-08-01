function [col_idx]=find_table_header_idx(app,str_header_find,table_header)

%%%%%%%Only keep this data: Contour: Second Column in the Cell
num_keep_cols=length(str_header_find);
col_idx=NaN(num_keep_cols,1);
for i=1:1:num_keep_cols
    col_idx(i)=find(matches(table_header,str_header_find{i}));
end