function [inside_idx]=filter_wideband_gmf(app,gmf_header,cell_gmf,filter_freq)


col_freq1_idx=find(matches(gmf_header,'FRQMHz'));
col_freq2_idx=find(matches(gmf_header,'FRUMHz'));
[num_rows,~]=size(cell_gmf);
inside_idx=NaN(num_rows,1);
for i=1:1:num_rows
    temp_gmf_freq1=cell_gmf{i,col_freq1_idx};
    temp_gmf_freq2=cell_gmf{i,col_freq2_idx};

    if temp_gmf_freq2==0 %%% Single frequency
        if temp_gmf_freq1>=filter_freq(1) && temp_gmf_freq1<=filter_freq(2)
            inside_idx(i)=i; %%%%%%Within Band
        end
    else %%%%Band Assingment
        %%%%%%%%%%%%Remove the wideband systems.
        if temp_gmf_freq1<filter_freq(1) && temp_gmf_freq2>filter_freq(2)
            %%%%%%%%Do not include

        elseif temp_gmf_freq1>=filter_freq(1) && temp_gmf_freq2<=filter_freq(2)  %%%%%%Sits Within Band1
            %%%'Logic 3: Sits Within Band'
            inside_idx(i)=i; %%%%%%Within Band

        else
            % %             horzcat(temp_gmf_freq1,temp_gmf_freq2)
            % %             'Outside'
            % %             pause;
        end
    end
end
inside_idx=inside_idx(~isnan(inside_idx));

end