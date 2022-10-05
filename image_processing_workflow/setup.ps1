mkdir $HOME/experiments
mkdir $HOME/temp
mkdir "$HOME\temp\final_images"
mkdir "$HOME\temp\temp_imagej_outputs_for_transfer\single_channel"
mkdir "$HOME\temp\temp_imagej_outputs_for_transfer\single_channel_with_dapi"
mkdir "$HOME\temp\temp_imagej_outputs_for_transfer\double_channel"
mkdir "$HOME\temp\temp_imagej_outputs_for_transfer\double_channel_with_dapi"
mkdir "$HOME\temp\temp_imagej_outputs_for_transfer\triple_channel"
mkdir "$HOME\temp\temp_imagej_outputs_for_transfer\triple_channel_with_dapi"
mkdir "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images"
mkdir "H:\Shared drives\hamdoun-lab\HL_official_expression_panel_reference_images"
mkdir $HOME/Applications
cp -r D:\software\Fiji.app $HOME\Applications
cp -r D:\hamdounlab_scripts\ $HOME\
rm "$HOME\Applications\Fiji.app\macros\StartupMacros.fiji.ijm"
cp -r D:\hamdounlab_scripts\image_processing_workflow\StartupMacros.fiji.ijm "$HOME\Applications\Fiji.app\macros\"
Set-ExecutionPolicy RemoteSigned