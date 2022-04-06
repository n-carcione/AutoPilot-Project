clear;
clc;
close all;
syms t s;

%Values given in problem statement or calculated in parts (a) & (b)
m = 2110;
b = 62;
d = 0.48;
r = d / 2;
theta = 3;
g = 9.81;
Tmax = 1465;
Tss = 99.8;
%Conversion constant for converting m/s back to original mph goal
ms_to_mph = 2.23694;

%Calculating the force provided by the max and steady state torques
Fwheels_max = 4 * Tmax / r;
Fwheels_ss = 4 * Tss / r;

%Component of the cars weight acting down the slope
Fgrav = m * g *sind(theta);

%Execute the simulink diagram
sim Part1_e_simu

%Plot the response received from simulink, plotting the velocity as mph
%instead of m/s.  Label and title the graph
plot(v.Time, v.Data*2.23694,'k');
xlabel('Time [s]');
ylabel('Velocity [mph]');
ylim([0 65]);
title(['Velocity Response of Tesla S P100D With 3' char(176) ' Incline']);