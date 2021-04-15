# ScilabDataAnalysisTemplate
This is a template for data analysis with scilab.  
It is mainly intended to facilitate use and minimize potential errors by :
* enforcing a consistent directory structure  
For each novel data analysis problem, the idea is to create a novel directory containing *at least*
	* `WRK`: working directory for the data analysis problem
		* `DAT`: data used as input for analyses
		* `RES`: results of analyses
		* `PRG`: scripts and functions for the analyses

* compiling all functions in `PRG` when you run `main.sce`   
This is handy, *though you must re-run main each time you modify a function*.
The compilation is done in `InitTRT.sce`


- providing a minimum set of ingredients for time series processing   
	- `LIB_Signal`
		- `AmplitudeSpectrum.sci` Amplitude spectrum of a signal from fft
		- `LowPassButtDouble.sci` Low pass filters a signal with a dual-pass second-order Butterworh iir filter
		- `fltsflts.sci` Applies a filter forward and reverse in time (zero phase shift filtering)
		- `gradient.sci` One-dimensional gradient of a signal (first central difference)
		- `unwrap2pi.sci` Unwraps phase by changing jumps greater than pi to their 2*pi complement  
	- `FourrierAnalysis.sce`  
	Illustrates the use of the library

## Usage
* (Clone or) download the repository
* On your computer :
	* Open `main.sce` with scilab editor (SciNotes)  
	* Run the script (press F5, or click  the button with a triangle)

## Notes :
* You first need to install [Scilab](http://www.scilab.org)... *For OSX users*: please go directly to the guidelines provided by the University of Technology of Compiègne (link on scilab's page) and follow thme **step by step**. 
* Double click on `main.sce` might not work... depending on your OS.  
Opening files from SciNotes always works (File menu -> open).
* **Do not modify the names and organisation of the directories**  
The DAT+PRG+RES structure is expected when initialising in `InitTRT.sce`
