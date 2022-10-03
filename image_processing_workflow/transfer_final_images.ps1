cd $HOME

$exp_list = Get-ChildItem -Directory -Name experiments
$exp_list_length = $exp_list.Length-1

echo "Available experiments IDs:"
echo " "

foreach($i in 0..$exp_list_length){
"[$i] " + $exp_list[$i]
}
    
echo " "
$exp_id_choice = Read-Host -Prompt "Select experiment ID"
$exp_id = $exp_list[$exp_id_choice]

$exp_id_dir_name = "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id"
if (Test-Path $exp_id_dir_name) {
    Write-Host "This directory already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $exp_id_dir_name -ItemType Directory
        echo "Created new directory $exp_id_dir_name"
    }

$well_id = Read-Host -Prompt "Enter well ID"
echo "Enter, with USING ONLY ALPHANUMERIC CHARACTERS (no spaces or slashes), genes present in this well"
$gene_1 = Read-Host -Prompt "Gene 1"
$gene_2 = Read-Host -Prompt "Gene 2"
$gene_3 = Read-Host -Prompt "Gene 3"
$complete_well_id = $well_id + "_" + $gene_1 + "_" + $gene_2 + "_" + $gene_3
$complete_well_id_dir_name = "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id/$complete_well_id"
    
if (Test-Path $complete_well_id_dir_name) {
    Write-Host "This directory already exists. Using existing directory."
    } else {
	    New-Item $complete_well_id_dir_name -ItemType Directory
        echo "Created new directory $well_id_dir_name"
    }

$site_id = Read-Host -Prompt "Enter site ID"

# make basic_montages
$image_dir = "$HOME/OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer"
mkdir $image_dir/basic_montages

montage $image_dir/basic_montages/single_channel/w2_labeled.tif $image_dir/basic_montages/single_channel/w3_labeled.tif $image_dir/basic_montages/single_channel/w4_labeled.tif $image_dir/basic_montages/single_channel/DAPI_labeled.tif -geometry +4+1 $image_dir/basic_montages/montages/single_channel_montage.tif
montage $image_dir/basic_montages/single_channel/w2_cut_1.tif $image_dir/basic_montages/single_channel/w3_cut_1.tif $image_dir/basic_montages/single_channel/w4_cut_1.tif $image_dir/basic_montages/single_channel/DAPI_cut_1.tif -geometry +4+1 $image_dir/basic_montages/montages/single_channel_montage_cut_1.tif
montage $image_dir/basic_montages/single_channel_with_dapi/w2_dapi.tif $image_dir/basic_montages/single_channel_with_dapi/w3_dapi.tif $image_dir/basic_montages/single_channel_with_dapi/w4_dapi.tif -geometry +3+1 $image_dir/basic_montages/montages/single_channel_with_dapi_montage.tif
montage $image_dir/basic_montages/single_channel_with_dapi/w2_DAPI_cut_1.tif $image_dir/basic_montages/single_channel_with_dapi/w3_DAPI_cut_1.tif $image_dir/basic_montages/single_channel_with_dapi/w4_DAPI_cut_1.tif -geometry +3+1 $image_dir/basic_montages/montages/single_channel_with_dapi_montage_DAPI_cut_1.tif
montage $image_dir/basic_montages/double_channel/w2_w3.tif $image_dir/basic_montages/double_channel/w2_w4.tif $image_dir/basic_montages/double_channel/w3_w4.tif -geometry +3+1 $image_dir/basic_montages/montages/double_channel_montage.tif
montage $image_dir/basic_montages/double_channel/w2_w3_cut_1.tif $image_dir/basic_montages/double_channel/w2_w4_cut_1.tif $image_dir/basic_montages/double_channel/w3_w4_cut_1.tif -geometry +3+1 $image_dir/basic_montages/montages/double_channel_montage_cut_1.tif
montage $image_dir/basic_montages/double_channel_with_dapi/w2_w3_DAPI.tif $image_dir/basic_montages/double_channel_with_dapi/w2_w4_DAPI.tif $image_dir/basic_montages/double_channel_with_dapi/w3_w4_DAPI.tif -geometry +3+1 $image_dir/basic_montages/montages/double_channel_with_dapi_montage_DAPI.tif
montage $image_dir/basic_montages/double_channel_with_dapi/w2_w3_DAPI_cut_1.tif $image_dir/basic_montages/double_channel_with_dapi/w2_w4_DAPI_cut_1.tif $image_dir/basic_montages/double_channel_with_dapi/w3_w4_DAPI_cut_1.tif -geometry +3+1 $image_dir/basic_montages/montages/double_channel_with_dapi_montage_DAPI_cut_1.tif

mkdir -p "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id/$complete_well_id/$site_id"
cp -r "$HOME/OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/*"  "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id/$complete_well_id/$site_id/"

$move_to_final_locations = Read-Host -Prompt "Ready to move session files to the Hamdoun Lab official in situ database? (Enter y to transfer files or n to exit.)"
    
if ($move_to_final_locations -eq "y") {
    cp -r  "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id"  "$HOME/OneDrive - UC San Diego/HL_official_expression_panel_reference_images"
    mv "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id"  "D:\HL_official_expression_panel_reference_images"
    cp -r "$HOME/experiments/$exp_id/$well_id/$site_id" "$HOME/OneDrive - UC San Diego/HL_official_expression_panel_reference_images/$exp_id/$complete_well_id/$site_id/raw_images"
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
montage $merged -geometry +3+3 "$HOME/OneDrive - UC San Diego/HL_official_expression_panel_reference_images/live_single_channel_montage.tif"
montage $merged_cut_1 -geometry +3+3 "$HOME/OneDrive - UC San Diego/HL_official_expression_panel_reference_images/live_single_channel_cut_1_montage.tif"



