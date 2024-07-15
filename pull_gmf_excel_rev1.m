function [gmf_table]=pull_gmf_excel_rev1(app,gmf_MinMHz,gmf_MaxMHz,rev_num)

%%%%%%%%Scrap GMF

filename_gmf_table=strcat('gmf_table_',num2str(gmf_MinMHz),'_',num2str(gmf_MaxMHz),'_',num2str(rev_num),'.mat');
filename_gmf_excel=strcat('GMF_',num2str(gmf_MinMHz),'_',num2str(gmf_MaxMHz),'_',num2str(rev_num),'.xlsx');
[var_exist_gmf_table]=persistent_var_exist_with_corruption(app,filename_gmf_table);

if var_exist_gmf_table==2
    tic;
    load(filename_gmf_table,'gmf_table')
    toc;
else
    local_drive='C:\Local Matlab Data\GMF_functions';
    NET.addAssembly(fullfile(local_drive,'GMFAddIn.dll'));
    GMFLIB = GMFAddIn.GMF;
    connectivity = GMFLIB.HaveGMFConnection()
    if connectivity
        res = zeros(1,1);
        rowcnt = 0;
        colcnt = 0;
        CenterLat = 39.0;
        CenterLon = -98;
        Radius_Km = 100000.0;

        colnames='';
        disp('Have Connectivity')

        tic;
        disp('Retrieving Data . . .')
        [res, rowcnt, colcnt, colnames] = GMFLIB.RetrieveGMFAllAssignmentsOBJ(gmf_MinMHz,gmf_MaxMHz);
        toc;  %%%%%%%57 seconds


        tic;
        cell_col_name=cell(1,colcnt);
        for i=1:1:colcnt
            cell_col_name{i}=char(colnames(i));
        end
        toc;


        %%%%These are numbers
        num1_idx=find(strcmp(cell_col_name,'FRQMHz')==1);
        num2_idx=find(strcmp(cell_col_name,'FRUMHz')==1);
        num3_idx=find(strcmp(cell_col_name,'XLatDD')==1);
        num4_idx=find(strcmp(cell_col_name,'XLonDD')==1);

        tic;
        disp('Data Formatting . . .')
        cell_gmf_data=cell(rowcnt,colcnt);
        for r=1:rowcnt
            for c=1:colcnt
                if strcmp(class(res(r,c)),'System.DBNull')
                    % %             disp('null')
                else
                    if c==num1_idx || c==num2_idx || c==num3_idx || c==num4_idx
                        cell_gmf_data{r,c}=double(res(r,c));
                    else
                        cell_gmf_data{r,c}=char(res(r,c));
                    end
                end
            end
        end
        toc;  %%%%%65 seconds


        gmf_table=cell2table(cell_gmf_data,'VariableNames',cell_col_name)
        save(filename_gmf_table,'gmf_table')
        tic;
        disp('Writing Excel File . . .')
        writetable(gmf_table,filename_gmf_excel)
        toc;   %%%%21 seconds


    else
        disp('No Connectivity')
    end

end


end