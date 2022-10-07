$wv_list = @("w1", "w2", "w3", "w4", "w5")

#experiment selection
$exp_list = Get-ChildItem -Directory -Name J:\yl\experiments
$exp_list_length = $exp_list.Count-1

echo "Available experiments IDs:"
echo " "

if ($exp_list.count -gt 1) {
foreach($i in 0..$exp_list_length){
"[$i] " + $exp_list[$i]

}

echo " "
$exp_id_choice = Read-Host -Prompt "Select experiment ID"
$exp_id = $exp_list[$exp_id_choice]


} else {
echo "Only one experiment available. Selecting $exp_list"
$exp_id = $exp_list
}



$exp_id_dir_name = "$HOME/temp/$exp_id"
if (Test-Path $exp_id_dir_name) {
    Write-Host "This directory already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $exp_id_dir_name -ItemType Directory
        echo "Created new directory $exp_id_dir_name"
    }


#well selection
$well_id_list = Get-ChildItem -Directory -Name J:\yl\experiments/$exp_id
$well_id_list_length = $well_id_list.Count

if ($well_id_list.count -gt 1) {
echo "Available well IDs:"
echo " "

foreach($i in 0..$well_id_list_length){
"[$i] " + $well_id_list[$i]

}echo " "
$well_id_choice = Read-Host -Prompt "Select well ID"
$well_id = $well_id_list[$well_id_choice]
} else {echo "Only one well available. Selecting $well_id_list"
$well_id = $well_id_list}




$well_id_dir_name = "$HOME/temp/$exp_id/$well_id"
if (Test-Path $well_id_dir_name) {
    Write-Host "This directory already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $well_id_dir_name -ItemType Directory
        echo "Created new directory $well_id_dir_name"
    }

