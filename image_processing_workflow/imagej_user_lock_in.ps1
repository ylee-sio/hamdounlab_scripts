#experiment selection
$exp_list = Get-ChildItem -Directory -Name experiments
$exp_list_length = $exp_list.Length-1

echo "Available experiments IDs:"
echo " "

if ($exp_list.count -gt 1) {
foreach($i in 0..$exp_list_length){
"[$i] " + $exp_list[$i]
}
} else {"[0] " + $exp_list[0]}
    
echo " "
$exp_id_choice = Read-Host -Prompt "Select experiment ID"
$exp_id = $exp_list[$exp_id_choice]

$exp_id_dir_name = "$HOME/temp/$exp_id"
if (Test-Path $exp_id_dir_name) {
    Write-Host "This directory already exists. Using existing directory."
    echo ""
    } else {
	    New-Item $exp_id_dir_name -ItemType Directory
        echo "Created new directory $exp_id_dir_name"
    }


#well selection
$well_id_list = Get-ChildItem -Directory -Name experiments/$exp_id
$well_id_list_length = $well_id_list.Length-1

echo "Available well IDs:"
echo " "

if ($well_id_list.count -gt 1) {
foreach($i in 0..$well_id_list_length){
"[$i] " + $well_id_list[$i]
}
} else {"[0] " + $well_id_list[0]}
    
echo " "
$well_id_choice = Read-Host -Prompt "Select well ID"
$well_id = $well_id_list[$well_id_choice]

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
$site_id_list = Get-ChildItem -Directory -Name experiments/$exp_id/$well_id
$site_id_list_length = $site_id_list.Length-1

echo "Available site IDs:"
echo " "

if ($site_id_list.count -gt 1) {
foreach($i in 0..$site_id_list_length){
"[$i] " + $site_id_list[$i]
}
} else {"[0] " + $site_id_list[0]}
    
echo " "

$site_id_choice = Read-Host -Prompt "Select site ID"
$site_id = $site_id_list[$site_id_choice]

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
                $reprocess_check = 1
                Read-Host -Prompt "Press any key to start this Fiji/ImageJ run."
                .\Applications\Fiji.app\ImageJ-win64.exe

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
        $reprocess_check = 1
        Read-Host -Prompt "Press any key to start this Fiji/ImageJ run."
        .\Applications\Fiji.app\ImageJ-win64.exe
    }
} while ($reprocess_check -eq 0)


