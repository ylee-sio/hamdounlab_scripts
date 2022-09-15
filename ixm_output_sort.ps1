$exp_id = Read-Host -Prompt "Enter name of your experiment file 
(yyyymmdd-expxxxx): "
$user_id = Read-Host -Prompt "Enter name of your image acquisition folder 
name: "
$new_exp_analysis_folder = $exp_id + "_analysis"
mkdir $new_exp_analysis_folder
mkdir -p \\Ixm-5155033\f\FileServer\$user_id\$exp_id\stacks_only
cp -r \\Ixm-5155033\f\FileServer\$user_id\$exp_id\*\*\*\Z* 
\\Ixm-5155033\f\FileServer\$user_id\$exp_id\stacks_only

echo "********** STARTING MULTITHREADED COPY FROM SERVER TO LOCAL 
**********"

robocopy \\Ixm-5155033\f\FileServer\$user_id\$exp_id\ 
$HOME/$new_exp_analysis_folder /MT:16 /S /E

echo "********** FINISHED COPYING FILES FROM SERVER TO LOCAL **********"
echo "********** CLEANING UP LOCAL FILES **********"

rm -r $new_exp_analysis_folder/*/*/*/*thumb*
rm -r $new_exp_analysis_folder/*/*/*/*.tif*
rm -r $new_exp_analysis_folder/*/*/*/*/*thumb*
Get-ChildItem -Recurse $new_exp_analysis_folder/*/*/*/*/*.tif | 
Rename-Item -NewName {$_.Directory.Name + '_' + $_.Name}

$well_num_list = 
@('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24')

mkdir -p $new_exp_analysis_folder/filtered_sorted
cd $new_exp_analysis_folder/filtered_sorted
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("A" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("B" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("C" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("D" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("E" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("F" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("G" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("H" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("I" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("J" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("K" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("L" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("M" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("N" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("O" + 
$_) }
$well_num_list | foreach $_{ New-Item -ItemType directory -Name $("P" + 
$_) }

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
foreach ($i in $well_folders){mkdir -p $i/s17}
foreach ($i in $well_folders){mkdir -p $i/s18}
foreach ($i in $well_folders){mkdir -p $i/s19}
foreach ($i in $well_folders){mkdir -p $i/s20}
foreach ($i in $well_folders){mkdir -p $i/s21}
foreach ($i in $well_folders){mkdir -p $i/s22}
foreach ($i in $well_folders){mkdir -p $i/s23}
foreach ($i in $well_folders){mkdir -p $i/s24}
foreach ($i in $well_folders){mkdir -p $i/s25}

$site_folders = ls */*/
foreach ($i in $site_folders) {mkdir -p $i/wv1}
foreach ($i in $site_folders) {mkdir -p $i/wv2}
foreach ($i in $site_folders) {mkdir -p $i/wv3}
foreach ($i in $site_folders) {mkdir -p $i/wv4}
foreach ($i in $site_folders) {mkdir -p $i/wv5}
foreach ($i in $site_folders) {mkdir -p $i/wv6}


$well_names = Get-ChildItem | 
       Where-Object {$_.PSIsContainer} | 
       Foreach-Object {$_.Name}

$site_names = Get-ChildItem A01 | 
       Where-Object {$_.PSIsContainer} | 
       Foreach-Object {$_.Name}

echo "********** Sorting and moving wavelength 1 files ... **********"

foreach ($i in $well_names) {
	foreach ($j in $site_folders) {mv 
$HOME/$new_exp_analysis_folder/2*/*/*/*/*$i_$j_w1* 
$HOME/$new_exp_analysis_folder/filtered_sorted/$i/$j/wv1/}
}

echo "********** Sorting and moving wavelength 2 files ... **********"

foreach ($i in $well_names) {
	foreach ($j in $site_folders) {mv 
$HOME/$new_exp_analysis_folder/2*/*/*/*/*$i_$j_w2* 
$HOME/$new_exp_analysis_folder/filtered_sorted/$i/$j/wv2/}
}

echo "********** Sorting and moving wavelength 3 files ... **********"

foreach ($i in $well_names) {
	foreach ($j in $site_folders) {mv 
$HOME/$new_exp_analysis_folder/2*/*/*/*/*$i_$j_w3* 
$HOME/$new_exp_analysis_folder/filtered_sorted/$i/$j/wv3/}
}

echo "********** Sorting and moving wavelength 4 files ... **********"

foreach ($i in $well_names) {
	foreach ($j in $site_folders) {mv 
$HOME/$new_exp_analysis_folder/2*/*/*/*/*$i_$j_w4* 
$HOME/$new_exp_analysis_folder/filtered_sorted/$i/$j/wv4/}
}

echo "********** Sorting and moving wavelength 5 files ... **********"

foreach ($i in $well_names) {
	foreach ($j in $site_folders) {mv 
$HOME/$new_exp_analysis_folder/2*/*/*/*/*$i_$j_w5* 
$HOME/$new_exp_analysis_folder/filtered_sorted/$i/$j/wv5/}
}

echo "********** Sorting and moving wavelength 6 files ... **********"

foreach ($i in $well_names) {
	foreach ($j in $site_folders) {mv 
$HOME/$new_exp_analysis_folder/2*/*/*/*/*$i_$j_w6* 
$HOME/$new_exp_analysis_folder/filtered_sorted/$i/$j/wv6/}
}

