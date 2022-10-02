// "StartupMacros"
// The macros and macro tools in this file ("StartupMacros.txt") are
// automatically installed in the Plugins>Macros submenu and
//  in the tool bar when ImageJ starts up.

//  About the drawing tools.
//
//  This is a set of drawing tools similar to the pencil, paintbrush,
//  eraser and flood fill (paint bucket) tools in NIH Image. The
//  pencil and paintbrush draw in the current foreground color
//  and the eraser draws in the current background color. The
//  flood fill tool fills the selected area using the foreground color.
//  Hold down the alt key to have the pencil and paintbrush draw
//  using the background color or to have the flood fill tool fill
//  using the background color. Set the foreground and background
//  colors by double-clicking on the flood fill tool or on the eye
//  dropper tool.  Double-click on the pencil, paintbrush or eraser
//  tool  to set the drawing width for that tool.
//
// Icons contributed by Tony Collins.
Use this tool to create a point selection, to count objects or to record coordinates.
// Global variables
var pencilWidth=1,  eraserWidth=10, leftClick=16, alt=8;
var brushWidth = 10; //call("ij.Prefs.get", "startup.brush", "10");
var floodType =  "8-connected"; //call("ij.Prefs.get", "startup.flood", "8-connected");

// The macro named "AutoRunAndHide" runs when ImageJ starts
// and the file containing it is not displayed when ImageJ opens it.

// macro "AutoRunAndHide" {}

function UseHEFT {
	requires("1.38f");
	state = call("ij.io.Opener.getOpenUsingPlugins");
	if (state=="false") {
		setOption("OpenUsingPlugins", true);
		showStatus("TRUE (images opened by HandleExtraFileTypes)");
	} else {
		setOption("OpenUsingPlugins", false);
		showStatus("FALSE (images opened by ImageJ)");
	}
}

UseHEFT();

// The macro named "AutoRun" runs when ImageJ starts.

macro "AutoRun" {
	// run all the .ijm scripts provided in macros/AutoRun/
	autoRunDirectory = getDirectory("imagej") + "/macros/AutoRun/";
	if (File.isDirectory(autoRunDirectory)) {
		list = getFileList(autoRunDirectory);
		// make sure startup order is consistent
		Array.sort(list);
		for (i = 0; i < list.length; i++) {
			if (endsWith(list[i], ".ijm")) {
				runMacro(autoRunDirectory + list[i]);
			}
		}
	}
}

var pmCmds = newMenu("Popup Menu",
	newArray("Help...", "Rename...", "Duplicate...", "Original Scale",
	"Paste Control...", "-", "Record...", "Capture Screen ", "Monitor Memory...",
	"Find Commands...", "Control Panel...", "Startup Macros...", "Search..."));

macro "Popup Menu" {
	cmd = getArgument();
	if (cmd=="Help...")
		showMessage("About Popup Menu",
			"To customize this menu, edit the line that starts with\n\"var pmCmds\" in ImageJ/macros/StartupMacros.txt.");
	else
		run(cmd);
}

macro "Abort Macro or Plugin (or press Esc key) Action Tool - CbooP51b1f5fbbf5f1b15510T5c10X" {
	setKeyDown("Esc");
}

var xx = requires138b(); // check version at install
function requires138b() {requires("1.38b"); return 0; }

var dCmds = newMenu("Developer Menu Tool",
newArray("ImageJ Website","News", "Documentation", "ImageJ Wiki", "Resources", "Macro Language", "Macros",
	"Macro Functions", "Startup Macros...", "Plugins", "Source Code", "Mailing List Archives", "-", "Record...",
	"Capture Screen ", "Monitor Memory...", "List Commands...", "Control Panel...", "Search...", "Debug Mode"));

