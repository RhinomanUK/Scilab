// Crank/Cam sensor file generator for DG1022
// RhinoPower Ltd
// v0.1
// 7th January 2018
//
// generates a 36-1 crank sensor (square wave)
// 3600 points gives 0.1 degs resolution.
// Saves to a .csv file
//


clear all

//define header information - this can be the same for all files.

header1 = 'Rigol Technologies,Inc. Save analog waveform to excel files.';
header2 = 'Vpp[V]:1.20E01,Period[S]:1.00E-05,Quantify:12,Data Dots:3600,Max Dots:3600,End:3599,Wave:1';
header3 = '';
header4 = 'X,Y[V]';
footer = [ ' 1 '; ' 0 '; ' 0 '; ' 3599 '; ' 0 '; ' 3600 '; ' 0 '; ' 0 '; ' 0 '; ' 0 '; ' 0 '; ' 0 '; ' 0 '; ' 0 '; ' 0 '; ' 0 ' ]

// create matrix for data point initilise index data and set values to zero (-2.5)

points = zeros(3600,2)    // create a matrix with the index data
for i=1:3600                   // = 1 to 3600
    points(i,1) = i;
end

points(:,2) = -2.5;       // set data column all to -2.5 (our zero)


//-------------------------------------------------------------------
//-------------------Insert pattern generator code below-------------

// insert 35 (36-1) pulses into the data matrix.
pointsIndex = 0;

for i = 1:35 
    for j =1:50
        pointsIndex = pointsIndex+1;
        points(pointsIndex,2) = 6;
    end
    pointsIndex = pointsIndex+50;
end


//// Plot the function 
plot( points );                          // Plot the function
title( '36-1 Crank Waveform for Rigol DG1022 Function Generator' )
xlabel( 'Degrees /10' )
ylabel( 'Quantization Level' )
grid on
h = gca(); // get current axes 
h.data_bounds = [0, -3; 3600,6.5]; 

// Save the samples to disk

fd = mopen('crank_36_1.csv','wt');
mfprintf(fd,'%s\n', header1);
mfprintf(fd,'%s\n', header2);
mfprintf(fd,'%s\n', header3);
mfprintf(fd,'%s\n', header4);

[nr,nc]=size(points)

for i = 1:nr
    mfprintf(fd,'%i', points(i,1));
    mfprintf(fd, ',');
    str = msprintf('%2.2E', points(i,2)); 
    mfprintf(fd,'%s\n', strsubst(str,"+","")); 
end

mfprintf(fd,'%s\n', footer);

mclose(fd);

