function [inside_idx]=filter_band_gmf_rev1(app,gmf_header,cell_gmf,filter_freq)


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
        %%%%%Maybe check if the GMF Freq1==High Band Edge
        if temp_gmf_freq1==filter_freq(2)
            %%%'Logic 0: GMF Freq 1 == High Band Edge'
            %%%%Leave at Zero, no need to check anything else.
        elseif temp_gmf_freq1<=filter_freq(1) && temp_gmf_freq2<=filter_freq(2) && temp_gmf_freq2>filter_freq(1) %%%%%%Straddles Lower Band1
            %%%'Logic 1: Straddles Lower Band Bound'
            inside_idx(i)=i; %%%%%%Within Band
        elseif temp_gmf_freq1<=filter_freq(2) && temp_gmf_freq2>=filter_freq(2) && temp_gmf_freq1>=filter_freq(1) %%%%%%Straddles High Band1
            %%%'Logic 2: Straddles High Band Bound'
            inside_idx(i)=i; %%%%%%Within Band
        elseif temp_gmf_freq1>=filter_freq(1) && temp_gmf_freq2<=filter_freq(2)  %%%%%%Sits Within Band1
            %%%'Logic 3: Sits Within Band'
            inside_idx(i)=i; %%%%%%Within Band
        elseif  temp_gmf_freq1<=filter_freq(1) && temp_gmf_freq2>=filter_freq(2) %%%%%%Overtop of entire band
            %%%'Logic 4: Overtop Entire Band'
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
