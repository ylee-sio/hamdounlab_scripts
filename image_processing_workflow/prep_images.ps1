cd $HOME

$FolderName = "$HOME/experiments/"
if (Test-Path $FolderName) {
	Write-Host "Directory exists."
}
 else
 {
	New-Item $FolderName -ItemType Directory
}

$user_id = Read-Host -Prompt "Enter name of your personal image acquisition folder name"
$exp_id = Read-Host -Prompt "Enter name of your experiment directory (yyyymmdd-expxxxx)"
$run_date = Read-Host -Prompt "Enter run date (yyyy-mm-dd)"
$run_id = Read-Host -Prompt "Enter run id (404 or 315 or xxx)"

$new_exp_analysis_folder = $exp_id + "_analysis"
mkdir -p experiments/$new_exp_analysis_folder

echo "********** STARTING MULTITHREADED COPY FROM SERVER TO LOCAL **********"

robocopy \\Ixm-5155033\f\FileServer\$user_id\$exp_id\$run_date\$run_id\TimePoint_1 $HOME/experiments/$new_exp_analysis_folder /MT:8 /S /E

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
foreach ($i in $well_folders){mkdir -p $i/s13}
foreach ($i in $well_folders){mkdir -p $i/s14}
foreach ($i in $well_folders){mkdir -p $i/s15}
foreach ($i in $well_folders){mkdir -p $i/s16}

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