macro "Developer Menu Tool - C037T0b11DT7b09eTcb09v" {
	cmd = getArgument();
	if (cmd=="ImageJ Website")
		run("URL...", "url=http://rsbweb.nih.gov/ij/");
	else if (cmd=="News")
		run("URL...", "url=http://rsbweb.nih.gov/ij/notes.html");
	else if (cmd=="Documentation")
		run("URL...", "url=http://rsbweb.nih.gov/ij/docs/");
	else if (cmd=="ImageJ Wiki")
		run("URL...", "url=http://imagejdocu.tudor.lu/imagej-documentation-wiki/");
	else if (cmd=="Resources")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/");
	else if (cmd=="Macro Language")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/macros.html");
	else if (cmd=="Macros")
		run("URL...", "url=http://rsbweb.nih.gov/ij/macros/");
	else if (cmd=="Macro Functions")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/functions.html");
	else if (cmd=="Plugins")
		run("URL...", "url=http://rsbweb.nih.gov/ij/plugins/");
	else if (cmd=="Source Code")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/source/");
	else if (cmd=="Mailing List Archives")
		run("URL...", "url=https://list.nih.gov/archives/imagej.html");
	else if (cmd=="Debug Mode")
		setOption("DebugMode", true);
	else if (cmd!="-")
		run(cmd);
}

var sCmds = newMenu("Stacks Menu Tool",
	newArray("Add Slice", "Delete Slice", "Next Slice [>]", "Previous Slice [<]", "Set Slice...", "-",
		"Convert Images to Stack", "Convert Stack to Images", "Make Montage...", "Reslice [/]...", "Z Project...",
		"3D Project...", "Plot Z-axis Profile", "-", "Start Animation", "Stop Animation", "Animation Options...",
		"-", "MRI Stack (528K)"));
macro "Stacks Menu Tool - C037T0b11ST8b09tTcb09k" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}

var luts = getLutMenu();
var lCmds = newMenu("LUT Menu Tool", luts);
macro "LUT Menu Tool - C037T0b11LT6b09UTcb09T" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}
function getLutMenu() {
	list = getLutList();
	menu = newArray(16+list.length);
	menu[0] = "Invert LUT"; menu[1] = "Apply LUT"; menu[2] = "-";
	menu[3] = "Fire"; menu[4] = "Grays"; menu[5] = "Ice";
	menu[6] = "Spectrum"; menu[7] = "3-3-2 RGB"; menu[8] = "Red";
	menu[9] = "Green"; menu[10] = "Blue"; menu[11] = "Cyan";
	menu[12] = "Magenta"; menu[13] = "Yellow"; menu[14] = "Red/Green";
	menu[15] = "-";
	for (i=0; i<list.length; i++)
		menu[i+16] = list[i];
	return menu;
}

function getLutList() {
	lutdir = getDirectory("luts");
	list = newArray("No LUTs in /ImageJ/luts");
	if (!File.exists(lutdir))
		return list;
	rawlist = getFileList(lutdir);
	if (rawlist.length==0)
		return list;
	count = 0;
	for (i=0; i< rawlist.length; i++)
		if (endsWith(rawlist[i], ".lut")) count++;
	if (count==0)
		return list;
	list = newArray(count);
	index = 0;
	for (i=0; i< rawlist.length; i++) {
		if (endsWith(rawlist[i], ".lut"))
			list[index++] = substring(rawlist[i], 0, lengthOf(rawlist[i])-4);
	}
	return list;
}

macro "Pencil Tool - C037L494fL4990L90b0Lc1c3L82a4Lb58bL7c4fDb4L5a5dL6b6cD7b" {
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0)
		setColorToBackgound();
	draw(pencilWidth);
}

macro "Paintbrush Tool - C037La077Ld098L6859L4a2fL2f4fL3f99L5e9bL9b98L6888L5e8dL888c" {
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0)
		setColorToBackgound();
	draw(brushWidth);
}

macro "Flood Fill Tool -C037B21P085373b75d0L4d1aL3135L4050L6166D57D77D68La5adLb6bcD09D94" {
	requires("1.34j");
	setupUndo();
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0) setColorToBackgound();
	floodFill(x, y, floodType);
}

