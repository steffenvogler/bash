dir1 = getDirectory("Choose Source Directory containing only tiff z-stacks");
dir2 = getDirectory("Choose Source Directory containing only tiff z-stacks");

getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
list = getFileList(dir1);
setBatchMode(true);
if (isOpen("Log")) {
	selectWindow("Log");
    run("Close");
}

for (i=0; i<list.length; i++)
//for (i=0; i<1; i++)
if(endsWith(list[i],".bmp"))
{
	showProgress(i, list.length);
	IJ.redirectErrorMessages();
	open(dir1+list[i]);
	//run("Bio-Formats Windowless Importer", "open=["+dir1+list[i]+"]");
	title=getTitle();
	dotIndex = lengthOf(list[i]) - 4;
    m = substring(list[i],0,dotIndex);  
	getDimensions( width, height, channels, slices, frames );
	n=frames;
	run("8-bit");
	save(dir2+m+".tif");
//close();
//}
close();
}

     getDateAndTime(year2, month2, dayOfWeek2, dayOfMonth2, hour2, minute2, second2, msec2);

     d_delta=dayOfMonth2-dayOfMonth;	
     h_delta=hour2-hour;
     min_delta=minute2-minute;
     sec_delta=second2-second;
     
     print("Elpased Time: "+d_delta+"d "+h_delta+"h "+min_delta+"min "+sec_delta+"sec");

selectWindow("Log");
name=dir2+"Computation-Time.txt";
saveAs("Text", name);
//run("Close");