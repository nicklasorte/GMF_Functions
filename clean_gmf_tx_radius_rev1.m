function [cell_gmf]=clean_gmf_tx_radius_rev1(app,gmf_header,cell_gmf)

col_tx_rad_idx=find(matches(gmf_header,'TxRad'));
col_rx_rad_idx=find(matches(gmf_header,'RxRad'));

[num_rows,~]=size(cell_gmf);
tic;
for i=1:1:num_rows
    %i/num_rows*100
    temp_tx_rad=cell_gmf{i,col_tx_rad_idx};
    if isempty(temp_tx_rad)
        temp_tx_rad=NaN(1,1);
        cell_gmf{i,col_tx_rad_idx}=temp_tx_rad;
    else
        if ischar(temp_tx_rad)
            idx_both=strfind(temp_tx_rad,'B');
            if ~isempty(idx_both)
                temp_split=strsplit(temp_tx_rad,'B');
                cell_gmf{i,col_tx_rad_idx}=str2num(temp_split{1});
                cell_gmf{i,col_rx_rad_idx}=str2num(temp_split{1});
            end
            idx_tx=strfind(temp_tx_rad,'T');
            if ~isempty(idx_tx)
                temp_split=strsplit(temp_tx_rad,'T');
                cell_gmf{i,col_tx_rad_idx}=str2num(temp_split{1});
            end
        else
            temp_tx_rad
            'Not a string'
            pause;
        end
    end
end
toc;

end