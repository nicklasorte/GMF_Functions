function [uni_tx_rx_city,cell_uni_idx,cell_uni_gmf_data]=unique_gmf_usul_rev1(app,gmf_header,cell_gmf)


%%%%%Unique and String Merge
%%%%%%%%Next Generalized Function: Unique the GMF
%%%%%%%%%%%%%%Need to find the locations with the same type of system with different frequencies and unique them.


    % % %     %%%%%%%%%First Unique By Service Type: Some GMF Assignments have more than one Service Type, not a good approach
    % % %     uni_service_class=unique(vertcat(cell_gmf_data{:,5}));
    % % %     num_uni_service=length(uni_service_class);

    %%%%%%For each location, split the GMF

    %%%%%Tx: XAL	XSC
    %%%%%Rx: RAL	RSC


    col_tx_city_idx=find(matches(gmf_header,'XAL'));
    col_rx_city_idx=find(matches(gmf_header,'RAL'));

    col_tx_state_idx=find(matches(gmf_header,'XSC'));
    col_rx_state_idx=find(matches(gmf_header,'RSC'));

    col_tx_eut_idx=find(matches(gmf_header,'XEQ'));
    col_rx_eut_idx=find(matches(gmf_header,'REQ'));


     %%%%%%%%%%We need to add the rx location because of space receivers.
    %%%%%%%%%%%%Adding the States also to remove a nested for loop
    temp_table_gmf=cell2table(cell_gmf(:,[col_tx_city_idx,col_tx_state_idx,col_rx_city_idx,col_rx_state_idx,col_tx_eut_idx,col_rx_eut_idx]));
    %writetable(temp_table_gmf,strcat('Temp_City_State_Table.xlsx'));
    [C,ia,ic]=unique(temp_table_gmf,'rows');
    table_uni_tx_rx_city=C;

    %%%[C,ia,ic] = unique(A,'rows','legacy')
    %%%If A is a matrix or array, then C = A(ia) and A(:) = C(ic).

    uni_tx_rx_city=table2cell(table_uni_tx_rx_city);
    [num_uni_txrx_city,~]=size(uni_tx_rx_city);
    cell_uni_gmf_data=cell(num_uni_txrx_city,1); %%%%%%%To be expanded later
    cell_uni_idx=cell(num_uni_txrx_city,1);
    tic;
    for city_idx=1:1:num_uni_txrx_city
        %%%%clc;
        %%%uni_tx_rx_city(city_idx,:)
        temp_match_tx_city_idx=find(matches(cell_gmf(:,col_tx_city_idx),uni_tx_rx_city{city_idx,1}));
        temp_match_tx_state_idx=find(matches(cell_gmf(:,col_tx_state_idx),uni_tx_rx_city{city_idx,2}));
        temp_match_rx_city_idx=find(matches(cell_gmf(:,col_rx_city_idx),uni_tx_rx_city{city_idx,3}));
        temp_match_rx_state_idx=find(matches(cell_gmf(:,col_rx_state_idx),uni_tx_rx_city{city_idx,4}));

        temp_match_tx_eut_idx=find(matches(cell_gmf(:,col_tx_eut_idx),uni_tx_rx_city{city_idx,5}));
        temp_match_rx_eut_idx=find(matches(cell_gmf(:,col_rx_eut_idx),uni_tx_rx_city{city_idx,6}));

        temp_match_city_idx=intersect(temp_match_tx_city_idx,temp_match_rx_city_idx);
        temp_match_state_idx=intersect(temp_match_tx_state_idx,temp_match_rx_state_idx);
        temp_match_eut_idx=intersect(temp_match_tx_eut_idx,temp_match_rx_eut_idx);

        temp_match_citystate_idx=intersect(temp_match_city_idx,temp_match_state_idx);
        temp_match_citystate_eut_idx=intersect(temp_match_citystate_idx,temp_match_eut_idx);
        temp_single_city_state_gmf_data=cell_gmf(temp_match_citystate_eut_idx,:);
        cell_uni_idx{city_idx}=temp_match_citystate_eut_idx;
        cell_uni_gmf_data{city_idx}=temp_single_city_state_gmf_data;
    end
    toc;

end