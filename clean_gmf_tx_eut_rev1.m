function [cell_gmf]=clean_gmf_tx_eut_rev1(app,gmf_header,cell_gmf)

col_tx_eut_idx=find(matches(gmf_header,'XEQ'));
[num_rows,~]=size(cell_gmf);
tic;
for i=1:1:num_rows
    %i/num_rows*100
    temp_tx_eut=cell_gmf{i,col_tx_eut_idx};
    temp_tx_eut_name=NaN(1);
    if ischar(temp_tx_eut)
        if contains(temp_tx_eut,'G,')==1
            temp_split=strsplit(temp_tx_eut,'G,');
            if contains(temp_split{2},',')
                temp_split2=strsplit(temp_split{2},',');
            else
                clear temp_split2;
                temp_split2{1}=temp_split{2};
            end
            temp_tx_eut_name=temp_split2{1};
        elseif contains(temp_tx_eut,'C,')==1
            temp_split=strsplit(temp_tx_eut,'C,');
            if contains(temp_split{2},',')
                temp_split2=strsplit(temp_split{2},',');
            else
                clear temp_split2;
                temp_split2{1}=temp_split{2};
            end
            temp_tx_eut_name=temp_split2{1};
        elseif contains(temp_tx_eut,'U,')==1
            temp_split=strsplit(temp_tx_eut,'U,');
            if contains(temp_split{2},',')
                temp_split2=strsplit(temp_split{2},',');
            else
                clear temp_split2;
                temp_split2{1}=temp_split{2};
            end
            temp_tx_eut_name=temp_split2{1};
        end
        %%%%%%Remove the space to minimize the GMF EUT difference
        temp_tx_eut_name=temp_tx_eut_name(find(~isspace(temp_tx_eut_name)));
    end
    if isnan(temp_tx_eut_name)
        temp_tx_eut_name='N/A';
    end
    if isempty(temp_tx_eut_name)
        temp_tx_eut_name='N/A';
    end
    [num_tx_rows,~]=size(temp_tx_eut_name);
    if num_tx_rows>1
        temp_tx_eut_name
    end
    cell_gmf{i,col_tx_eut_idx}=temp_tx_eut_name; %%%17) Tx EUT
end
toc;


end