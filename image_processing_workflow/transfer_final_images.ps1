# Google Drive path to HL_official_expression_panel_reference_images
$gdrive = "H:\Shared drives\hamdoun-lab\HL_official_expression_panel_reference_images"

# OneDrive path
$odrive = "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images"

# HL_RAID10
$hl_raid10 = "D:\HL_official_expression_panel_reference_images"

#experiment selection
$exp_list = Get-ChildItem -Directory -Name $HOME/temp

if ($exp_list.count -gt 1) {
    
    $most_recent_exp = Get-ChildItem $HOME/temp -Directory | Sort-Object -Property -CreationTime | Select-Object -First 1  
    $most_recent_exp_time = Get-ChildItem $HOME/temp -Directory | Sort-Object -Property -CreationTime | Select-Object -ExpandProperty CreationTime -First 1
    echo "Most recent exp: $most_recent_exp at $most_recent_exp_time"
    echo "All available experiments IDs:"
    echo " "

    foreach($i in 0..$exp_list.count){
        "[$i] " + $exp_list[$i]
        }
    $exp_id_choice = Read-Host -Prompt "Select experiment ID"
    $exp_id = $exp_list[$exp_id_choice]

} else {
    echo "The only experiment in this directory is $exp_list."
    echo "Selecting $exp_list"
    $exp_id = $exp_list
}
    
echo " "
$exp_id_dir_name_gdrive = "$gdrive/$exp_id"
if (Test-Path $exp_id_dir_name_gdrive) {
    Write-Host "$exp_id_dir_name_gdrive already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $exp_id_dir_name_gdrive -ItemType Directory > $null
    }

$exp_id_dir_name_odrive = "$odrive/$exp_id"
if (Test-Path $exp_id_dir_name_odrive) {
    Write-Host "$exp_id_dir_name_odrive already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $exp_id_dir_name_odrive -ItemType Directory > $null
    }

#well selection
$well_id_list = Get-ChildItem -Directory -Name $HOME/temp/$exp_id

if ($well_id_list.count -gt 1) {
    
    $most_recent_well = Get-ChildItem $HOME/temp -Directory | Sort-Object -Property -CreationTime | Select-Object -First 1  
    $most_recent_well_time = Get-ChildItem $HOME/temp -Directory | Sort-Object -Property -CreationTime | Select-Object -Property CreationTime -First 1
    echo "Most recent well: $most_recent_well at $most_recent_well_time"
    echo "Most recent well: $most_recent_well at $most_recent_well_time"
    echo "All available well IDs:"
    echo " "

    foreach($i in 0..$well_id_list.count){
        "[$i] " + $well_id_list[$i]
        }
    $well_id_choice = Read-Host -Prompt "Select well ID"
    $well_id = $well_id_list[$well_id_choice]
} else {

    echo "The only well in this experiment is $well_id_list"
    echo "Selecting $well_id_list"
    $well_id = $well_id_list
}

echo "Enter, with USING ONLY ALPHANUMERIC CHARACTERS (no spaces or slashes), genes present in this well"
$gene_1 = Read-Host -Prompt "Gene 1"
$gene_2 = Read-Host -Prompt "Gene 2"
$gene_3 = Read-Host -Prompt "Gene 3"
$complete_well_id = $well_id + "_" + $gene_1 + "_" + $gene_2 + "_" + $gene_3

$well_id_dir_name_gdrive = "$gdrive/$exp_id/$complete_well_id"
if (Test-Path $well_id_dir_name_gdrive) {
    Write-Host "$well_id_dir_name_gdrive already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $well_id_dir_name_gdrive -ItemType Directory > $null
    }

$well_id_dir_name_odrive = "$odrive/$exp_id/$complete_well_id"
if (Test-Path $well_id_dir_name_odrive) {
    Write-Host "$well_id_dir_name_odrive already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $well_id_dir_name_odrive -ItemType Directory > $null
    }

#site selection
$site_id_list = Get-ChildItem -Directory -Name $HOME/temp/$exp_id/$well_id

if ($site_id_list.count -gt 1) {

    $most_recent_site = Get-ChildItem $HOME/temp -Directory | Sort-Object -Property -CreationTime | Select-Object -First 1  
    $most_recent_site_time = Get-ChildItem $HOME/temp -Directory | Sort-Object -Property -CreationTime | Select-Object -siteandProperty CreationTime -First 1
    echo "Most recent site: $most_recent_site at $most_recent_site_time"
    echo "Most recent site: $most_recent_site at $most_recent_site_time"
    echo "All available site IDs:"
    echo " "


    foreach($i in 0..$site_id_list.count){
        "[$i] " + $site_id_list[$i]
        }
    $site_id_choice = Read-Host -Prompt "Select site ID"
    $site_id = $site_id_list[$site_id_choice]
} else {

    echo "The only site in this experiment is $site_id_list."
    echo "Selecting $site_id_list"
    $site_id = $site_id_list
}
 

$site_id_dir_name_gdrive = "$gdrive/$exp_id/$complete_well_id/$site_id"
if (Test-Path $site_id_dir_name_gdrive) {
    Write-Host "$site_id_dir_name_gdrive already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $site_id_dir_name_gdrive -ItemType Directory > $null
    }

$site_id_dir_name_odrive = "$odrive/$exp_id/$complete_well_id/$site_id"
if (Test-Path $site_id_dir_name_odrive) {
    Write-Host "$site_id_dir_name_odrive already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $site_id_dir_name_odrive -ItemType Directory > $null

    }

