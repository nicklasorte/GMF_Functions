function print_uni_service_types_rev1(app,gmf_header,cell_gmf48)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Unique Service Types
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
col_service_idx=find(matches(gmf_header,'Service'))
list_uni_service=unique(cell_gmf48(:,col_service_idx))

%%%%%%%%Cut the 'Fixed' from the list
fixed_idx=find(matches(list_uni_service,'Fixed'));
list_uni_service(fixed_idx)=[];

%%%%%%%%For each one, split at the comma, then unique the whole list again.
num_service=length(list_uni_service);
cell_service_list=cell(num_service,1);
for i=1:1:num_service
    temp_service=list_uni_service{i};
    temp_split = strsplit(temp_service,',');
    cell_service_list{i}=temp_split';
end
list_uni_service=unique(vertcat(cell_service_list{:}))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%Need to split service types if they have more than 1 type

 %%%Table: Agency: location Tx city, Tx state, Tx EUT, Tx lat, tx lon, Rx City, , Rx EUT Name, Rx Lat, Rx Lon
col_agency_idx=find(matches(gmf_header,'Agency'));
col_freq1_idx=find(matches(gmf_header,'FRQMHz'));
col_freq2_idx=find(matches(gmf_header,'FRUMHz'));
col_tx_city_idx=find(matches(gmf_header,'XAL'));
col_tx_state_idx=find(matches(gmf_header,'XSC'));
col_tx_eut_idx=find(matches(gmf_header,'XEQ'));
col_tx_lat_idx=find(matches(gmf_header,'XLatDD'));
col_tx_lon_idx=find(matches(gmf_header,'XLonDD'));
col_rx_city_idx=find(matches(gmf_header,'RAL'));
col_rx_state_idx=find(matches(gmf_header,'RSC'));
col_rx_eut_idx=find(matches(gmf_header,'REQ'));
col_rx_lat_idx=find(matches(gmf_header,'RLA'));
col_rx_lon_idx=find(matches(gmf_header,'RLG'));

'First cut at gmf table for section 2'
num_uni_service=length(list_uni_service)
for service_idx=1:1:num_uni_service
    temp_service_str=list_uni_service{service_idx}
    row_service_idx=find(contains(cell_gmf48(:,col_service_idx),temp_service_str));

     %%%%%%%%%%We need to add the rx location because of space receivers.
    %%%%%%%%%%%%Adding the States also to remove a nested for loop
    data_idx=[col_agency_idx,col_freq1_idx,col_freq2_idx,col_tx_city_idx,col_tx_state_idx,col_tx_eut_idx,col_tx_lat_idx,col_tx_lon_idx,col_rx_city_idx,col_rx_state_idx,col_rx_eut_idx,col_rx_lat_idx,col_rx_lon_idx];
    temp_table_gmf=cell2table(cell_gmf48(row_service_idx,data_idx));

    temp_table_gmf.Properties.VariableNames=gmf_header(data_idx)
    writetable(temp_table_gmf,strcat(temp_service_str,'_non_unique.xlsx'));

    %%%%%%%%%%%%%%%%%%%Unique the rows later: 'Multiple Rx Lat/Lon Can Not Unique in a Table'

%     [C,ia,ic]=unique(temp_table_gmf,'rows');
%     table_uni_tx_rx_city=C

end

end