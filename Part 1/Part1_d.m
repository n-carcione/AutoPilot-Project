clear;
clc;
close all;
syms t s;

%Values given in problem statement or calculated in parts (a) & (b)
m = 2110;
b = 62;
d = 0.48;
r = d / 2;
Tmax = 1465;
Tss = 99.8;
%Conversion constant for converting m/s back to original mph goal
ms_to_mph = 2.23694;

%Calculating the force provided by the max and steady state torques
Fwheels_max = 4 * Tmax / r;
Fwheels_ss = 4 * Tss / r;

%Execute the simulink diagram
sim Part1_d_simu
%Plot the response received from simulink, plotting the velocity as mph
%instead of m/s.  Label and title the graph
plot(v.Time, v.Data*2.23694,'k');
xlabel('Time [s]');
ylabel('Velocity [mph]');
ylim([0 65]);
title('Part 1d Velocity Response of Tesla S P100D');

%V_s is the Laplace function for the velocity found in part (c)
V_s = (4/(m*r*s+b*r)) * (Tmax/s - ((Tmax-Tss)/s)*exp(-2.4*s));
%Inverse Laplace the Laplace funciton and convert it into a function
vel = ilaplace(V_s);
vel_t = matlabFunction(vel);
%Create a vector of time elements for plotting the Laplace response
time = 0:0.01:10;
hold on;
%Plot the Laplace response on top of the simulink response
plot(time, vel_t(time)*ms_to_mph,'r--');
legend('Simulink Response', 'Laplace Response', 'Location', 'southeast');