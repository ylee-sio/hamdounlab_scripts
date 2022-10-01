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

    $exp_id_dir_name = "$HOME/temp/final_images/$exp_id"
    if (Test-Path $exp_id_dir_name) {
	    Write-Host "This directory already exists. Using existing directory."
    }
    else
    {
	    New-Item $exp_id_dir_name -ItemType Directory
        echo "Created new directory $exp_id_dir_name"
    }

    $well_id = Read-Host -Prompt "Enter well ID"


    $well_id_dir_name = "$HOME/temp/final_images/$exp_id/$well_id"
    if (Test-Path $well_id_dir_name) {
	    Write-Host "This directory already exists. Using existing directory."
    }
    else
    {
	    New-Item $well_id_dir_name -ItemType Directory
        echo "Created new directory $well_id_dir_name"
    }

    $site_id = Read-Host -Prompt "Enter site ID"
    mkdir -p $HOME/temp/final_images/$exp_id/$well_id/$site_id

    cp -r $HOME/temp/temp_imagej_outputs_for_transfer/*  $HOME/temp/final_images/$exp_id/$well_id/$site_id/

    echo " "
    $continue = Read-Host -Prompt "Continue saving other experiment/wells/sites? (Enter y or n)"
    echo " "

    } while ($continue -eq "y")

