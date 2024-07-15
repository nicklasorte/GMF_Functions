function [cell_gmf]=expand_gmf_rx_loc_rev1(app,gmf_header,cell_gmf)

% % % % % % %%%%%%%%%%%If there is more than 1 entry for the Receiver location, break it into separate rows.
% % % % % % %%Check: RLA	RLG
%%% Rx Lat, Rx Lon: DDMMSS
col_rx_lat_idx=find(matches(gmf_header,'RLA'));
col_rx_lon_idx=find(matches(gmf_header,'RLG'));

[num_rows,~]=size(cell_gmf);
expand_gmf=cell(num_rows,1);
tic;
for i=1:1:num_rows
    temp_rx_lat_ddmmss=cell_gmf{i,col_rx_lat_idx};
    temp_rx_lon_ddmmss=cell_gmf{i,col_rx_lon_idx};
    if ischar(temp_rx_lon_ddmmss)
        if contains(temp_rx_lat_ddmmss,',') || contains(temp_rx_lon_ddmmss,',')
           temp_split_multi_lat=strsplit(temp_rx_lat_ddmmss,',');
           temp_split_multi_lon=strsplit(temp_rx_lon_ddmmss,',');

           %%%%%%%%Split
           num_expand=length(temp_split_multi_lon);
           temp_gmf_expand=cell(num_expand,1);
           for j=1:1:num_expand
               temp_gmf_row=cell_gmf(i,:);
               temp_gmf_row{1,col_rx_lat_idx}=temp_split_multi_lat{j};
               temp_gmf_row{1,col_rx_lon_idx}=temp_split_multi_lon{j};
               temp_gmf_expand{j}=temp_gmf_row;
           end
           expand_gmf{i}=vertcat(temp_gmf_expand{:});

        else  %%%%%%No commas
            expand_gmf{i}=cell_gmf(i,:);
        end
    else
        'Idk'
        pause;
    end
end
toc;
size(cell_gmf)
cell_gmf=vertcat(expand_gmf{:});
size(cell_gmf)

end