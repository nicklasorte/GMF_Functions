function [cell_military_installations_data]=load_military_installation_shapefile_rev2(app,tf_read_mil_shapefile,mil_folder,folder1,rev_num)


mil_shape_filename=strcat('cell_military_installations_data_',num2str(rev_num),'.mat');

tic;
if tf_read_mil_shapefile==1
    var_exist_input=0;
else
    [var_exist_input]=persistent_var_exist_with_corruption(app,mil_shape_filename);
end

if var_exist_input==2 
    %%%%%%%Load
    retry_load=1;
    while(retry_load==1)
        try
            tic;
            load(mil_shape_filename,'cell_military_installations_data')
            toc;  %%%%%%%%%10 seconds
            pause(0.1)
            retry_load=0;
        catch
            retry_load=1;
            pause(1)
        end
    end
    pause(0.1)

else

    %%%%%%%%%%%%Load
    %%%%%%The idea is to make a more general shapefile reader
    cd(mil_folder)
    pause(0.1)
    folder_info=dir(mil_folder);

    x3=length(folder_info);
    file_name=cell(x3,1);
    for i=1:1:x3
        file_name{i}=folder_info(i).name;
    end
    shape_idx=find(endsWith(file_name,'.shp')==1); %%%%%%%%Search the folder for the .shp file name
    shape_file_label=file_name{shape_idx};


    %%%%%%%Read in the shapefile
    temp_shapefile=shaperead(shape_file_label);
    shape_cell=struct2cell(temp_shapefile);

    %%%%%%%Find the X,Y,FullName, INTPTLAT, INTPTLON
    struct_names=fieldnames(temp_shapefile);
    horzcat(struct_names,shape_cell(:,1))
    lon_idx=find(contains(struct_names,'X')==1);
    lat_idx=find(contains(struct_names,'Y')==1);
    name_idx=find(contains(struct_names,'FULLNAME')==1);
    int_lat_idx=find(contains(struct_names,'INTPTLAT')==1);
    int_lon_idx=find(contains(struct_names,'INTPTLON')==1);

    %%%Scrape All Lat/Lons
    [~,num_locations]=size(shape_cell);
    cell_military_installations_data=cell(num_locations,6); 
    %%%1)Name, 
    % %%2) Lat, 
    % %3) Lon, 
    % %%4) Internal Lat/Lon,
    %%%%5) Polyshape
    %%%%6) Centroid
    for i=1:1:num_locations
        cell_military_installations_data{i,1}=shape_cell{name_idx,i};
        cell_military_installations_data{i,2}=shape_cell{lat_idx,i};
        cell_military_installations_data{i,3}=shape_cell{lon_idx,i};
        cell_military_installations_data{i,4}=horzcat(str2double(shape_cell{int_lat_idx,i}),str2double(shape_cell{int_lon_idx,i}));
        temp_poly=polyshape(shape_cell{lon_idx,i},shape_cell{lat_idx,i});
        cell_military_installations_data{i,5}=temp_poly;
        [cent_x,cent_y] = centroid(temp_poly);
        cell_military_installations_data{i,6}=horzcat(cent_y,cent_x);

% % %         if any(isnan(shape_cell{lat_idx,i}))
% % %             close all;
% % %             figure;
% % %             plot(temp_poly)
% % %             pause;
% % %         end
    end
    size(cell_military_installations_data) 

    cd(folder1)
    pause(0.1)



    %%%%%%%%%%%%%Save to a kml file
    tic;
    [name_sort,name_sort_idx]=sort(cell_military_installations_data(:,1));
    cell_lat=cell_military_installations_data(name_sort_idx,2);
    cell_lon=cell_military_installations_data(name_sort_idx,3);
    geos=geoshape(cell_lat,cell_lon);
    geos.Name=cell_military_installations_data(name_sort_idx,1);
    geos.Geometry='polygon';
    filename = 'Military_Installations.kml';
    kmlwrite(filename, geos, 'Name', geos.Name, 'Description',{},'EdgeColor','r','FaceColor','w','FaceAlpha',0.25,'LineWidth',2);
    toc;



    retry_save=1;
    while(retry_save==1)
        try
            tic;
            save(mil_shape_filename,'cell_military_installations_data')
            pause(0.1)
            retry_save=0;
            toc;
        catch
            retry_save=1;
            pause(1)
        end
    end
    pause(0.1)

end
toc;
end