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

PRG_PATH = get_absolute_file_path("main2.sce");          
FullFileInitTRT = fullfile(PRG_PATH, "InitTRT.sce" );
exec(FullFileInitTRT); 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// **** SECOND : Do things ****

Period = 10;        // 10 seconds 
Amplitude = 2;      // 2 volts 
Ratio = 2;          // ratio between Sa and Sb 
SampFreq = 10; 
CutFreq  = 0.5;

tEnd = 5 * 1.5 .* Period; 
tBeg = 0 ; 

Time = tBeg:1./SampFreq: tEnd;
Time = Time';           // we want a column vector 
T = Time; 

Frequency = 1 ./ Period ; 
Omega = 2 .* %pi .* Frequency; 

PhiZero = 0.1; 

Sa=          Amplitude .* cos(Omega           .* Time + PhiZero);
Sb= Ratio .* Amplitude .* cos(Omega ./ Ratio  .* Time + PhiZero);
Sc=      Amplitude ./ 5 .* cos(Omega * 15 .* Time );
S = Sa + Sb + Sc;

scf(1)       // select window number 
clf          // clear (this) window
plot(Time, S, '*b-' )
title("Sine curve")                       // S contains two signals  


// lowpass the signal 

Sf = LowPassButtDouble (S, SampFreq, CutFreq);  // filter

// PART 2 : illustrations  
fig = 1;    
figure(fig);clf; 
plot(T, S,  '-k')
plot(T, Sf, '-b')
xlabel("Time (s)")
ylabel("Amplitude (unit?)")
xtitle("Signal as a function of time")
legend("S", "Sf")


// PART 3 : save figure 1 as a result 
fnamePDF = fullfile(RES_PATH, "Signals.pdf"); 
xs2pdf(fig, fnamePDF)

// END : code example : plot a signal + noise 
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// BEG : code example : call an external script  

Mode_DisplayNothingInConsole = -1; 
exec(fullfile(PRG_PATH, "FourrierAnalysis.sce"), Mode_DisplayNothingInConsole)

// END: code example : call an external script  
////////////////////////////////////////////////////////////////////////////////


