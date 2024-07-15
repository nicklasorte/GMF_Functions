function [cell_gmf]=clean_gmf_tx_latlon_rev1(app,gmf_header,cell_gmf)



col_tx_lat_idx=find(matches(gmf_header,'XLatDD'));
col_tx_lon_idx=find(matches(gmf_header,'XLonDD'));
[num_rows,~]=size(cell_gmf);
tic;
for i=1:1:num_rows
    %i/num_rows*100
        temp_tx_lat=cell_gmf{i,col_tx_lat_idx};
        temp_tx_lon=cell_gmf{i,col_tx_lon_idx};
      
        if isempty(temp_tx_lat)
            temp_tx_lat=NaN(1,1);
            cell_gmf{i,col_tx_lat_idx}=temp_tx_lat;
        end
        if isempty(temp_tx_lon)
            temp_tx_lon=NaN(1,1);
            cell_gmf{i,col_tx_lon_idx}=temp_tx_lon;
        end

end
toc;