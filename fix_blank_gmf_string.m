function [cell_gmf]=fix_blank_gmf_string(app,gmf_header,header_str,cell_gmf)


%%%%Need to fill in the empty equipment rows
col_idx=find(matches(gmf_header,header_str));
[num_rows,~]=size(cell_gmf);
tic;
for i=1:1:num_rows
    %i/num_rows*100
    temp_str=cell_gmf{i,col_idx};
    if ischar(temp_str)

    else
       cell_gmf{i,col_idx}='';
    end
end
toc;