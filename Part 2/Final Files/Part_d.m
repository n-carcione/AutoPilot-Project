close all;
clear all;
clc;

%% ME 3360 - Proj 2 - Part (d)
%Define variables
l = 0.5;            % m
r = 1/6;            % m
N = 126;            %# of coils
B = 21e-3;          %T
i_a = 1.7e3;        %A
freq = 112;         %Frequency of theta (s^-1)
t_step = 0.0001;    %Step size
t_dur = 4*pi/112;   %Time duration of 2 cycles

%Run simulation
sim Part_D_Simulink;

%Plot the motor torque Tm and back EMF Eb
figure(1);
subplot(2,1,1);
plot(T.Time, T.Data, 'b-', 'LineWidth', 1.5);
xlabel ('t [sec]');
ylabel ('T (t) [N-m]');
title('12 Pole Motor Torque Over Time');
subplot(2,1,2);
plot(Eb.Time, Eb.Data, 'b-', 'LineWidth', 1.5);
xlabel ('t [sec]');
ylabel ('E_b (t) [V]');
title('12 Pole Motor Back EMF Over Time');