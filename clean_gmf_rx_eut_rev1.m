function [cell_gmf]=clean_gmf_rx_eut_rev1(app,gmf_header,cell_gmf)


    col_rx_eut_idx=find(matches(gmf_header,'REQ'));
[num_rows,~]=size(cell_gmf);
tic;
for i=1:1:num_rows
    %i/num_rows*100
        temp_rx_eut=cell_gmf{i,col_rx_eut_idx};
        temp_rx_eut_name=NaN(1);
        if ischar(temp_rx_eut)
            if contains(temp_rx_eut,'G,')==1
                temp_split=strsplit(temp_rx_eut,'G,');
                if contains(temp_split{2},',')
                    temp_split2=strsplit(temp_split{2},',');
                else
                    clear temp_split2;
                    temp_split2{1}=temp_split{2};
                end
                temp_rx_eut_name=temp_split2{1};
            elseif contains(temp_rx_eut,'C,')==1
                temp_split=strsplit(temp_rx_eut,'C,');
                if contains(temp_split{2},',')
                    temp_split2=strsplit(temp_split{2},',');
                else
                    clear temp_split2;
                    temp_split2{1}=temp_split{2};
                end
                temp_rx_eut_name=temp_split2{1};
            elseif contains(temp_rx_eut,'U,')==1
                temp_split=strsplit(temp_rx_eut,'U,');
                if contains(temp_split{2},',')
                    temp_split2=strsplit(temp_split{2},',');
                else
                    clear temp_split2;
                    temp_split2{1}=temp_split{2};
                end
                temp_rx_eut_name=temp_split2{1};
            end
            %%%%%%Remove the space to minimize the GMF EUT difference
            temp_rx_eut_name=temp_rx_eut_name(find(~isspace(temp_rx_eut_name)));
        end
        if isempty(temp_rx_eut_name)
            temp_rx_eut_name='N/A';
        end
        if isnan(temp_rx_eut_name)
            temp_rx_eut_name='N/A';
        end
        cell_gmf{i,col_rx_eut_idx}=temp_rx_eut_name; %%%18) Rx EUT
        %%%%  cell_gmf_data(:,18)
end
toc;
end