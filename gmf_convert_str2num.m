function [cell_gmf]=gmf_convert_str2num(app,cell_gmf,gmf_header,header_string)

%%%%%Convert str 2 num
col_idx=find(matches(gmf_header,header_string));
[num_rows,~]=size(cell_gmf);
tic;
for i=1:1:num_rows
    temp_str=cell_gmf{i,col_idx};
    if ischar(temp_str)
        cell_gmf{i,col_idx}=str2double(temp_str);
    end
end
toc;