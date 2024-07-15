function [cell_gmf]=simplify_gmf_agency_name_rev1(app,cell_gmf,gmf_header)


    tic;
    [num_rows,~]=size(cell_gmf)
    col_agency_idx=find(matches(gmf_header,'Agency'))
    for i=1:1:num_rows
        temp_agency_str=cell_gmf{i,col_agency_idx};
        temp_agency_str = strrep(temp_agency_str,'Air Force, Department of the','Air Force');
        temp_agency_str = strrep(temp_agency_str,'Army, Department of the','Army');
        temp_agency_str = strrep(temp_agency_str,'Commerce, Department of','Commerce');
        temp_agency_str = strrep(temp_agency_str,'Energy, Department of','Energy');
        temp_agency_str = strrep(temp_agency_str,'Health and Human Services, Department of','HHS');
        temp_agency_str = strrep(temp_agency_str,'Interior, Department of the','Interior');
        temp_agency_str = strrep(temp_agency_str,'National Aeronautics and Space Administration','NASA');
        temp_agency_str = strrep(temp_agency_str,'National Science Foundation','NSF');
        temp_agency_str = strrep(temp_agency_str,'Navy, Department of the (U.S. Navy)','Navy');
        temp_agency_str = strrep(temp_agency_str,'Homeland Security, Department of','DHS');
        temp_agency_str = strrep(temp_agency_str,'Navy, Department of the (U.S. Marine Corps)','Marine Corps');
        temp_agency_str = strrep(temp_agency_str,'Federal Aviation Administration','FAA');
        temp_agency_str = strrep(temp_agency_str,'Social Security Administration','SSA');
        temp_agency_str = strrep(temp_agency_str,'Veterans Affairs, Department of','VA');
        temp_agency_str = strrep(temp_agency_str,'Transportation, Department of','DOT');
        temp_agency_str = strrep(temp_agency_str,'State, Department of','State');
        temp_agency_str = strrep(temp_agency_str,'Agriculture, Department of','Agriculture');
        temp_agency_str = strrep(temp_agency_str,'Justice, Department of','Justice');
        temp_agency_str = strrep(temp_agency_str,'---',',');
        cell_gmf{i,col_agency_idx}=temp_agency_str;
    end
    toc;
end