function draw(width) {
	requires("1.32g");
	setupUndo();
	getCursorLoc(x, y, z, flags);
	setLineWidth(width);
	moveTo(x,y);
	x2=-1; y2=-1;
	while (true) {
		getCursorLoc(x, y, z, flags);
		if (flags&leftClick==0) exit();
		if (x!=x2 || y!=y2)
			lineTo(x,y);
		x2=x; y2 =y;
		wait(10);
	}
}

function setColorToBackgound() {
	savep = getPixel(0, 0);
	makeRectangle(0, 0, 1, 1);
	run("Clear");
	background = getPixel(0, 0);
	run("Select None");
	setPixel(0, 0, savep);
	setColor(background);
}

// Runs when the user double-clicks on the pencil tool icon
macro 'Pencil Tool Options...' {
	pencilWidth = getNumber("Pencil Width (pixels):", pencilWidth);
}

// Runs when the user double-clicks on the paint brush tool icon
macro 'Paintbrush Tool Options...' {
	brushWidth = getNumber("Brush Width (pixels):", brushWidth);
	call("ij.Prefs.set", "startup.brush", brushWidth);
}

// Runs when the user double-clicks on the flood fill tool icon
macro 'Flood Fill Tool Options...' {
	Dialog.create("Flood Fill Tool");
	Dialog.addChoice("Flood Type:", newArray("4-connected", "8-connected"), floodType);
	Dialog.show();
	floodType = Dialog.getChoice();
	call("ij.Prefs.set", "startup.flood", floodType);
}

macro "Set Drawing Color..."{
	run("Color Picker...");
}

macro "-" {} //menu divider

macro "About Startup Macros..." {
	title = "About Startup Macros";
	text = "Macros, such as this one, contained in a file named\n"
		+ "'StartupMacros.txt', located in the 'macros' folder inside the\n"
		+ "Fiji folder, are automatically installed in the Plugins>Macros\n"
		+ "menu when Fiji starts.\n"
		+ "\n"
		+ "More information is available at:\n"
		+ "<http://imagej.nih.gov/ij/developer/macro/macros.html>";
	dummy = call("fiji.FijiTools.openEditor", title, text);
}

macro "Save As JPEG... [j]" {
	quality = call("ij.plugin.JpegWriter.getQuality");
	quality = getNumber("JPEG quality (0-100):", quality);
	run("Input/Output...", "jpeg="+quality);
	saveAs("Jpeg");
}

macro "Save Inverted FITS" {
	run("Flip Vertically");
	run("FITS...", "");
	run("Flip Vertically");
}

// *************** GENERAL *************** 
macro "Macro 1 [g]"{
	print(Plot.getValues(xpoints, ypoints););
	
}


macro "Macro 1 [1]"{
	selectWindow("w2");
}

macro "Macro 2 [2]"{
	selectWindow("w3");
}

macro "Macro 3 [3]"{
	selectWindow("w4");
}

macro "Macro 4 [4]"{
	selectWindow("w5");
}

macro "Macro 5 [5]"{
	selectWindow("MAX_w2");
}

macro "Macro 6 [6]"{
	selectWindow("MAX_w3");
}

macro "Macro 7 [7]"{
	selectWindow("MAX_w4");
}

macro "Macro 8 [8]"{
	selectWindow("MAX_w5");
}

macro "Macro 9 [r]" {
	run("RGB Color");
	}

macro "Macro 10 [z]" {
	run("Z Project...");
	}
	
macro "Macro 11 [s]" {
	run("16-bit");
	}

macro "Macro 12 [Q]" {
	run("Merge Channels...", "c6=MAX_w2 c7=MAX_w3 create keep");
}

macro "Macro 13 [W]" {
	run("Merge Channels...", "c6=MAX_w2 c2=MAX_w4 create keep");
}

macro "Macro 12 [E]" {
	run("Merge Channels...", "c7=MAX_w3 c2=MAX_w4 create keep");
}

macro "Macro 12 [R]" {
	run("Merge Channels...", "c6=MAX_w2 c7=MAX_w3 c2=MAX_w4 create keep");
}


