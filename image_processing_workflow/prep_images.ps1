# get, display, and record user_id choice
$user_list = Get-ChildItem -Directory -Name \\Ixm-5155033\f\FileServer\
$user_list_length = $user_list.Count
echo "Available users:"
echo " "
foreach($i in 0..$user_list_length){
"[$i] " + $user_list[$i]
}
echo " "
$user_id_choice = Read-Host -Prompt "Select number in user list"
$user_id = $user_list[$user_id_choice]

# get, display, and record exp_id choice
 $exp_id_list = Get-ChildItem -Directory -Name \\Ixm-5155033\f\FileServer\$user_id\
 $exp_id_list_length = $exp_id_list.Count
if ($exp_id_list_length -gt 1){
    

    echo "CURRENT STORAGE STATUS: "
    echo " "
    Get-Volume "C"
    echo " "

    echo "Calculating experiment sizes... This may take longer if experiments have not been transferred to HL_RAID10."
    echo " "
    echo "Available experiment IDs:"
    echo " "


    $colItems = Get-ChildItem "\\Ixm-5155033\f\FileServer\$user_id\" | Where-Object {$_.PSIsContainer -eq $true} | Sort-Object
    $k = 0
    foreach ($i in $colItems)
    {
    $subFolderItems = Get-ChildItem $i.FullName -recurse -force | Where-Object {$_.PSIsContainer -eq $false} | Measure-Object -property Length -sum | Select-Object Sum
    "[$k] " + $i.FullName + ” — ” + “{0:N2}” -f ($subFolderItems.sum / 1GB) + ” GB”
    $k=$k+1
    }

    echo " "
    $exp_id_choice = Read-Host -Prompt "Select number in experiment ID list"
    $exp_id = $exp_id_list[$exp_id_choice]

    if ($exp_id.length != 16){
        echo "This experiment does not follow standard experiment naming conventions."
        echo "Name needs to be changed to the following format: YYYYMMDD-exp####"
        echo "No file or directory names from the original source will be changed."
        echo "A text file will be generated in this experiment's folder to note this change."
        $exp_revised_date = Read-Host -Prompt "Please enter the run date of this experiment in the format above"
        $exp_revised_num = Read-Host -Prompt "Please enter the experiment number in the format above, ignoring the hyphen"
        $revised_exp_id = $exp_revised_date + "-" + $exp_revised_num
    } 

} else {$exp_id = Get-ChildItem -Directory -Name \\Ixm-5155033\f\FileServer\$user_id\*}


# get, display, and record run_date choice
$run_date_list = Get-ChildItem -Directory -Name \\Ixm-5155033\f\FileServer\$user_id\$exp_id
$run_date_list_length = $run_date_list.Count
if ($run_date_list_length -gt 1){

    echo "Available experiment IDs:"
    echo " "
    foreach($i in 0..$run_date_list_length){
        "[$i] " + $run_date_list[$i]
      }
    echo " "
        $run_date_choice = Read-Host -Prompt "Select number in run date list"
    $run_date = $run_date_list[$run_date_choice]

} else {$run_date = Get-ChildItem -Directory -Name \\Ixm-5155033\f\FileServer\$user_id\$exp_id\}

# get, display, and record run_id choice
$run_id_list = Get-ChildItem -Directory -Name \\Ixm-5155033\f\FileServer\$user_id\$exp_id\$run_date
$run_id_list_length = $run_id_list.Count
if ($run_id_list_length -gt 1){

    echo "Available experiment IDs:"
    echo " "
    foreach($i in 0..$run_id_list_length){
        "[$i] " + $run_id_list[$i]
      }
    echo " "
        $run_id_choice = Read-Host -Prompt "Select number in run ID list"
    $run_id = $run_id_list[$run_id_choice]

} else {$run_id = Get-ChildItem -Directory -Name \\Ixm-5155033\f\FileServer\$user_id\$exp_id\$run_date}


$source_dir = "\\Ixm-5155033\f\FileServer\$user_id\$exp_id\$run_date\$run_id\TimePoint_1"
$new_exp_analysis_folder = $exp_id + "_analysis"
mkdir -p experiments/$new_exp_analysis_folder
$destination = "$HOME/experiments/$new_exp_analysis_folder"

echo "********** STARTING MULTITHREADED COPY FROM SERVER TO LOCAL **********"

robocopy $source_dir $HOME/experiments/$new_exp_analysis_folder /MT:8 /S /E
rm -r $destination/*.tif
rm -r $destination/*/*thumb*

if ($exp_id.length != 16){
    
    Get-ChildItem -Recurse $destination/*/*.tif | Rename-Item -NewName {$_.Directory.Name + '_' + $revised_exp_id + $_.Name.substring($exp_id.length)}
    
    } else {

        Get-ChildItem -Recurse $destination/*/*.tif | Rename-Item -NewName {$_.Directory.Name + '_' + $_.Name}
    
    }


$dataset_characterization_file_list = Get-ChildItem -File -Name "$destination\ZStep_1\" -recurse -exclude *thumb*
$dataset_characterization_file_list_for_wv = Get-ChildItem -File -Name "$destination\ZStep_1\*_s1_*" -recurse -exclude *thumb*
$well_ids = $dataset_characterization_file_list.Substring(17,3) | Sort-Object | Get-Unique
$site_ids = $dataset_characterization_file_list.Substring(21,2) | Sort-Object | Get-Unique
$wv_ids = $dataset_characterization_file_list_for_wv.Substring(24,2)| Sort-Object | Get-Unique

foreach ($i in $well_ids){
    foreach($j in $site_ids){
        foreach ($k in $wv_ids){
            mkdir -p $HOME/experiments/$new_exp_analysis_folder/$i/$j/$k
        }
     }
   }

foreach ($i in $well_ids){
    foreach($j in $site_ids){
        foreach ($k in $wv_ids){
            mv $HOME/experiments/$new_exp_analysis_folder/*/*$i`_$j`_$k* $HOME/experiments/$new_exp_analysis_folder/$i/$j/$k
        }
     }
   }

echo "Standard wavelength configuration:"
echo "w1: transmitted light"
echo "w2: Cy5 (647nm)"
echo "w3: TRITC (546nm)"
echo "w4: FITC (488nm)"
echo "w5: DAPI (405nm)"
echo ""
$correct_wavelength_scheme_check = Read-Host -Prompt "Did this experiment use the standard wavelength configuration?"