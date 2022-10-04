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

    echo "Available experiment IDs:"
    echo " "
    foreach($i in 0..$exp_id_list_length){
        "[$i] " + $exp_id_list[$i]
      }
    echo " "
        $exp_id_choice = Read-Host -Prompt "Select number in experiment ID list"
    $exp_id = $exp_id_list[$exp_id_choice]

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
$dataset_characterization_file_list = Get-ChildItem -File -Name "$source_dir\ZStep_1\" -recurse -exclude *thumb*
$dataset_characterization_file_list_for_wv = Get-ChildItem -File -Name "$source_dir\ZStep_1\*_s1_*" -recurse -exclude *thumb*
$well_ids = $dataset_characterization_file_list.Substring(17,3) | Sort-Object | Get-Unique
$site_ids = $dataset_characterization_file_list.Substring(21,2) | Sort-Object | Get-Unique
$wv_ids = $dataset_characterization_file_list_for_wv.Substring(24,2)| Sort-Object | Get-Unique

$new_exp_analysis_folder = $exp_id + "_analysis"
mkdir -p experiments/$new_exp_analysis_folder

echo "********** STARTING MULTITHREADED COPY FROM SERVER TO LOCAL **********"

robocopy $source_dir $HOME/experiments/$new_exp_analysis_folder /MT:20 /S /E
Get-ChildItem -Recurse experiments/$new_exp_analysis_folder/*/*.tif | Rename-Item -NewName {$_.Directory.Name + '_' + $_.Name}

foreach ($i in $well_ids){
    foreach($j in $site_ids){
        foreach ($k in $wv_ids){
            mkdir -p $HOME/experiments/$exp_id/$i/$j/$k
        }
     }
   }

foreach ($i in $well_ids){
    foreach($j in $site_ids){
        foreach ($k in $wv_ids){
            mv $HOME/experiments/$new_exp_analysis_folder/*/*$i`_$j`_$k* $HOME/experiments/$exp_id/$i/$j/$k
        }
     }
   }

