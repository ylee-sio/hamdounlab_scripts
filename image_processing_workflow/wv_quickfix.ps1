$change_dir = Read-Host Prompt "Copy the directory that contains your wavelength files and paste them here:"
cd $change_dir

mv w2 temp_w
mv w1 w2
mv w3 w1
mv temp_w w3
mv w1 temp_w
mv w4 w1
mv temp_w w4
mkdir w5
cp -r w1/* w5