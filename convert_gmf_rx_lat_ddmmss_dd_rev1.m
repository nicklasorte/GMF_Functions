function [cell_gmf]=convert_gmf_rx_lat_ddmmss_dd_rev1(app,gmf_header,cell_gmf)

%%%23) Rx Lat: DDMMSS

col_rx_lat_idx=find(matches(gmf_header,'RLA'));
[num_rows,~]=size(cell_gmf);
for i=1:1:num_rows
    temp_rx_lat_ddmmss=cell_gmf{i,col_rx_lat_idx};
    temp_rx_lat=NaN(1);


    %%%%%We could have multiple rx points, split by comma
    if ischar(temp_rx_lat_ddmmss)

        temp_split_multi_lat=strsplit(temp_rx_lat_ddmmss,',');

        temp_rx_lat=NaN(length(temp_split_multi_lat),1);
        for k=1:1:length(temp_split_multi_lat)
            temp_rx_lat_ddmmss=temp_split_multi_lat{k};
            %%%%%%%%Loop
            if ischar(temp_rx_lat_ddmmss)
                if contains(temp_rx_lat_ddmmss,'N/A')==1
                    %%%%Nothing
                elseif contains(temp_rx_lat_ddmmss,'N')==1
                    temp_split=strsplit(temp_rx_lat_ddmmss,'N');
                    temp_split_rx_lat=temp_split{1};
                    if length(temp_split_rx_lat)==6
                        temp_rx_lat(k)=str2num(temp_split_rx_lat(1:2))+str2num(temp_split_rx_lat(3:4))/60+str2num(temp_split_rx_lat(5:6))/360;
                    else
                        'Unknown legnth'
                        temp_rx_lat_ddmmss
                        temp_split_rx_lat
                        pause;
                    end
                elseif contains(temp_rx_lat_ddmmss,'S')==1
                    temp_split=strsplit(temp_rx_lat_ddmmss,'S');
                    temp_split_rx_lat=temp_split{1};
                    if length(temp_split_rx_lat)==6
                        temp_rx_lat(k)=-1*(str2num(temp_split_rx_lat(1:2))+str2num(temp_split_rx_lat(3:4))/60+str2num(temp_split_rx_lat(5:6))/360);
                    else
                        'Unknown legnth'
                        temp_rx_lat_ddmmss
                        temp_split_rx_lat
                        pause;
                    end
                end
            end

        end
    else
        'IDK'
        pause;
    end
% %     if k>1
% %         cell_gmf{i,col_rx_lat_idx}
% %         temp_rx_lat
% %         %pause;
% %     end
    cell_gmf{i,col_rx_lat_idx}=temp_rx_lat;
end


end