clc, clear, close all;

% define the notes in the song
nsong = [ 40 44 42 45 44 47 45 49 47 51 49 52 51 54 52 ; 52 49 51 47 ...
    49 45 47 44 45 42 44 40 42 39 40];

% define the length of the note to play (in seconds)
tsong = [ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 .5 ; 1 1 1 1 1 1 1 1 1 1 1 1 1 1 .5]./2;

% define chords
nchord = [ 40 44 47 ; 40 43 47 ; 42 46 49 ; 42 45 49 ; 44 48 51 ; ...
    44 47 51 ; 45 49 52 ; 45 48 52 ; 47 51 54 ; 47 50 54 ; 49 53 56 ; ...
    49 52 56];
TS = 2;


% define the sampling rate
Fs = 44100; % 44100Hz is for CD quality sound

% define the arbitrary wave table w(ts) at sample points ts that are separated by pi/4 radians.
% attempt to recreate piano tone
ts  = 0:pi/4:2*pi;
w = [0 0.99 0.6 0.6 0.5 0.45 -0.6 -0.5 -0.99];



program = input('Select Program 1 or 2: ');

% initialise chords
chord = 1;
[rsong, csong] = size(nsong);


if program == 1
%% Program selection 1
    for i = 1:rsong
        for j = 1:csong

            % define the arbitrary envelope e(t) at sample points separated by Tmax/L
            % L is the number of points for the envelope
            L = 10;
            te  = 0:tsong(i,j)/L:tsong(i,j);
            e = [0.5 1.0 0.8 0.75 0.7 0.65 0.6 0.3 0 0 0]; %needs L+1 entries
            plot(te,e);

            % define the fundamental frequency of the note for key n
            fn = 440*power(2,(nsong(i,j)-49)/12);

            % define the vibrato parameters
            Wvibrato = 0.01*fn; % 1% of fundamental frequency
            fvibrato = 7; % typical value of 7Hz

            % define a series of sampling times t at a rate of Fs per sec
            t = 0 : 1/Fs : tsong(i,j);

            % adjust the times t by modulo and scaling of the time values
            % the instantaneous frequency fn is varied to simulate vibrato
            tadjusted = 2*pi*(fn+Wvibrato.*sin(2*pi*fvibrato*t)).*mod(t,1/fn);

            % calculate the x(t) waveform by interpolation on wave table w(ts)
            x = interp1(ts,w,tadjusted,'spline');

            % multiply the x(t) waveform by the envelope e(t)
            x = x.*interp1(te,e,t,'spline');

            % multiply the x(t) waveform to simulate tremolo
            ftremolo = 5; % imposes a 5Hz tremolo
            Wtremolo = 0.1; % the amplitude is fluctuated by 10%
            x = x.* (1 + Wtremolo.*sin(2*pi*ftremolo*t));

            % plot the output waveform for visual verification
            plot(t,x);
            xlabel('t (sec)');
            ylabel('x(t)');

            % play the sound!
            soundsc(x, Fs);

            %wait for next note
            if tsong(i,j) == .5
                pause(0.5);
            elseif tsong(i,j) == .25
                pause(0.75);
            end
            
        end
    end
  
elseif program == 2
%% Program Selection 2  
    while(ne(chord,0))
        chord = input('Select chord to play: ');

        if(chord > 0 && chord < 13)
          
           % define the arbitrary envelope e(t) at sample points separated by Tmax/L
           % L is the number of points for the envelope
           L = 10;
           te  = 0:TS/L:TS;
           e = [0.2 1.0 0.2 0.1 0.08 0.07 0.06 0.05 0.02 0 0]; %needs L+1 entries
           plot(te,e);

           % define the fundamental frequency of the note for chord
           fn1 = 440*power(2,(nchord(chord,1)-49)/12);
           fn2 = 440*power(2,(nchord(chord,2)-49)/12);
           fn3 = 440*power(2,(nchord(chord,3)-49)/12);

           % define the vibrato parameters
           Wvibrato1 = 0.01*fn1; % 1% of fundamental frequency
           Wvibrato2 = 0.01*fn2; % 1% of fundamental frequency
           Wvibrato3 = 0.01*fn3; % 1% of fundamental frequency

           fvibrato = 7; % typical value of 7Hz

           % define a series of sampling times t at a rate of Fs per sec
           t = 0 : 1/Fs : TS;

           % adjust the times t by modulo and scaling of the time values
           % the instantaneous frequency fn is varied to simulate vibrato
           tadjusted1 = 2*pi*(fn1+Wvibrato1.*sin(2*pi*fvibrato*t)).*mod(t,1/fn1);
           tadjusted2 = 2*pi*(fn2+Wvibrato2.*sin(2*pi*fvibrato*t)).*mod(t,1/fn2);
           tadjusted3 = 2*pi*(fn3+Wvibrato3.*sin(2*pi*fvibrato*t)).*mod(t,1/fn3);

           % calculate the x(t) waveform by interpolation on wave table w(ts)
           x1 = interp1(ts,w,tadjusted1,'spline');
           x2 = interp1(ts,w,tadjusted2,'spline');
           x3 = interp1(ts,w,tadjusted3,'spline');


           % multiply the x(t) waveform by the envelope e(t)
           x1 = x1.*interp1(te,e,t,'spline');
           x2 = x2.*interp1(te,e,t,'spline');
           x3 = x3.*interp1(te,e,t,'spline');

           % multiply the x(t) waveform to simulate tremolo
           ftremolo = 5; % imposes a 5Hz tremolo
           Wtremolo = 0.1; % the amplitude is fluctuated by 10%
           x1 = x1.* (1 + Wtremolo.*sin(2*pi*ftremolo*t));
           x2 = x2.* (1 + Wtremolo.*sin(2*pi*ftremolo*t));
           x3 = x3.* (1 + Wtremolo.*sin(2*pi*ftremolo*t));

           x = (x1 + x2 + x3)./3;

           % plot the output waveform for visual verification
           plot(t,x);
           xlabel('t (sec)');
           ylabel('x(t)');

           % play the sound!
           soundsc(x, Fs);
        elseif (chord < 0 || chord > 12)
            disp('Number does not correspond to valid chord, Try a number between 1-12. Press 0 to stop');
        end
    end
end

disp('Bye!');