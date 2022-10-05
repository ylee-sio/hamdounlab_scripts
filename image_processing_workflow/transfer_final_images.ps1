# Google Drive path to HL_official_expression_panel_reference_images
$gdrive = "H:\Shared drives\hamdoun-lab\HL_official_expression_panel_reference_images"

# OneDrive path
$odrive = "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images"

#experiment selection
$exp_list = Get-ChildItem -Directory -Name $HOME/temp

if ($exp_list.count -gt 1) {
    
    echo "Available experiments IDs:"
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
	    New-Item $exp_id_dir_name_gdrive -ItemType Directory
        echo "Created new directory $exp_id_dir_name_gdrive"
    }

$exp_id_dir_name_odrive = "$odrive/$exp_id"
if (Test-Path $exp_id_dir_name_odrive) {
    Write-Host "$exp_id_dir_name_odrive already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $exp_id_dir_name_odrive -ItemType Directory
        echo "Created new directory $exp_id_dir_odrive"
    }

#well selection
$well_id_list = Get-ChildItem -Directory -Name $HOME/temp/$exp_id

if ($well_id_list.count -gt 1) {

    echo "Available well IDs:"
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
	    New-Item $well_id_dir_name_gdrive -ItemType Directory
        echo "Created new directory $well_id_dir_name_gdrive"
    }

$well_id_dir_name_odrive = "$odrive/$exp_id/$complete_well_id"
if (Test-Path $well_id_dir_name_odrive) {
    Write-Host "$well_id_dir_name_odrive already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $well_id_dir_name_odrive -ItemType Directory
        echo "Created new directory $well_id_dir_name_odrive"
    }

#site selection
$site_id_list = Get-ChildItem -Directory -Name $HOME/temp/$exp_id/$well_id

if ($site_id_list.count -gt 1) {

    echo "Available site IDs:"
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
	    New-Item $site_id_dir_name_gdrive -ItemType Directory
        echo "Created new directory $site_id_dir_name_gdrive"
    }

$site_id_dir_name_odrive = "$odrive/$exp_id/$complete_well_id/$site_id"
if (Test-Path $site_id_dir_name_odrive) {
    Write-Host "$site_id_dir_name_odrive already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $site_id_dir_name_odrive -ItemType Directory
        echo "Created new directory $site_id_dir_name_odrive"
    }

# make basic_montages
$image_dir = "$HOME/temp/temp_imagej_outputs_for_transfer"
mkdir $image_dir/basic_montages

montage $image_dir/basic_montages/single_channel/w2_labeled.tif $image_dir/basic_montages/single_channel/w3_labeled.tif $image_dir/basic_montages/single_channel/w4_labeled.tif $image_dir/basic_montages/single_channel/DAPI_labeled.tif -geometry +4+1 $image_dir/basic_montages/montages/single_channel_montage.tif
montage $image_dir/basic_montages/single_channel/w2_cut_1.tif $image_dir/basic_montages/single_channel/w3_cut_1.tif $image_dir/basic_montages/single_channel/w4_cut_1.tif $image_dir/basic_montages/single_channel/DAPI_cut_1.tif -geometry +4+1 $image_dir/basic_montages/montages/single_channel_montage_cut_1.tif
montage $image_dir/basic_montages/single_channel_with_dapi/w2_dapi.tif $image_dir/basic_montages/single_channel_with_dapi/w3_dapi.tif $image_dir/basic_montages/single_channel_with_dapi/w4_dapi.tif -geometry +3+1 $image_dir/basic_montages/montages/single_channel_with_dapi_montage.tif
montage $image_dir/basic_montages/single_channel_with_dapi/w2_DAPI_cut_1.tif $image_dir/basic_montages/single_channel_with_dapi/w3_DAPI_cut_1.tif $image_dir/basic_montages/single_channel_with_dapi/w4_DAPI_cut_1.tif -geometry +3+1 $image_dir/basic_montages/montages/single_channel_with_dapi_montage_DAPI_cut_1.tif
montage $image_dir/basic_montages/double_channel/w2_w3.tif $image_dir/basic_montages/double_channel/w2_w4.tif $image_dir/basic_montages/double_channel/w3_w4.tif -geometry +3+1 $image_dir/basic_montages/montages/double_channel_montage.tif
montage $image_dir/basic_montages/double_channel/w2_w3_cut_1.tif $image_dir/basic_montages/double_channel/w2_w4_cut_1.tif $image_dir/basic_montages/double_channel/w3_w4_cut_1.tif -geometry +3+1 $image_dir/basic_montages/montages/double_channel_montage_cut_1.tif
montage $image_dir/basic_montages/double_channel_with_dapi/w2_w3_DAPI.tif $image_dir/basic_montages/double_channel_with_dapi/w2_w4_DAPI.tif $image_dir/basic_montages/double_channel_with_dapi/w3_w4_DAPI.tif -geometry +3+1 $image_dir/basic_montages/montages/double_channel_with_dapi_montage_DAPI.tif
montage $image_dir/basic_montages/double_channel_with_dapi/w2_w3_DAPI_cut_1.tif $image_dir/basic_montages/double_channel_with_dapi/w2_w4_DAPI_cut_1.tif $image_dir/basic_montages/double_channel_with_dapi/w3_w4_DAPI_cut_1.tif -geometry +3+1 $image_dir/basic_montages/montages/double_channel_with_dapi_montage_DAPI_cut_1.tif

