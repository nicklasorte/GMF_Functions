function [constains_idx]=find_gmf_note_str(app,gmf_header,cell_gmf,str_note_filter)

col_nts_idx=find(matches(gmf_header,'NTS'));
[num_rows,~]=size(cell_gmf);
tic;
constains_idx=NaN(num_rows,1);
for i=1:1:num_rows
    %i/num_rows*100
    temp_str_nts=cell_gmf{i,col_nts_idx};
    if ischar(temp_str_nts)
        if contains(temp_str_nts,str_note_filter)==1
            constains_idx(i)=i;
        end
    end
end
constains_idx=constains_idx(~isnan(constains_idx));
size(constains_idx)
toc;


end