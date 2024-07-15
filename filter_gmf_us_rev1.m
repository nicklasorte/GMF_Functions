function [cell_gmf_us]=filter_gmf_us_rev1(app,gmf_header,cell_gmf,gmf_MinMHz,gmf_MaxMHz,rev_num,tf_refilter)


filename_gmf_us=strcat('cell_gmf_us_',num2str(gmf_MinMHz),'_',num2str(gmf_MaxMHz),'_',num2str(rev_num),'.mat');
[var_exist_gmf_table]=persistent_var_exist_with_corruption(app,filename_gmf_us);
if tf_refilter==1
    var_exist_gmf_table=0;
end


if var_exist_gmf_table==2
    tic;
    load(filename_gmf_us,'cell_gmf_us')
    toc;
else


    %%%%%%%%Find the overlap between the base_buffer and us_cont
    %%%%%%%%%%Filter out the points outside of us_cont
    retry_load=1;
    while(retry_load==1)
        try
            load('ds_poly_us_cont_50km.mat','ds_poly_us_cont_50km')
            pause(0.1)
            retry_load=0;
        catch
            retry_load=1;
            pause(1)
        end
    end
    pause(0.1)

    % % close all;
    % % figure;
    % % hold on;
    % % plot(ds_poly_us_cont_50km)
    % % pause;

    polyout=ds_poly_us_cont_50km;
    polyout=rmholes(polyout);
    if polyout.NumRegions>1
        polyout = convhull(polyout);
        border_bound=fliplr(polyout.Vertices);
        border_bound=vertcat(border_bound,border_bound(1,:)); %%%%Close the circle
    elseif polyout.NumRegions==1
        border_bound=fliplr(polyout.Vertices);
        border_bound=vertcat(border_bound,border_bound(1,:)); %%%%Close the circle
    elseif polyout.NumRegions==0
        border_bound=base_buffer;
    end

    col_tx_lat_idx=find(matches(gmf_header,'XLatDD'));
    col_tx_lon_idx=find(matches(gmf_header,'XLonDD'));
    col_rx_lat_idx=find(matches(gmf_header,'RLA'));
    col_rx_lon_idx=find(matches(gmf_header,'RLG'));

    %%%%%%%%%Convert Rx Lat/Lon ddmmss to dd deg
    tic;
    [cell_gmf]=convert_gmf_rx_lon_ddmmss_dd_rev1(app,gmf_header,cell_gmf);
    [cell_gmf]=convert_gmf_rx_lat_ddmmss_dd_rev1(app,gmf_header,cell_gmf);
    toc;  %%%%%%2 seconds


    [num_rows,~]=size(cell_gmf);
    tf_tx_inside=zeros(num_rows,1);
    tf_rx_inside=zeros(num_rows,1);
    tic;
    for i=1:1:num_rows
        i/num_rows*100
        tx_lat=cell_gmf{i,col_tx_lat_idx};
        tx_lon=cell_gmf{i,col_tx_lon_idx};
        if length(tx_lat)>1
            tx_lat
            'More than 1 lat'
            pause;
        end
        if ~isempty(tx_lat) && ~isempty(tx_lon)
            tf_tx_inside(i)=isinterior(ds_poly_us_cont_50km,tx_lon,tx_lat);
        end

        rx_lat=cell_gmf{i,col_rx_lat_idx};
        rx_lon=cell_gmf{i,col_rx_lon_idx};
        rx_lat=rx_lat(~isnan(rx_lat));
        rx_lon=rx_lon(~isnan(rx_lon));
        if length(rx_lat)>1
            rx_lat
            'More than 1 lat'
            pause;
        end
        if ~isempty(rx_lat) && ~isempty(rx_lon)
            tf_rx_inside(i)=any(isinterior(ds_poly_us_cont_50km,rx_lon,rx_lat));
        end
    end
    toc;  %%%%%74 seconds
    tx_inside_idx=find(tf_tx_inside==1);
    rx_inside_idx=find(tf_rx_inside==1);
    inside_idx=unique(vertcat(tx_inside_idx,rx_inside_idx));
    size(inside_idx)

    cell_gmf_us=cell_gmf(inside_idx,:);
    save(filename_gmf_us,'cell_gmf_us')

end