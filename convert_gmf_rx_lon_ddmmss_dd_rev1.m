function [cell_gmf]=convert_gmf_rx_lon_ddmmss_dd_rev1(app,gmf_header,cell_gmf)


%%%24) Rx Lon: DDMMSS
col_rx_lon_idx=find(matches(gmf_header,'RLG'));
[num_rows,~]=size(cell_gmf);
for i=1:1:num_rows
    temp_rx_lon_ddmmss=cell_gmf{i,col_rx_lon_idx};
    temp_rx_lon=NaN(1);
    if ischar(temp_rx_lon_ddmmss)
        temp_split_multi_lon=strsplit(temp_rx_lon_ddmmss,',');

        temp_rx_lon=NaN(length(temp_split_multi_lon),1);
        for k=1:1:length(temp_split_multi_lon)
            temp_rx_lon_ddmmss=temp_split_multi_lon{k};
            %%%%%%%%Loop
            if ischar(temp_rx_lon_ddmmss)
                if contains(temp_rx_lon_ddmmss,'N/A')==1
                    %%%%Nothing
                elseif contains(temp_rx_lon_ddmmss,'E')==1
                    temp_split=strsplit(temp_rx_lon_ddmmss,'E');
                    temp_split_rx_lon=temp_split{1};
                    if length(temp_split_rx_lon)==6
                        temp_rx_lon(k)=str2num(temp_split_rx_lon(1:2))+str2num(temp_split_rx_lon(3:4))/60+str2num(temp_split_rx_lon(5:6))/360;
                    elseif length(temp_split_rx_lon)==7
                        temp_rx_lon(k)=str2num(temp_split_rx_lon(1:3))+str2num(temp_split_rx_lon(4:5))/60+str2num(temp_split_rx_lon(6:7))/360;
                    else
                        'Unknown legnth'
                        temp_rx_lon_ddmmss
                        temp_split_rx_lon
                        pause;
                    end
                elseif contains(temp_rx_lon_ddmmss,'W')==1
                    temp_split=strsplit(temp_rx_lon_ddmmss,'W');
                    temp_split_rx_lon=temp_split{1};
                    if length(temp_split_rx_lon)==6
                        temp_rx_lon(k)=-1*(str2num(temp_split_rx_lon(1:2))+str2num(temp_split_rx_lon(3:4))/60+str2num(temp_split_rx_lon(5:6))/360);
                    elseif length(temp_split_rx_lon)==7
                        temp_rx_lon(k)=-1*(str2num(temp_split_rx_lon(1:3))+str2num(temp_split_rx_lon(4:5))/60+str2num(temp_split_rx_lon(6:7))/360);
                    else
                        'Unknown legnth'
                        temp_rx_lon_ddmmss
                        temp_split_rx_lon
                        pause;
                    end
                end
            end
        end
% % %         if k>1
% % %             cell_gmf{i,col_rx_lon_idx}
% % %             temp_rx_lon
% % %             %pause;
% % %         end
 
    else
        %temp_rx_lon
        %'Idk'
        %pause;
    end

    cell_gmf{i,col_rx_lon_idx}=temp_rx_lon;

end
