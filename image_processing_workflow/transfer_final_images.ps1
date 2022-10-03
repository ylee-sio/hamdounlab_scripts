cd $HOME

$continue = "y"

do {
    $exp_list = Get-ChildItem -Directory -Name experiments
    $exp_list_length = $exp_list.Length-1

    echo "Available experiments IDs:"
    echo " "

    foreach($i in 0..$exp_list_length){"[$i] " + $exp_list[$i]}
    echo " "
    $exp_id_choice = Read-Host -Prompt "Select experiment ID"
    $exp_id = $exp_list[$exp_id_choice]

    $exp_id_dir_name = "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id"
    if (Test-Path $exp_id_dir_name) {
	    Write-Host "This directory already exists. Using existing directory."
        echo ""
    }
    else
    {
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
    }
    else
    {
	    New-Item $complete_well_id_dir_name -ItemType Directory
        echo "Created new directory $well_id_dir_name"
    }

    $site_id = Read-Host -Prompt "Enter site ID"
    mkdir -p "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id/$complete_well_id/$site_id"

    cp -r "$HOME/OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/*"  "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id/$complete_well_id/$site_id/"

    echo " "
    $continue = Read-Host -Prompt "Continue saving other wells/sites? (Enter y or n)"
 
    } while ($continue -eq "y")

    $move_to_final_locations = Read-Host -Prompt "Ready to move session files to the Hamdoun Lab official in situ database? (Enter y to transfer files or n to exit.)"
    
    if ($move_to_final_locations -eq "y") {

        cp -r  "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id"  "$HOME/OneDrive - UC San Diego/HL_official_expression_panel_reference_images"
        mv "$HOME/OneDrive - UC San Diego/temp/final_images/$exp_id"  "D:\HL_official_expression_panel_reference_images"

    }