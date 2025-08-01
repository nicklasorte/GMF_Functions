function [ems_num]=convert_str_ems2num_mhz_rev1(app,temp_ems_str)


     if contains(temp_ems_str,'M')
         temp_split1=strsplit(temp_ems_str,'M');
         ems_num=str2num(temp_split1{1});
     else
         'Need to fill in logic'
         pause;
     end
end