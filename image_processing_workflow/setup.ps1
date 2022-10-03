mkdir $HOME/experiments
mkdir "$HOME\OneDrive - UC San Diego\temp\final_images"
mkdir "$HOME\OneDrive - UC San Diego\temp\temp_imagej_outputs_for_transfer\single_channel"
mkdir "$HOME\OneDrive - UC San Diego\temp\temp_imagej_outputs_for_transfer\single_channel_with_dapi"
mkdir "$HOME\OneDrive - UC San Diego\temp\temp_imagej_outputs_for_transfer\double_channel"
mkdir "$HOME\OneDrive - UC San Diego\temp\temp_imagej_outputs_for_transfer\double_channel_with_dapi"
mkdir "$HOME\OneDrive - UC San Diego\temp\temp_imagej_outputs_for_transfer\triple_channel"
mkdir "$HOME\OneDrive - UC San Diego\temp\temp_imagej_outputs_for_transfer\triple_channel_with_dapi"
mkdir "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images"
mkdir $HOME/Applications
cp -r D:\software\Fiji.app $HOME\Applications
rm "$HOME\Applications\Fiji.app\macros\StartupMacros.fiji.ijm"
cp -r D:\hamdounlab_scripts\image_processing_workflow\StartupMacros.fiji.ijm "$HOME\Applications\Fiji.app\macros\"
Set-ExecutionPolicy RemoteSigned
New-Alias -Name prep_images -Value ./hamdounlab_scripts/image_processing_workflow/prep_images.ps1
New-Alias -Name transfer_final_images -Value ./hamdounlab_scripts/image_processing_workflow/transfer_final_images.ps1
New-Alias -Name cleanup_images -Value ./hamdounlab_scripts/image_processing_workflow/cleanup_images.ps1