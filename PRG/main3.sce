// Short description 
//  main : file to "run" in scilab (e.g., using F5)
//
// Calling Sequence
//  none : main is the entry point 
//
// Parameters
//  none
//
// Description
//  main is the file to run using the scilab interface 
//
// Authors
//  Denis Mottet - Univ Montpellier - France
//
// Versions
//  Version 1.0.0 -- D. Mottet -- Oct 10, 2019
//  Version 1.0.1 -- D. Mottet -- Apr 11, 2020
//      with input (from DAT) and ouptut (to RES)

// The main script always contains two parts : 
//  1°) set up of working environement 
//  2°) computations (in the right setup)

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// **** FIRST : Initialize ****

PRG_PATH = get_absolute_file_path("main3.sce");          
FullFileInitTRT = fullfile(PRG_PATH, "InitTRT.sce" );
exec(FullFileInitTRT); 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// **** SECOND : Do things ****

////////////////////////////////////////////////////////////////////////////////
// BEG : code example : 
// 
// PART 0 : read an input file
fnameIn = fullfile(DAT_PATH, "phase.csv"); 
separator = ","; 
decimal   = "."; 
data = csvRead(fnameIn, separator, decimal, "double" );

// PART 1 : computations 

time  = data(:,1); 
phase = data(:,2); 
phaseUnwrapped = unwrap2pi(phase, %pi );

// PART 2 : illustrations  
fig = 1;    
figure(fig);clf; 
plot(time, phase,  '-k')
plot(time, phaseUnwrapped, '-b')
xlabel("Time (s)")
ylabel("phase (radian)")
xtitle("Unwrapping phase")
legend("phase", "unwrapped phase")

// PART 3 : save figure 1 as a result 
fnamePDF = fullfile(RES_PATH, "Signals.pdf"); 
xs2pdf(fig, fnamePDF)

// END : code example 
////////////////////////////////////////////////////////////////////////////////

