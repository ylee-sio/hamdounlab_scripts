mkdir "$HOME/experiments"
mkdir "$HOME/temp"

mkdir "$HOME\OneDrive - UC San Diego\HL_official_expression_panel_reference_images"
mkdir "H:\Shared drives\hamdoun-lab\HL_official_expression_panel_reference_images"
mkdir $HOME/Applications
cp -r "D:\software\Fiji.app" $HOME\Applications
cp -r "D:\hamdounlab_scripts\" $HOME\
rm "$HOME\Applications\Fiji.app\macros\StartupMacros.fiji.ijm"
cp -r "D:\hamdounlab_scripts\image_processing_workflow\StartupMacros.fiji.ijm" "$HOME\Applications\Fiji.app\macros\"
cp "D:\hamdounlab_scripts\image_processing_workflow\Profile.ps1" $PSHOME
Set-ExecutionPolicy RemoteSigned