macro "Macro 13 [O]"{
	selectWindow("w2");
	close();
	selectWindow("w3");
	close();
	selectWindow("w4");
	close();
	selectWindow("w5");
	close();
	selectWindow("w2.tif");
	close();
	selectWindow("w3.tif");
	close();
	selectWindow("w4.tif");
	close();
	selectWindow("DAPI.tif");
	close();
}

macro "Macro 14 [T]"{
	run("Brightness/Contrast...");
	run("Enhance Contrast", "saturated=0.35");
	run("Brightness/Contrast...");
}

macro "Macro 15 [Z]"{
	n1 = getNumber("Enter start slice:", 1);
	n2 = getNumber("Enter end slice:", 10);	
	selectWindow("w2");
	run("Z Project...", "start=n1 stop=n2 projection=[Max Intensity]");
	selectWindow("MAX_w2");
	run("Brightness/Contrast...");
	run("Enhance Contrast", "saturated=0.35");
	selectWindow("w3");
	run("Z Project...", "start=n1 stop=n2 projection=[Max Intensity]");
	selectWindow("MAX_w3");
	run("Brightness/Contrast...");
	run("Enhance Contrast", "saturated=0.35");
	selectWindow("w4");
	run("Z Project...", "start=n1 stop=n2 projection=[Max Intensity]");
	selectWindow("MAX_w4");
	run("Brightness/Contrast...");
	run("Enhance Contrast", "saturated=0.35");
	selectWindow("w5");
	run("Z Project...", "start=n1 stop=n2 projection=[Max Intensity]");
	selectWindow("MAX_w5");
	run("Brightness/Contrast...");
	run("Enhance Contrast", "saturated=0.35");
}
	
// Step 1 
macro "Macro 15 [a]" {
selectWindow("w1");
makeLine(0, 116, 870, 116);
run("Set Scale...", "distance=870 known=550 unit=uM global");
run("Scale Bar...", "width=50 height=50 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");

selectWindow("w2");
run("Magenta");
run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Scale Bar...", "width=50 height=50 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");

selectWindow("w3");
run("Yellow");
run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Scale Bar...", "width=50 height=50 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");

selectWindow("w4");
run("Green");
run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Scale Bar...", "width=50 height=50 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");

selectWindow("w5");
run("Cyan");
run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Scale Bar...", "width=50 height=50 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
}