#site_selection
$reprocess_check = 0
do{
$site_id_list = Get-ChildItem -Directory -Name J:\yl\experiments/$exp_id/$well_id
$site_id_list_length = $site_id_list.Count-1

echo "Available site IDs:"
echo " "

if ($site_id_list.count -gt 1) {
foreach($i in 0..$site_id_list_length){
"[$i] " + $site_id_list[$i]

}echo " "
$site_id_choice = Read-Host -Prompt "Select site ID"
$site_id = $site_id_list[$site_id_choice]

} else {echo "Only one site available. Selecting $site_list"
$site_id = $site_list}
    



$wv_quickfix = Read-Host -Prompt "Do you need wavelength quick fix? (Enter y/n)"
                if ($wv_quickfix -eq "y"){

                    cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/w1" "J:\yl\experiments/$exp_id/$well_id/$site_id/original_w1"
                    cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/w2" "J:\yl\experiments/$exp_id/$well_id/$site_id/original_w2"
                    cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/w3" "J:\yl\experiments/$exp_id/$well_id/$site_id/original_w3"
                    cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/w4" "J:\yl\experiments/$exp_id/$well_id/$site_id/original_w4"

                    $incorrect_w1_label = Read-Host -Prompt "What wavelength is your transmitted light channel labeled as (Enter w1, w2, or w3, etc.)? If you don't have one, enter 'na' "
                    if ($incorrect_w1_label -eq "na") {
                    $incorrect_w1_label = "w1"
                        mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w1"
                        cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w1_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w1"
                    } else {
                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w1"
                    mv "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w1_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w1"
                    
                    }  
                    
                    $incorrect_w2_label = Read-Host -Prompt "What wavelength is your Cy5 (647nm) channel labeled as? (Enter w1, w2, or w3, etc.)? If you don't have one, enter 'na' "
                    if ($incorrect_w2_label -eq "na") {
                    $incorrect_w2_label = "w2"
                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w2"
                        cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w2_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w2"
                    } else {
                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w2"
                    cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w2_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w2/"}


                    
                    $incorrect_w3_label = Read-Host -Prompt "What wavelength is your TRITC (546nm) channel labeled as? (Enter w1, w2, or w3, etc.)? If you don't have one, enter 'na' "
                    if ($incorrect_w3_label -eq "na") {
                    $incorrect_w3_label = "w3"
                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w3"
                        cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w3_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w3"
                    } else {
                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w3"
                    cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w3_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w3/"}



                    $incorrect_w4_label = Read-Host -Prompt "What wavelength is your FITC (488nm) channel labeled as? (Enter w1, w2, or w3, etc.)? If you don't have one, enter 'na' "
                    if ($incorrect_w4_label -eq "na") {
                    $incorrect_w4_label = "w4"
                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w4"
                        cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w4_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w4"
                    } else {
                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w4"
                    cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w4_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w4/"}


                    
                    $incorrect_w5_label = Read-Host -Prompt "What wavelength is your DAPI (405nm) channel labeled as? (Enter w1, w2, or w3, etc.)? If you don't have one, enter 'na' "
                    if ($incorrect_w5_label -eq "na") {
                    $incorrect_w5_label = "w5"
                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w5"
                    cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w5_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w5"
                    } else {
                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w5"
                    cp -r "J:\yl\experiments/$exp_id/$well_id/$site_id/*/*$incorrect_w5_label*" "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w5/"}

                    

                    mkdir "J:\yl\experiments/$exp_id/$well_id/$site_id/w5" 
                    mv "J:\yl\experiments/$exp_id/$well_id/$site_id/w5" "J:\yl\experiments/$exp_id/$well_id/$site_id/original_w5"

                    mv "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w1" "J:\yl\experiments/$exp_id/$well_id/$site_id/w1"
                    mv "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w2" "J:\yl\experiments/$exp_id/$well_id/$site_id/w2"
                    mv "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w3" "J:\yl\experiments/$exp_id/$well_id/$site_id/w3"
                    mv "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w4" "J:\yl\experiments/$exp_id/$well_id/$site_id/w4"
                    mv "J:\yl\experiments/$exp_id/$well_id/$site_id/temp_w5" "J:\yl\experiments/$exp_id/$well_id/$site_id/w5"
}

                
echo "***** IMPORTANT *****"
echo "Please do not enter spaces, dashes, slashes, or any non-alphanumeric character. Keep everything lowercase."
$gene_w2 = Read-Host -Prompt "What should be the image annotation for w2 (gene, antibody, dye, etc.)? "
$gene_w3 = Read-Host -Prompt "What should be the image annotation for w3 (gene, antibody, dye, etc.)? "
$gene_w4 = Read-Host -Prompt "What should be the image annotation for w4 (gene, antibody, dye, etc.)? "
$complete_well_id = $well_id + "_" + $gene_w2 + "_" + $gene_w3 + "_" + $gene_w4
$site_id_dir_name = "$HOME/temp/$exp_id/$well_id/$site_id"
if (Test-Path $site_id_dir_name) {
    $reprocess_site_1 = Read-Host -Prompt "It looks like you already processed this site in $well_id, $exp_id. Do you want to reprocess this $site_id ? (Enter y/n)"
    
    if ($reprocess_site_1 -eq "y"){
        $reprocess_site_2 = Read-Host -Prompt "Are you sure you want to do this? Doing this will erase processed contents related to $site_id in $well_id, $exp_id in this temp folder. (Enter y/n)"
            if ($reprocess_site_2 -eq "y"){
                echo "Deleting processed contents related to $site_id in $well_id, $exp_id in $HOME/temp"
                rm -r $site_id_dir_name
                echo "Deleted processed contents related to $site_id in $well_id, $exp_id in $HOME/temp"

                New-Item $site_id_dir_name -ItemType Directory
                echo "Created new directory $site_id_dir_name"
                mkdir "$site_id_dir_name\single_channel\cuts"
                mkdir "$site_id_dir_name\single_channel_with_dapi\cuts"
                mkdir "$site_id_dir_name\double_channel\cuts"
                mkdir "$site_id_dir_name\double_channel_with_dapi\cuts"
                mkdir "$site_id_dir_name\triple_channel\cuts"
                mkdir "$site_id_dir_name\triple_channel_with_dapi\cuts"
                $reprocess_check = 1

                
                $binning = Read-Host -Prompt "How has your image run been binned? (Enter 1 or 2)"
                    if ($binning -eq 2){
                
                Read-Host -Prompt "Press any key to start this Fiji/ImageJ run."
            
         .\Applications\bin_level_2\Fiji.app\ImageJ-win64.exe -eval "File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w1/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w2/');  File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w3/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w4/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w5/'); var w2_text = '$gene_w2'; var w3_text = '$gene_w3'; var w4_text = '$gene_w4';var w5_text = '$exp_id'; var w6_text = '$complete_well_id'; var w7_text = '$site_id';"
        } else {           Read-Host -Prompt "Press any key to start this Fiji/ImageJ run."
            
         .\Applications\Fiji.app\ImageJ-win64.exe -eval "File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w1/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w2/');  File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w3/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w4/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w5/'); var w2_text = '$gene_w2'; var w3_text = '$gene_w3'; var w4_text = '$gene_w4';var w5_text = '$exp_id'; var w6_text = '$complete_well_id'; var w7_text = '$site_id';"}

                } else{
                    $reprocess_check = 0
                    $exit_choice = Read-Host -Prompt "Enter any key to reselect a site or 'q' to exit."
                    if ($exit_choice -eq "q") {break} else {continue}
                }
    } else {
        $reprocess_check = 0
        $exit_choice = Read-Host -Prompt "Enter any key to reselect a site or 'q' to exit."
        if ($exit_choice -eq "q") {break} else {continue}
        }


    } else {
	    New-Item $site_id_dir_name -ItemType Directory
        echo "Created new directory $site_id_dir_name"
        mkdir "$site_id_dir_name\single_channel\cuts"
        mkdir "$site_id_dir_name\single_channel_with_dapi\cuts"
        mkdir "$site_id_dir_name\double_channel\cuts"
        mkdir "$site_id_dir_name\double_channel_with_dapi\cuts"
        mkdir "$site_id_dir_name\triple_channel\cuts"
        mkdir "$site_id_dir_name\triple_channel_with_dapi\cuts"
        $reprocess_check = 1
      
       $binning = Read-Host -Prompt "How has your image run been binned? (Enter 1 or 2)"
                    if ($binning -eq 2){
                
                Read-Host -Prompt "Press any key to start this Fiji/ImageJ run."
            
         .\Applications\bin_level_2\Fiji.app\ImageJ-win64.exe -eval "File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w1/');File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w2/');  File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w3/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w4/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w5/'); var w2_text = '$gene_w2'; var w3_text = '$gene_w3'; var w4_text = '$gene_w4';var w5_text = '$exp_id'; var w6_text = '$complete_well_id'; var w7_text = '$site_id';"
        } else {           Read-Host -Prompt "Press any key to start this Fiji/ImageJ run."
            
         .\Applications\bin_level_2\Fiji.app\ImageJ-win64.exe -eval "File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w1/');File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w2/');  File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w3/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w4/'); File.openSequence('J:/yl/experiments/$exp_id/$well_id/$site_id/w5/'); var w2_text = '$gene_w2'; var w3_text = '$gene_w3'; var w4_text = '$gene_w4';var w5_text = '$exp_id'; var w6_text = '$complete_well_id'; var w7_text = '$site_id';"
         }
         
   
    }
} while ($reprocess_check -eq 0)

