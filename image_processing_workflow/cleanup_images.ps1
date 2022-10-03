rm -r -Force "C:\Users\Yoon Lee\OneDrive - UC San Diego\temp\temp_imagej_outputs_for_transfer\*\*"

$exp_id_finish = Read-Host -Prompt "Are you completely finished processing images from $exp_id ? (Enter y or n. Entering y will remove all $exp_id files from your experiment folder.) "

if ($exp_id_finish -eq "y") {
    $exp_id_finish_double_check = Read-Host -Prompt "Are you SURE? (Enter y or n)"
    rm -r $HOME/experiments/$exp_id
} else {
    echo "Keeping $exp_id files. Please run this again when you are completely finished processing images from $exp_id to remove all images from $exp_id."
    echo "Files in individuals' experiment folders will be auto-removed every seven days and will need to be redownloaded/transferred."
}