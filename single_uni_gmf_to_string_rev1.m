function [cell_uni_table_data]=single_uni_gmf_to_string_rev1(app,temp_cell_strings)

                [~,num_cols]=size(temp_cell_strings);

                %%%%%String the Data
                uni_temp_string=cell(1,num_cols+1);
                uni_temp_string{1}=unique(temp_cell_strings(:,1));
                %%%2) Freq
                %%%3) Freq Max/Band
                %%%%%%%String of GMF Frequencies, check for band assignments
                temp_gmf_freq1=vertcat(temp_cell_strings{:,2});
                temp_gmf_freq2=vertcat(temp_cell_strings{:,3});
                temp_array_freq=horzcat(temp_gmf_freq1,temp_gmf_freq2);

                %%%%%%%%%%%It might be easier to separate the single/band, string
                %%%%%%%%%%%each separately and then combine the two strings.
                temp_single_idx=find(temp_array_freq(:,2)==0);
                temp_band_idx=find(temp_array_freq(:,2)~=0);
                temp_single_freq=temp_array_freq(temp_single_idx,1);
                temp_band_freq=temp_array_freq(temp_band_idx,:);

                %%%%Build a string
                if ~isempty(temp_single_freq)
                    temp_single_freq=unique(temp_single_freq);
                    for j=1:1:length(temp_single_freq)
                        if j==1
                            temp_str_single=strcat(num2str(temp_single_freq(j)),'MHz');
                        else
                            temp_str_single=strcat(temp_str_single,', ',{' '},num2str(temp_single_freq(j)),'MHz');
                        end
                    end
                else
                    temp_str_single='';
                end

                if ~isempty(temp_band_freq)
                    temp_band_freq=unique(temp_band_freq,'rows');
                    [temp_band_size,~]=size(temp_band_freq);
                    for j=1:1:temp_band_size
                        if j==1
                            temp_str_band=strcat(num2str(temp_band_freq(j,1)),'--',num2str(temp_band_freq(j,2)),'MHz');
                        else
                            temp_str_band=strcat(temp_str_band,', ',{' '},num2str(temp_band_freq(j,1)),'--',num2str(temp_band_freq(j,2)),'MHz');
                        end
                    end
                else
                    temp_str_band='';
                end

                if ~isempty(temp_str_single) && ~isempty(temp_band_freq)
                    temp_freq_str=strcat(temp_str_single,',',temp_str_band);
                elseif isempty(temp_str_single) && ~isempty(temp_band_freq)
                    temp_freq_str=temp_str_band;
                elseif ~isempty(temp_str_single) && isempty(temp_band_freq)
                    temp_freq_str=temp_str_single;
                else
                    'Unknown Freq String'
                    pause;
                    temp_freq_str='';
                end
                uni_temp_string{2}=temp_freq_str;

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                uni_temp_string{4}=unique(vertcat(temp_cell_strings{:,4}));
                uni_temp_string{5}=unique(vertcat(temp_cell_strings{:,5}));
                uni_temp_string{6}=unique(temp_cell_strings(:,6));
                uni_temp_string{7}=unique(temp_cell_strings(:,7));
                uni_temp_string{8}=unique(vertcat(temp_cell_strings{:,8}));
                uni_temp_string{9}=unique(vertcat(temp_cell_strings{:,9}));
                uni_temp_string{10}=unique(vertcat(temp_cell_strings{:,10}));
                uni_temp_string{11}=unique(vertcat(temp_cell_strings{:,11}));
                uni_temp_string{12}=unique(vertcat(temp_cell_strings{:,12}));
                uni_temp_string{13}=unique(horzcat(temp_cell_strings{:,13}));
                uni_temp_string{14}=unique(horzcat(temp_cell_strings{:,14}));
                uni_temp_string{15}=unique(temp_cell_strings(:,15));
                uni_temp_string{16}=unique(temp_cell_strings(:,16));
                uni_temp_string{17}=unique(temp_cell_strings(:,17));
                uni_temp_string{18}=unique(temp_cell_strings(:,18));
                uni_temp_string{19}=unique(vertcat(temp_cell_strings{:,19}));
                uni_temp_string{20}=unique(vertcat(temp_cell_strings{:,20}));
                %%%21) Tx Lat: DecDeg
                %%%22) Tx Lon: DecDeg
                temp_latlon=horzcat(vertcat(temp_cell_strings{:,21}),vertcat(temp_cell_strings{:,22}));
                temp_latlon=unique(temp_latlon,'rows');
                uni_temp_string{21}=temp_latlon;
                [num_latlon,~]=size(temp_latlon);
                if num_latlon==1
                    uni_temp_string{22}=temp_latlon;
                elseif num_latlon>2
                    [latmean,lonmean]=meanm(temp_latlon(:,1),temp_latlon(:,2));
                    uni_temp_string{22}=horzcat(latmean,lonmean);
                end

                uni_temp_string{23}=unique(vertcat(temp_cell_strings{:,23}));
                uni_temp_string{24}=unique(vertcat(temp_cell_strings{:,24}));
                uni_temp_string{25}=unique(vertcat(temp_cell_strings{:,25}));
                uni_temp_string{26}=unique(vertcat(temp_cell_strings{:,26}));
                uni_temp_string{27}=unique(temp_cell_strings(:,27));

                if matches(unique(horzcat(temp_cell_strings{:,28})),'/AN')
                    uni_temp_string{28}=temp_cell_strings{:,28};
                else
                    uni_temp_string{28}=unique(horzcat(temp_cell_strings{:,28}));
                end
                uni_temp_string{29}=unique(temp_cell_strings(:,29));
                uni_temp_string{30}=unique(temp_cell_strings(:,30));
                uni_temp_string{31}=unique(temp_cell_strings(:,31));
                uni_temp_string{32}=vertcat(temp_cell_strings{:,32});

                temp_tf_band_array=uni_temp_string{32};
                [num_rows,~]=size(temp_tf_band_array);
                if num_rows>1
                    uni_temp_string{33}=any(uni_temp_string{32});
                else
                    uni_temp_string{33}=uni_temp_string{32};
                end
                %%%%temp_state_cell{state_idx}=uni_temp_string;

                %%%%temp_cell_cell{city_idx}=vertcat(temp_state_cell{:});

                %%%temp_cell_cell{city_idx}
                %%%%cell_uni_table_data=vertcat(temp_state_cell{:});
                cell_uni_table_data=uni_temp_string;
                %pause;
                %%%%%%%%%'If there is a cell array within a cell, create a string'
                [num_rows,num_cols]=size(cell_uni_table_data);
                for row_idx=1:1:num_rows
                    for col_idx=1:1:num_cols
                        if col_idx~=2 || col_idx~=3  %%%%%%%Skip for Frequency
                            if iscell(cell_uni_table_data{row_idx,col_idx})==1
                                if length(cell_uni_table_data{row_idx,col_idx})==1
                                    cell_uni_table_data(row_idx,col_idx)=cell_uni_table_data{row_idx,col_idx};
                                    %%%cell_uni_table_data{row_idx,col_idx}
                                else
                                    %%%%This is where we make a string out of it
                                    if col_idx==1 || col_idx==5 || col_idx==10 || col_idx==18   || col_idx==27  || col_idx==28  || col_idx==29 || col_idx==30 || col_idx==31
                                        %%%%%String of GMF Numbers
                                        %%%%strcat the GMF Record Notes
                                        temp_cell_data=sort(cell_uni_table_data{row_idx,col_idx});
                                        temp_cell_data=temp_cell_data(~cellfun('isempty', temp_cell_data));
                                        if length(temp_cell_data)>1
                                            %%%%Build a string
                                            for j=1:1:length(temp_cell_data)
                                                if j==1
                                                    temp_str=temp_cell_data{j};
                                                else
                                                    temp_str=strcat(temp_str,',',temp_cell_data{j});
                                                end
                                            end
                                        end
                                        % %                     if col_idx==18
                                        % %                         temp_str
                                        % %                         pause;
                                        % %                     end
                                        cell_uni_table_data{row_idx,col_idx}=temp_str;
                                    elseif col_idx==15 || col_idx==16
                                        %%%%Need to figure out the Space Multiple City, State,
                                        %%%%This error occurs before, need to sort it out above
% % %                                         clc;
% % %                                         'Check'
% % %                                         horzcat(row_idx,col_idx)
% % %                                         cell_uni_table_data{row_idx,col_idx}
% % %                                         pause;
                                    else
                                        clc;
                                        'Check'
                                        horzcat(row_idx,col_idx)
                                        cell_uni_table_data{row_idx,col_idx}
                                        pause;
                                    end
                                end
                                %%%cellfun('length',cell_uni_table_data(row_idx,col_idx))
                            end
                        end
                    end
                end

% % %                 %%%%%%%%%%End of Subfunction
% % %                 clc;
% % %                 temp_cell_strings
% % %                 cell_uni_table_data


end