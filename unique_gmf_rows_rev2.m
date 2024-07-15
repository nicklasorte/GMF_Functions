function [temp_uni_data,table_uni_rows]=unique_gmf_rows_rev2(app,gmf_header,cell_uni_strings,temp_gmf_data,string_name)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%Unique test based on the Reciver location, but pull all the lat/lons
%%%%%%Need to split service types if they have more than 1 type


num_idx=length(cell_uni_strings);
array_col_idx=NaN(num_idx,1);
for i=1:1:num_idx
    array_col_idx(i)=find(matches(gmf_header,cell_uni_strings{i}));
end

temp_table_gmf=cell2table(temp_gmf_data(:,array_col_idx));
[table_uni_rows,uni_idx,ic]=unique(temp_table_gmf,'rows');
table_uni_rows.Properties.VariableNames=gmf_header(array_col_idx)
%save(strcat(string_name,'.mat'),'table_uni_rows') %%%%%%%Pull into the sims.
writetable(table_uni_rows,strcat(string_name,'.xlsx'));


temp_uni_data=temp_gmf_data(uni_idx,:);

end