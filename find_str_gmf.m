function [constains_idx]=find_str_gmf(app,gmf_header,header_str,str_find,cell_gmf)


col_idx=find(matches(gmf_header,header_str));
[num_rows,~]=size(cell_gmf);
tic;
constains_idx=NaN(num_rows,1);
for i=1:1:num_rows
    %i/num_rows*100
    temp_str=cell_gmf{i,col_idx};
    if ischar(temp_str)
        if contains(temp_str,str_find)==1
            constains_idx(i)=i;
        end
    end
end
constains_idx=constains_idx(~isnan(constains_idx));
size(constains_idx)
toc;
end