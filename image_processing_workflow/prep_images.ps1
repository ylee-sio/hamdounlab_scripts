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


$new_exp_analysis_folder = $exp_id + "_analysis"
mkdir -p experiments/$new_exp_analysis_folder

echo "********** STARTING MULTITHREADED COPY FROM SERVER TO LOCAL **********"

robocopy \\Ixm-5155033\f\FileServer\$user_id\$exp_id\$run_date\$run_id\TimePoint_1 $HOME/experiments/$new_exp_analysis_folder /MT:16 /S /E

echo "********** FINISHED COPYING FILES FROM SERVER TO LOCAL **********"
echo "********** CLEANING UP LOCAL FILES **********"

rm -r experiments/$new_exp_analysis_folder/*.tif*
rm -r experiments/$new_exp_analysis_folder/*/*thumb*
Get-ChildItem -Recurse experiments/$new_exp_analysis_folder/*/*.tif | Rename-Item -NewName {$_.Directory.Name + '_' + $_.Name}

$well_num_list = @('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24')

mkdir -p experiments/$new_exp_analysis_folder/filtered_sorted
cd experiments/$new_exp_analysis_folder/filtered_sorted
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("A" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("B" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("C" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("D" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("E" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("F" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("G" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("H" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("I" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("J" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("K" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("L" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("M" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("N" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("O" + $_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("P" + $_) }

$well_folders = ls

foreach ($i in $well_folders){mkdir -p $i/s1}
foreach ($i in $well_folders){mkdir -p $i/s2}
foreach ($i in $well_folders){mkdir -p $i/s3}
foreach ($i in $well_folders){mkdir -p $i/s4}
foreach ($i in $well_folders){mkdir -p $i/s5}
foreach ($i in $well_folders){mkdir -p $i/s6}
foreach ($i in $well_folders){mkdir -p $i/s7}
foreach ($i in $well_folders){mkdir -p $i/s8}
foreach ($i in $well_folders){mkdir -p $i/s9}
foreach ($i in $well_folders){mkdir -p $i/s10}
foreach ($i in $well_folders){mkdir -p $i/s11}
foreach ($i in $well_folders){mkdir -p $i/s12}

$site_folders = ls */*/
foreach ($i in $site_folders) {mkdir -p $i/w1}
foreach ($i in $site_folders) {mkdir -p $i/w2}
foreach ($i in $site_folders) {mkdir -p $i/w3}
foreach ($i in $site_folders) {mkdir -p $i/w4}
foreach ($i in $site_folders) {mkdir -p $i/w5}

$well_names = Get-ChildItem | 
       Where-Object {$_.PSIsContainer} | 
       Foreach-Object {$_.Name}

$site_names = Get-ChildItem A01 | 
       Where-Object {$_.PSIsContainer} | 
       Foreach-Object {$_.Name}

$wavelength_names = @('w1', 'w2', 'w3', 'w4', 'w5')

foreach ($k in $wavelength_names) {
	echo "********** SORTING $k FILES **********"
	foreach ($i in $well_names) {
		echo "Sorting well $i"
		foreach ($j in $site_names) {
			mv $HOME/experiments/$new_exp_analysis_folder/*/*$i`_$j`_$k* $HOME/experiments/$new_exp_analysis_folder/filtered_sorted/$i/$j/$k/}; 
	}
}

cd $HOME
mv $HOME/experiments/$new_exp_analysis_folder/filtered_sorted/* $HOME/experiments/$new_exp_analysis_folder
echo "DONE"

ii $HOME/experiments/$new_exp_analysis_folder