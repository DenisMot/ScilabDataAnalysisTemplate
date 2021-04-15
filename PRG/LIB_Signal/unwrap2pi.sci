function ph=unwrap2pi(phase, step)
    // Unwraps the phase to get rid of jumps larger than step 
    //
    // Calling Sequence
    //   ph=unwrap2pi(phase, step)
    //
    // Parameters
    //  phase: vector, the input phase
    //  step : real, the maximal allowed value in diff(phase) 
    //
    // Description
    // unwrap2pi(phase, step) unwraps the phase by changing jumps grater than pi
    // to their 2*pi complement (e.g;, unwrap phase angle in rotating waves).
    // Nan are neglected. 
    //
    // Examples
    //    T = linspace(0,10,1000)';
    //    omega = 2*%pi*0.2;
    //    X = cos(omega*T);
    //    Y = sin(omega*T);
    //    p = atan(Y,X); 
    //    P = unwrap2pi(p, %pi); 
    //
    //    subplot(2,1,1)
    //    plot(p, '-k')
    //    plot(P, '-b'); 
    //    ylabel ("Phase (radian)")
    //    legend("Phase", "Unwraped phase");
    //    subplot(2,1,2)
    //    plot(diff(p)./diff(T), '-k');
    //    plot(diff(P)./diff(T), '-b'); 
    //    ylabel ("Phase speed (radian/second)")
    //    legend("Phase speed", "Unwraped phase speed");
    //
    // Authors
    //  Denis Mottet - Univ Montpellier - France
    //
    // Versions
    //  Version 1.0.0 -- D. Mottet -- Jul 19, 2009
    //      works exactly as matlab unwrap
    //  Version 2.0.0 -- D. Mottet -- Apr 14, 2020
    //      argument check and nan management 
    //      header comments following scilab guidelines 
    //  Version 2.0.1 -- D. Mottet -- Apr 10, 2021
    //      renamed as unwrap2pi to allow use of scilab unwrap()
    //      scilab:unwrap(theta, 0) works closest to matlab unwrap

    if min(size(phase)) > 1 then
        error("Unwraps expects vectors...")
    end

    FlagTranspose = %f; 
    if size(phase, 1) < size(phase, 2) then
        phase = phase'; 
        FlagTranspose = %t; 
    end

    ph = phase; 
    // proceed ONLY with non-nan and non-inf data (just forget bad data)
    iGood = find( ~isnan(phase) & ~isinf(phase) ); 
    ph(iGood) = local_unwrap(phase(iGood), step);

    if FlagTranspose then
        phase = phase'; 
    end

endfunction

function ph=local_unwrap(phase, step)
    // Unwraps column vector phase
    dp = diff(phase);                    // change in phase/angle
    
    Pjump = find(dp > step);             // positive phase jump
    if ~isempty(Pjump) then
        dp(Pjump) =  dp(Pjump) - 2 * step;   // correction
    end
   
    Njump = find(dp <= -step);           // negative phase jump
    if ~isempty(Njump) then
        dp(Njump) = 2 * step + dp(Njump);    // correction
    end
    
    dp = [phase(1); dp];                 // column concatenation
    ph = cumsum(dp);                     // integration
endfunction

function example()
    T = linspace(0,10,1000)';
    omega = 2*%pi*0.2;
    X = cos(omega*T);
    Y = sin(omega*T);
    p = atan(Y,X); 
    P = unwrap2pi(p, %pi); 

    subplot(2,1,1)
    plot(p, '-k')
    plot(P, '-b'); 
    ylabel ("Phase (radian)")
    legend("Phase", "Unwraped phase");
    subplot(2,1,2)
    plot(diff(p)./diff(T), '-k');
    plot(diff(P)./diff(T), '-b'); 
    ylabel ("Phase speed (radian/second)")
    legend("Phase speed", "Unwraped phase speed");


endfunction
