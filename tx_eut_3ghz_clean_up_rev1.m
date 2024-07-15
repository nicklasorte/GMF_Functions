function [cell_gmf]=tx_eut_3ghz_clean_up_rev1(app,gmf_header,cell_gmf)


    [num_gmf,~]=size(cell_gmf);
    col_tx_eut_idx=find(matches(gmf_header,'XEQ'))
     %unique(cell_gmf(:,col_tx_eut_idx))
    for gmf_idx=1:1:num_gmf
        temp_tx_eut_name=cell_gmf{gmf_idx,col_tx_eut_idx};
        if contains(temp_tx_eut_name,'RPS-42')
            temp_tx_eut_name='RPS-42';
        end

        if contains(temp_tx_eut_name,'RPS-62')
            temp_tx_eut_name='RPS-62';
        end


        if contains(temp_tx_eut_name,'RPS-82')
            temp_tx_eut_name='RPS-82';
        end

        if contains(temp_tx_eut_name,'RPS82')
            temp_tx_eut_name='RPS-82';
        end

        if contains(temp_tx_eut_name,'RPS-40')
            temp_tx_eut_name='RPS-40';
        end

        if contains(temp_tx_eut_name,'TPN-31')
            temp_tx_eut_name='TPN-31';
        end
      
        if contains(temp_tx_eut_name,'WSR-88D')
            temp_tx_eut_name='WSR-88D';
        end

        if contains(temp_tx_eut_name,'WSR88D')
            temp_tx_eut_name='WSR-88D';
        end

        if contains(temp_tx_eut_name,'ASR-9')
            temp_tx_eut_name='ASR-9';
        end
        
        if contains(temp_tx_eut_name,'TPS-075')
            temp_tx_eut_name='TPS-75';
        end

        if contains(temp_tx_eut_name,'TPS-75')
            temp_tx_eut_name='TPS-75';
        end

        if contains(temp_tx_eut_name,'TPQ-53')
            temp_tx_eut_name='TPQ-53';
        end

        cell_gmf{gmf_idx,col_tx_eut_idx}=temp_tx_eut_name;
    end


end