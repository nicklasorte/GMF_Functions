function print_excel_agnecy_gmf_rev1(app,gmf_header,cell_gmf,gmf_MinMHz,gmf_MaxMHz)
    %%%%%%%%%%%%%%%%%%%%%%%%Each agency Equitites
    col_agency_idx=find(matches(gmf_header,'Agency'));
    uni_agency=unique(cell_gmf(:,col_agency_idx))
    num_agency=length(uni_agency);

    tic;
    for agency_idx=1:1:num_agency
        temp_agency_str=uni_agency{agency_idx}
        agency_row_idx=find(contains(cell_gmf(:,col_agency_idx),temp_agency_str));
        table_agency_gmf=cell2table(cell_gmf(agency_row_idx,:));
        table_agency_gmf.Properties.VariableNames=gmf_header;
        writetable(table_agency_gmf,strcat(temp_agency_str,'_GMF_',num2str(gmf_MinMHz),'_',num2str(gmf_MaxMHz),'.xlsx'));
    end
    toc;
end