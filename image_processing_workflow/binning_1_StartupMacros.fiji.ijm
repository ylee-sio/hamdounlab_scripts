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

// distance = 870 for level 2 binning, 1740 for level 1 binning
selectWindow("w1");
makeLine(0, 116, 1740, 116);
run("Set Scale...", "distance=1740 known=550 unit=uM font=30 width=100 global");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");

selectWindow("w2");
run("Magenta");
run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");

selectWindow("w3");
run("Yellow");
run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");

selectWindow("w4");
run("Green");
run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");

selectWindow("w5");
run("Cyan");
run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
}

// Saving steps for whole-site single z projected channel images
// Step 2 To be run after manually 1. selecting z stack range 2. z projecting 3. gating 
macro "Macro 16 [b]" {

// w2 saving sequence
selectWindow("MAX_w2");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/w2.tif");
run("16-bit");
run("Magenta");
selectWindow("MAX_w2");
setFont("SansSerif", 50, "antialiased");
Overlay.drawString(w2_text, 50, 100);
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/w2_labeled.tif");

// w3 saving sequence
selectWindow("MAX_w3");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/w3.tif");
run("16-bit");
run("Yellow");
selectWindow("MAX_w3");
setFont("SansSerif", 50, "antialiased");
Overlay.drawString(w3_text, 50, 100);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/w3_labeled.tif");

// w4 saving sequence
selectWindow("MAX_w4");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/w4.tif");
run("16-bit");
run("Green");
selectWindow("MAX_w4");
setFont("SansSerif", 50, "antialiased");
Overlay.drawString(w4_text, 50, 100);
run("Colors...", "foreground=green, background=green, selection=green");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/w4_labeled.tif");

// w5 saving sequence
selectWindow("MAX_w5");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/DAPI.tif");
run("16-bit");
run("Cyan");
selectWindow("MAX_w5");
setFont("SansSerif", 50, "antialiased");
Overlay.drawString(DAPI_text, 50, 100);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/DAPI_labeled.tif");

// w2_DAPI saving sequence
run("Merge Channels...", "c6=w2.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=3 font=25 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 50, 100);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 50, 160);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel_with_dapi/w2_DAPI.tif");

// w3_DAPI saving sequence
run("Merge Channels...", "c7=w3.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 50, 100);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 50, 160);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel_with_dapi/w3_DAPI.tif");

// w4_DAPI saving sequence
run("Merge Channels...", "c2=w4.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=3 font=25 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 50, 100);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 50, 160);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel_with_dapi/w4_DAPI.tif");

run("Merge Channels...", "c6=w2.tif c7=w3.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 50, 100);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 50, 160);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel/w2_w3.tif");

run("Merge Channels...", "c6=w2.tif c2=w4.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 50, 100);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 50, 160);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel/w2_w4.tif");

run("Merge Channels...", "c7=w3.tif c2=w4.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 50, 100);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 50, 160);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel/w3_w4.tif");

run("Merge Channels...", "c6=w2.tif c7=w3.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 50, 100);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 50, 160);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 50, 220);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel_with_dapi/w2_w3_DAPI.tif");

run("Merge Channels...", "c6=w2.tif c2=w4.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 50, 100);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 50, 160);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 50, 220);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel_with_dapi/w2_w4_DAPI.tif");

run("Merge Channels...", "c7=w3.tif c2=w4.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 50, 100);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 50, 160);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 50, 220);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel_with_dapi/w3_w4_DAPI.tif");

// triple channel
run("Merge Channels...", "c6=w2.tif c7=w3.tif c2=w4.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 50, 100);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 50, 160);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 50, 220);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/triple_channel/w2_w3_w4.tif");

run("Merge Channels...", "c6=w2.tif c7=w3.tif c2=w4.tif c5=DAPI.tif create keep");
run("RGB Color");
run("Scale Bar...", "width=100 height=50 thickness=6 font=50 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 50, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 50, 100);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 50, 160);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 50, 220);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 50, 280);
run("Flatten");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/triple_channel_with_dapi/w2_w3_w4_DAPI.tif");

}

macro "Macro 16 [c]"{

n = 1
answer = "y";
do {

newImage("w2_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w3_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w4_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("DAPI_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w2_DAPI_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w3_DAPI_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w4_DAPI_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w2_w3_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w2_w4_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w3_w4_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w2_w3_w4_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w2_w3_DAPI_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w2_w4_DAPI_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w3_w4_DAPI_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);
newImage("w2_w3_w4_DAPI_polygon_cut", "RGB black", bin_pix_num, bin_pix_num, 1);

setTool("polygon");
selectWindow("MAX_w5");
waitForUser("Waiting for user to draw a polygon. Using DAPI channel as reference image...");

// w2 cut
getSelectionCoordinates(xpoints, ypoints);
selectWindow("MAX_w2");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w2_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
Overlay.drawString(w2_text, 30, 60);
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/cuts/w2_cut_" + n + ".tif");
run("16-bit");
run("Magenta");

// w3 cut
selectWindow("MAX_w3");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w3_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
Overlay.drawString(w3_text, 30, 60);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/cuts/w3_cut_" + n + ".tif");
run("16-bit");
run("Yellow");

// w4 cut
selectWindow("MAX_w4");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w4_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
Overlay.drawString(w4_text, 30, 60);
run("Colors...", "foreground=green, background=green, selection=green");
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/cuts/w4_cut_" + n + ".tif");
run("16-bit");
run("Green");

// w5 cut
selectWindow("MAX_w5");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("DAPI_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
Overlay.drawString(DAPI_text, 30, 60);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel/cuts/DAPI_cut_" + n + ".tif");
run("16-bit");
run("Cyan");

// w2_DAPI cut
selectWindow("w2_DAPI.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w2_DAPI_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 30, 60);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 30, 100);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel_with_dapi/cuts/w2_DAPI_cut_" + n + ".tif");

// w3_DAPI cut
selectWindow("w3_DAPI.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w3_DAPI_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 30, 60);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 30, 100);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel_with_dapi/cuts/w3_DAPI_cut_" + n + ".tif");

// w4_DAPI.tif
selectWindow("w4_DAPI.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w4_DAPI_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 30, 60);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 30, 100);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/single_channel_with_dapi/cuts/w4_DAPI_cut_" + n + ".tif");

// w2_w3.tif
selectWindow("w2_w3.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w2_w3_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 30, 60);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 30, 100);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel/cuts/w2_w3_cut_" + n + ".tif");

// w2_w4.tif
selectWindow("w2_w4.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w2_w4_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 30, 60);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 30, 100);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel/cuts/w2_w4_cut_" + n + ".tif");

// w3_w4.tif
selectWindow("w3_w4.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w3_w4_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 30, 60);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 30, 100);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel/cuts/w3_w4_cut_" + n + ".tif");

// w2_w3_w4.tif
selectWindow("w2_w3_w4.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w2_w3_w4_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 30, 60);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 30, 100);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 30, 140);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/triple_channel/cuts/w2_w3_w4_cut_" + n + ".tif");

// w2_w3_DAPI.tif
selectWindow("w2_w3_DAPI.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w2_w3_DAPI_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 30, 60);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 30, 100);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 30, 140);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel_with_dapi/cuts/w2_w3_DAPI_cut_" + n + ".tif");

// w2_w4_DAPI.tif
selectWindow("w2_w4_DAPI.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w2_w4_DAPI_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 30, 60);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 30, 100);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 30, 140);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel_with_dapi/cuts/w2_w4_DAPI_cut_" + n + ".tif");

// w3_w4_DAPI.tif
selectWindow("w3_w4_DAPI.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w3_w4_DAPI_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 30, 60);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 30, 100);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 30, 140);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/double_channel_with_dapi/cuts/w3_w4_DAPI_cut_" + n + ".tif");

// w2_w3_w4_DAPI.tif
selectWindow("w2_w3_w4_DAPI.tif");
makeSelection("polygon", xpoints, ypoints);
run("Copy");
selectWindow("w2_w3_w4_DAPI_polygon_cut");
run("Paste");
makeOval(75, 100, 650, 650);
waitForUser("Waiting for user to rotate selection. Use Image > Transform > Rotate...");
run("Scale Bar...", "width=50 height=50 thickness=3 font=35 color=White background=None location=[Lower Right] horizontal bold overlay");
setFont("SansSerif", 35, "antialiased");
run("Colors...", "foreground=magenta, background=magenta, selection=magenta");
drawString(w2_text, 30, 60);
run("Colors...", "foreground=yellow, background=yellow, selection=yellow");
drawString(w3_text, 30, 100);
run("Colors...", "foreground=green, background=green, selection=green");
drawString(w4_text, 30, 140);
run("Colors...", "foreground=cyan, background=cyan, selection=cyan");
drawString(DAPI_text, 30, 180);
run("Flatten");
run("RGB Color");
saveAs("Tiff", getDirectory("home") + "temp/" + w5_text + "/" + w6_text + "/" + w7_text  + "/triple_channel_with_dapi/cuts/w2_w3_w4_DAPI_cut_" + n + ".tif");

answer = getString("Select more individual animals/samples? (Enter y or n; Default is n) ", "n");

	if (answer == "y") {
		n = n+1;
		close("*cut*");
	} else {run("Quit");}
} while (answer == "y");
}

macro "Close all [D]" {
	//close("*");
	run("Quit");
}


var w2_text = getString("What should be the label for w2 (gene, antibody, dye, etc.)? ", "");
var w3_text = getString("What should be the label for w3 (gene, antibody, dye, etc.)? ", "");
var w4_text = getString("What should be the label for w4 (gene, antibody, dye, etc.)? ", "");
var w5_text = getString("Enter the exact experiment ID ", "");
var w6_text = getString("Enter the exact well ID ", "");
var w7_text = getString("Enter the exact site ID ", "");
var bin_pix_num = 800;
var DAPI_text = "Hoechst 33342";