mkdir -p "$HOME/temp/$exp_id/$complete_well_id/$site_id"
cp -r "$HOME/temp/temp_imagej_outputs_for_transfer/*"  "$HOME/temp/$exp_id/$complete_well_id/$site_id/"

$move_to_final_locations = Read-Host -Prompt "Ready to move session files to the Hamdoun Lab official in situ database? (Enter y to transfer files or n to exit.)"
    
if ($move_to_final_locations -eq "y") {
    cp -r  "$HOME/temp/$exp_id"  "$HOME/HL_official_expression_panel_reference_images"
    mv "$HOME/temp/$exp_id"  "D:\HL_official_expression_panel_reference_images"
    cp -r "$HOME/experiments/$exp_id/$well_id/$site_id" "$HOME/HL_official_expression_panel_reference_images/$exp_id/$complete_well_id/$site_id/raw_images"
    $exit = Read-Host -Prompt "Press enter to exit."
    }

$available_exp_list =  Get-Childitem -Directory -Name "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\"
$merged = @()
$merged_cut_1 = @()

for ($i = 0; $i -lt $available_exp_list.length; $i++) {
    
    $current_exp_id = $available_exp_list[$i]
    
    $w2_labeled_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w2_labeled.tif" | % {$_.FullName}
    $w3_labeled_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w3_labeled.tif" | % {$_.FullName}
    $w4_labeled_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w4_labeled.tif" | % {$_.FullName}
    $DAPI_labeled_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\DAPI_labeled.tif" | % {$_.FullName}
    $w2_w3_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w2_w3.tif" | % {$_.FullName}
    $w2_w4_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w2_w4.tif" | % {$_.FullName}
    $w3_w4_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w3_w4.tif" | % {$_.FullName}
    $triple_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w2_w3_w4.tif" | % {$_.FullName}
    $merged = $merged + $w2_labeled_set + $w3_labeled_set + $w4_labeled_set + $DAPI_labeled_set + $w2_w3_set +$w2_w4_set + $w3_w4_set + $triple_set

    $w2_cut_1_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w2_cut_1.tif" | % {$_.FullName}
    $w3_cut_1_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w3_cut_1.tif" | % {$_.FullName}
    $w4_cut_1_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w4_cut_1.tif" | % {$_.FullName}
    $DAPI_cut_1_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\DAPI_cut_1.tif" | % {$_.FullName}
    $w2_w3_cut_1_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w2_w3_cut_1.tif" | % {$_.FullName}
    $w2_w4_cut_1_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w2_w4_cut_1.tif" | % {$_.FullName}
    $w3_w4_cut_1_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w3_w4_cut_1.tif" | % {$_.FullName}
    $triple_cut_1_set = Get-Childitem -Path "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images\$current_exp_id\*\s1\*\w2_w3_w4_cut_1.tif" | % {$_.FullName}
    $merged_cut_1 = $merged_cut_1 + $w2_cut_1_set + $w3_cut_1_set + $w4_cut_1_set + $DAPI_cut_1_set + $w2_w3_cut_1_set + $w2_w4_cut_1_set + $w3_w4_cut_1_set + $triple_cut_1_set

}
montage $merged -geometry +3+3 "$HOME/HL_official_expression_panel_reference_images/live_single_channel_montage.tif"
montage $merged_cut_1 -geometry +3+3 "$HOME/HL_official_expression_panel_reference_images/live_single_channel_cut_1_montage.tif"



