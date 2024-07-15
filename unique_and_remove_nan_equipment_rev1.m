function [cell_gmf]=unique_and_remove_nan_equipment_rev1(app,gmf_header,header_string,cell_gmf)


col_idx=find(matches(gmf_header,header_string));
[num_rows,~]=size(cell_gmf);
tic;
for i=1:1:num_rows
    temp_data=cell_gmf{i,col_idx};

    if ischar(temp_data)
        %%%%%%Trying this again, First split it at the ','

        if contains(temp_data,',')
            temp_split_data=strsplit(temp_data,',');
            temp_split_data=unique(temp_split_data);

            if any(matches(temp_split_data,'G'))
                g_idx=matches(temp_split_data,'G');
                temp_split_data(g_idx)=[];
            end
            if any(matches(temp_split_data,'C'))
                c_idx=matches(temp_split_data,'C');
                temp_split_data(c_idx)=[];
            end

            if any(contains(temp_split_data,'NaN'))
                %%%%%%%Check for NaN
                nan_idx=find(contains(temp_split_data,'NaN'));
                temp_split_data(nan_idx)=[];
            end
            if any(contains(temp_split_data,'N/A'))
                %%%%%%%Check for NaN
                nan_idx=find(contains(temp_split_data,'N/A'));
                temp_split_data(nan_idx)=[];
            end


            if length(temp_split_data)>1
                %%%%%'Turn back into a string'
                %%%temp_split_data
                num_parts=length(temp_split_data);
                for j=1:1:num_parts
                    if j==1
                        temp_str=temp_split_data{j};
                    else
                        temp_str=strcat(temp_str,',',temp_split_data{j});
                    end
                end
                temp_split_data=temp_str;
                cell_gmf{i,col_idx}=temp_split_data;
            else
                if isempty(temp_split_data)
                    temp_data='NaN';
                    cell_gmf{i,col_idx}=temp_data;
                else
                    cell_gmf{i,col_idx}=temp_split_data;
                end
            end

        else  %%%%%%No commas
            if contains(temp_data,'N/A')
                temp_data='NaN';
                cell_gmf{i,col_idx}=temp_data;
            end
            if contains(temp_data,'NaN')
                temp_data='NaN';
                cell_gmf{i,col_idx}=temp_data;
                %%%%%%%Leave it
            end
        end
    else
        if isempty(temp_data)
            temp_data='NaN';
            cell_gmf{i,col_idx}=temp_data;
        else
            temp_data
            'Idk'
            pause;
        end
    end
    if iscell(cell_gmf{i,col_idx})
        temp_data2=cell_gmf{i,col_idx};
        %%%temp_data2{1}
        cell_gmf{i,col_idx}=temp_data2{1};
    end
end
toc;