function [table_uni_rows,ia,ic]=uniqe_gmf_rows_rev2_no_print(app,gmf_header,cell_uni_strings,temp_gmf_data)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%Unique test based on the Reciver location, but pull all the lat/lons
%%%%%%Need to split service types if they have more than 1 type


num_idx=length(cell_uni_strings);
array_col_idx=NaN(num_idx,1);
for i=1:1:num_idx
    array_col_idx(i)=find(matches(gmf_header,cell_uni_strings{i}));
end

temp_table_gmf=cell2table(temp_gmf_data(:,array_col_idx));
[table_uni_rows,ia,ic]=unique(temp_table_gmf,'rows');


end