// Saving steps for whole-site single z projected channel images
// Step 2 To be run after manually 1. selecting z stack range 2. z projecting 3. gating 4. selecting ROI
macro "Macro 16 [b]" {

x = getNumber("Enter x:", 100);
y = getNumber("Enter y:", 100);	
w = getNumber("Enter w:", 100);
h = getNumber("Enter h:", 100);

// w2 selection sequence
selectWindow("MAX_w2");
makeOval(x, y, w, h);
run("Copy");
newImage("w2_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel/w2_cut.tif");

// w3 selection sequence
selectWindow("MAX_w3");
makeOval(x, y, w, h);
run("Copy");
newImage("w3_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel/w3_cut.tif");

// w4 selection sequence
selectWindow("MAX_w4");
makeOval(x, y, w, h);
run("Copy");
newImage("w4_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel/w4_cut.tif");

// w5 selection sequence
selectWindow("MAX_w5");
makeOval(x, y, w, h);
run("Copy");
newImage("w5_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel/DAPI_cut.tif");

// w2 saving sequence
selectWindow("MAX_w2");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel/w2.tif");
run("16-bit");
run("Magenta");

// w3 saving sequence
selectWindow("MAX_w3");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel/w3.tif");
run("16-bit");
run("Yellow");

// w4 saving sequence
selectWindow("MAX_w4");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel/w4.tif");
run("16-bit");
run("Green");

// w5 saving sequence
selectWindow("MAX_w5");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel/DAPI.tif");
run("16-bit");
run("Cyan");

// w2_DAPI saving sequence
run("Merge Channels...", "c6=w2.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel_with_dapi/w2_DAPI.tif");
selectWindow("w2_DAPI.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w2_DAPI_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel_with_dapi/w2_DAPI_cut.tif");

// w3_DAPI saving sequence
run("Merge Channels...", "c7=w3.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel_with_dapi/w3_DAPI.tif");
selectWindow("w3_DAPI.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w3_DAPI_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel_with_dapi/w3_DAPI_cut.tif");

// w4_DAPI saving sequence
run("Merge Channels...", "c2=w4.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel_with_dapi/w4_DAPI.tif");
selectWindow("w4_DAPI.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w4_DAPI_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/single_channel_with_dapi/w4_DAPI_cut.tif");

run("Merge Channels...", "c6=w2.tif c7=w3.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel/w2_w3.tif");
selectWindow("w2_w3.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w2_w3_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel/w2_w3_cut.tif");

run("Merge Channels...", "c6=w2.tif c2=w4.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel/w2_w4.tif");
selectWindow("w2_w4.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w2_w4_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel/w2_w4_cut.tif");

run("Merge Channels...", "c7=w3.tif c2=w4.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel/w3_w4.tif");
selectWindow("w3_w4.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w3_w4_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel/w3_w4_cut.tif");

run("Merge Channels...", "c6=w2.tif c7=w3.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel_with_dapi/w2_w3_DAPI.tif");
selectWindow("w2_w3_DAPI.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w2_w3_DAPI_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel_with_dapi/w2_w3_DAPI_cut.tif");

run("Merge Channels...", "c6=w2.tif c2=w4.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel_with_dapi/w2_w4_DAPI.tif");
selectWindow("w2_w4_DAPI.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w2_w4_DAPI_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel_with_dapi/w2_w4_DAPI_cut.tif");

run("Merge Channels...", "c7=w3.tif c2=w4.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel_with_dapi/w3_w4_DAPI.tif");
selectWindow("w3_w4_DAPI.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w3_w4_DAPI_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/double_channel_with_dapi/w3_w4_DAPI_cut.tif");

// triple channel
run("Merge Channels...", "c6=w2.tif c7=w3.tif c2=w4.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/triple_channel/w2_w3_w4.tif");
selectWindow("w2_w3_w4.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w2_w3_w4_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/triple_channel/w2_w3_w4_cut.tif");

run("Merge Channels...", "c6=w2.tif c7=w3.tif c2=w4.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/triple_channel_with_dapi/w2_w3_w4_DAPI.tif");
selectWindow("w2_w3_w4_DAPI.tif");
makeOval(x, y, w, h);
run("Copy");
newImage("w2_w3_w4_DAPI_cut", "RGB black", 300, 300, 1);
run("Paste");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "OneDrive - UC San Diego/temp/temp_imagej_outputs_for_transfer/triple_channel_with_dapi/w2_w3_w4_DAPI_cut.tif");
}

macro "Macro 16 [c]"{

animalNumber = getNumber("How many animals in this image?", 3);
newImage("w2_polygon_cut", "RGB black", 300*animalNumber, 300, 1);
newImage("w3_polygon_cut", "RGB black", 300*animalNumber, 300, 1);
newImage("w4_polygon_cut", "RGB black", 300*animalNumber, 300, 1);
newImage("w5_polygon_cut", "RGB black", 300*animalNumber, 300, 1);
for (i = 0; i < animalNumber; i++) {
setTool("polygon");
selectWindow("MAX_w5");
waitForUser("Waiting for user to draw a polygon...");

getSelectionCoordinates(xpoints, ypoints);
selectWindow("MAX_w2");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w2_polygon_cut");
run("Paste");
makeOval(25, 25, 260, 260);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");

selectWindow("MAX_w3");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w3_polygon_cut");
run("Paste");
makeOval(25, 25, 260, 260);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");

selectWindow("MAX_w4");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w4_polygon_cut");
run("Paste");
makeOval(25, 25, 260, 260);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");

selectWindow("MAX_w5");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w5_polygon_cut");
run("Paste");
makeOval(25, 25, 260, 260);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=125 thickness=2 font=14 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");



//Code for analysis goes here
}
}
