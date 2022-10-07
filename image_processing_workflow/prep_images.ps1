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
    

    echo "CURRENT LOCAL STORAGE STATUS: "
    Get-Volume "C"
    echo " "

    echo "Calculating experiment sizes... This may take longer if many experiments have not been transferred to HL_RAID10."
    echo " "
    echo "Available experiment IDs to pull from IXM-5155033:"
    echo " "


    $colItems = Get-ChildItem "\\Ixm-5155033\f\FileServer\$user_id\" | Where-Object {$_.PSIsContainer -eq $true} | Sort-Object
    $k = 0
    foreach ($i in $colItems)
    {
    $subFolderItems = Get-ChildItem $i.FullName -recurse -force | Where-Object {$_.PSIsContainer -eq $false} | Measure-Object -property Length -sum | Select-Object Sum
    "[$k] " + $i.FullName + ” — ” + “{0:N2}” -f ($subFolderItems.sum / 1GB) + ” GB”
    $k=$k+1
    }
    echo "`nNOTE: For every 50GB of image data, expect to wait between 5-10 minutes."
    $exp_id_choice = Read-Host -Prompt "Select number in experiment ID list"
    $exp_id = $exp_id_list[$exp_id_choice]

    if ($exp_id.length -ne 16){
        echo ""
        echo "This experiment does not follow standard experiment naming conventions."
        echo "Name needs to be changed to the following format: YYYYMMDD-exp####"
        echo "No file or directory names from the original source will be changed."
        echo "A text file will be generated in this experiment's folder to note this change."
        echo ""
        echo "CURRENT EXPERIMENT NAME: $exp_id" 
        $exp_revised_date = Read-Host -Prompt "`nPlease enter only the RUN DATE of this experiment in this format: YYYYMMDD"
        
        while ($exp_revised_date.length -ne 8){
            echo "**************************************************************************************"
            echo "`nInvalid entry. Please try again."
            echo "`nEnter only the run date EXACTLY in this format: exp####"
            $exp_revised_date = Read-Host -Prompt "`nPlease enter only the RUN DATE of this experiment in this format: YYYYMMDD"
        }

        $exp_revised_num = Read-Host -Prompt "`nIgnoring the hyphen, Please enter the NEW EXPERIMENT NUMBER in this format: exp####"

        while ($exp_revised_num.length -ne 7){
            echo "**************************************************************************************"
            echo "`nInvalid entry. Please try again."
            echo "`nEnter the experiment number EXACTLY in this format: exp####"
            $exp_revised_num = Read-Host -Prompt "`nIgnoring the hyphen, Please enter the NEW EXPERIMENT NUMBER in this format: exp####"
        }
        
        $revised_exp_id = $exp_revised_date + "-" + $exp_revised_num
        $new_exp_analysis_folder = $revised_exp_id + "_analysis"
    } else {$new_exp_analysis_folder = $exp_id}

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
mkdir -p experiments/$new_exp_analysis_folder
$destination = "J:/$user_id/experiments/$new_exp_analysis_folder"

echo "********** STARTING MULTITHREADED COPY FROM SERVER TO LOCAL **********"

robocopy $source_dir $destination /MT:8 /S /E
rm -r $destination/*.tif
rm -r $destination/*/*thumb*

if ($exp_id.length -ne 16){
    
    Get-ChildItem -Recurse $destination/*/*.tif | Rename-Item -NewName {$_.Directory.Name + '_' + $revised_exp_id + $_.Name.substring($exp_id.length)}
    $revision_information = "Original names of experiment files are never changed.`nOnly copies transferred to local experiment_analysis directories are reconfigured.`nThis experiment required file naming revisions.`n`nOriginal base name for files and directories in this experiment: " + $exp_id + "`nRevised base name for files and directories in this experiment: " + $revised_exp_id
    $revision_information | Out-File -FilePath $destination/revision_information.txt
    
    } else {

        Get-ChildItem -Recurse $destination/*/*.tif | Rename-Item -NewName {$_.Directory.Name + '_' + $_.Name}
    
    }

$dataset_characterization_file_list = Get-ChildItem -File -Name "$destination\ZStep_1\" -recurse -exclude *thumb*
$dataset_characterization_file_list_for_wv = Get-ChildItem -File -Name "$destination\ZStep_1\*_s1_*" -recurse -exclude *thumb*
$well_ids = $dataset_characterization_file_list.Substring(25,3) | Sort-Object | Get-Unique
$site_ids = $dataset_characterization_file_list.Substring(29,2) | Sort-Object | Get-Unique
$wv_ids = $dataset_characterization_file_list_for_wv.Substring(32,2)| Sort-Object | Get-Unique

foreach ($i in $well_ids){
    foreach($j in $site_ids){
        foreach ($k in $wv_ids){
            mkdir -p $destination/$i/$j/$k
        }
     }
   }

foreach ($i in $well_ids){
    foreach($j in $site_ids){
        foreach ($k in $wv_ids){
            mv $destination/*/*$i`_$j`_$k* $destination/$i/$j/$k
        }
     }
   }

rm -r $destination/Z*

#$correct_wavelength_scheme_check = Read-Host -Prompt "Did this experiment use the standard wavelength configuration?"
#echo "`nThis version of prep_images and Hamdoun Lab specific Fiji/ImageJ macros can only handle a total of 5 wavelengths."
#echo "`nThis is the standard channel/wavelength configuration:"
#echo "w1: transmitted light"
#echo "w2: Cy5 (647nm)"
#echo "w3: TRITC (546nm)"
#echo "w4: FITC (488nm)"
#echo "w5: DAPI (405nm)"
#$missing_wv_yn = Read-Host -Prompt "`nAre you missing any of these channels/wavelengths? (Enter y/n)"
#$standard_wv_yn = Read-Host -Prompt "`nHas this experiment been run in the standard configuration? (Enter y/n)"
#if ($missing_yn -eq "y"){}



ii $destination