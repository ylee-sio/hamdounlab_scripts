Set-Alias -Name prep_images -Value ./hamdounlab_scripts/image_processing_workflow/prep_images.ps1
Set-Alias -Name transfer_final_images -Value ./hamdounlab_scripts/image_processing_workflow/transfer_final_images.ps1
Set-Alias -Name cleanup_images -Value ./hamdounlab_scripts/image_processing_workflow/cleanup_images.ps1
Set-Alias -Name imagej -Value ./hamdounlab_scripts/image_processing_workflow/imagej_user_lock_in.ps1
Set-Alias -Name setup_image_processing_pipeline -Value ./hamdounlab_scripts/image_processing_workflow/setup.ps1


echo "Planning on processing some in situ HCR images? Here are the four essential commands you can use:"
echo ""
echo "1) prep_images"
echo "2) imagej"
echo "3) transfer_final_images"
echo "4) cleanup_images"
echo ""
echo "Have a jolly day!"
echo ""