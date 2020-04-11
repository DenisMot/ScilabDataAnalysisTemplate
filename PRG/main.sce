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



// The main script always contains two parts : 
//  1°) set up of working environement 
//  2°) computations (in the right setup)

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// **** FIRST : Initialize ****

PRG_PATH = get_absolute_file_path("main.sce");          
FullFileInitTRT = fullfile(PRG_PATH, "InitTRT.sce" );
exec(FullFileInitTRT); 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// **** SECOND : Do things ****

////////////////////////////////////////////////////////////////////////////////
// BEG : code example : plot a signal + noise 
// 
// PART 1 : computations 

// Generate a signal (low frequency) + noise (high frequency)

SampFreq = 200;                     // Sampling frequency (Hz)
Duration = 5;                       // Duration of signal (s)
T = 0 : 1./SampFreq : Duration;     // Time (over Duration sec)
T = T';                             // Time as a column vector 

S01 = 1.0 .* cos(2 .* %pi .* 01 .* T);     //  1 Hz cosine 
S50 = 0.1 .* cos(2 .* %pi .* 50 .* T);     // 50 Hz cosine 
S = S01 + S50;                             // S contains two signals  

// lowpass the signal 
CutFreq = 3;                                    // cutoff frequency (Hz)
Sf = LowPassButtDouble (S, SampFreq, CutFreq);  // filter

// PART 2 : illustrations  
figure(1);clf; 
plot(T, S,  '-k')
plot(T, Sf, '-b')
xlabel("Time (s)")
ylabel("Amplitude (unit?)")
xtitle("Signal as a function of time")
legend("S", "Sf")

// END : code example : plot a signal + noise 
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// BEG : code example : call an external script  

Mode_DisplayNothingInConsole = -1; 
exec(fullfile(PRG_PATH, "FourrierAnalysis.sce"), Mode_DisplayNothingInConsole)

// END: code example : call an external script  
////////////////////////////////////////////////////////////////////////////////