# make basic_montages
$image_dir = "$HOME/temp/$exp_id/$well_id/$site_id"
$single_channel_cuts_list = Get-ChildItem -File "$image_dir/single_channel/cuts/"
$single_channel_cuts_path = "$image_dir/single_channel/cuts/*"

if ($single_channel_cuts_list.count -gt 1) {
    
    echo "A window displaying all available single channel cuts for $site_id in $well_id in $exp_id."
    echo "`nScroll through the photos with your arrow keys. Then come back to Powershell using alt+Tab" 
    echo "`nWhen you have decided on the cut for that site, select the cut you wish to have displayed in the  preview panel by entering 'cut_#' in the following prompts."
    echo "Other channel combos for the selected cut will be selected based on the single channel cut selection."

    echo " "
    Read-Host -Prompt "Press any key to begin."
    
    ii $single_channel_cuts_path
    $single_channel_cuts_choice = Read-Host -Prompt "Select one desired representative cut for preview panel: (cut_#) "
    taskkill /f /im dllhost.exe > $null

} else {

    echo "No cuts available. Not making preview panel ready cuts."
}


mkdir $image_dir/panels > $null

montage $image_dir/single_channel/w2_labeled.tif $image_dir/single_channel/w3_labeled.tif $image_dir/single_channel/w4_labeled.tif $image_dir/single_channel/DAPI_labeled.tif -geometry +4+1 $image_dir/panels/single_channel_montage.tif
montage $image_dir/single_channel/cuts/w2_$single_channel_cuts_choice.tif $image_dir/single_channel/cuts/w3_$single_channel_cuts_choice.tif $image_dir/single_channel/cuts/w4_$single_channel_cuts_choice.tif $image_dir/single_channel/cuts/DAPI_$single_channel_cuts_choice.tif -geometry +4+1 $image_dir/panels/single_channel_montage_$single_channel_cuts_choice.tif
montage $image_dir/single_channel_with_dapi/w2_dapi.tif $image_dir/single_channel_with_dapi/w3_dapi.tif $image_dir/single_channel_with_dapi/w4_dapi.tif -geometry +3+1 $image_dir/panels/single_channel_with_dapi_montage.tif
montage $image_dir/single_channel_with_dapi/cuts/w2_DAPI_$single_channel_cuts_choice.tif $image_dir/single_channel_with_dapi/cuts/w3_DAPI_$single_channel_cuts_choice.tif $image_dir/single_channel_with_dapi/cuts/w4_DAPI_$single_channel_cuts_choice.tif -geometry +3+1 $image_dir/panels/single_channel_with_dapi_montage_DAPI_$single_channel_cuts_choice.tif
montage $image_dir/double_channel/w2_w3.tif $image_dir/double_channel/w2_w4.tif $image_dir/double_channel/w3_w4.tif -geometry +3+1 $image_dir/panels/double_channel_montage.tif
montage $image_dir/double_channel/cuts/w2_w3_$single_channel_cuts_choice.tif $image_dir/double_channel/cuts/w2_w4_$single_channel_cuts_choice.tif $image_dir/double_channel/cuts/w3_w4_$single_channel_cuts_choice.tif -geometry +3+1 $image_dir/panels/double_channel_montage_$single_channel_cuts_choice.tif
montage $image_dir/double_channel_with_dapi/w2_w3_DAPI.tif $image_dir/double_channel_with_dapi/w2_w4_DAPI.tif $image_dir/double_channel_with_dapi/w3_w4_DAPI.tif -geometry +3+1 $image_dir/panels/double_channel_with_dapi_montage_DAPI.tif
montage $image_dir/double_channel_with_dapi/cuts/w2_w3_DAPI_$single_channel_cuts_choice.tif $image_dir/double_channel_with_dapi/cuts/w2_w4_DAPI_$single_channel_cuts_choice.tif $image_dir/double_channel_with_dapi/cuts/w3_w4_DAPI_$single_channel_cuts_choice.tif -geometry +3+1 $image_dir/panels/double_channel_with_dapi_montage_DAPI_$single_channel_cuts_choice.tif

$move_to_final_locations = Read-Host -Prompt "Ready to move session files to the Hamdoun Lab official in situ database? (Enter y to transfer files or n to exit.)"
    
if ($move_to_final_locations -eq "y") {
    # to odrive
    cp -r "$HOME/temp/$exp_id/$well_id/$site_id/" "$odrive/$exp_id/$complete_well_id/$site_id/"
    mkdir "$odrive/$exp_id/$complete_well_id/$site_id/raw_images"
    cp -r "$HOME/experiments/$exp_id/$well_id/$site_id/*" "$odrive/$exp_id/$complete_well_id/$site_id/raw_images"

    # to gdrive
    cp -r "$HOME/temp/$exp_id/$well_id/$site_id/" "$gdrive/$exp_id/$complete_well_id/$site_id/"
    mkdir "$gdrive/$exp_id/$complete_well_id/$site_id/raw_images"
    cp -r "$HOME/experiments/$exp_id/$well_id/$site_id/*" "$gdrive/$exp_id/$complete_well_id/$site_id/raw_images"

    # to HL_RAID10
    mv "$HOME/temp/$exp_id/$well_id/$site_id/" "$hl_raid10/$exp_id/$complete_well_id/$site_id/"
    mkdir "$$hl_raid10/$exp_id/$complete_well_id/$site_id/raw_images"
    cp -r "$HOME/experiments/$exp_id/$well_id/$site_id/*" "$hl_raid10/$exp_id/$complete_well_id/$site_id/raw_images"
    
    
    Read-Host -Prompt "Press any key to exit."
    }