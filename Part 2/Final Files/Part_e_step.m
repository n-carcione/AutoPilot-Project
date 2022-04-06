close all;
clear all;
clc;

%% ME 3360 - Proj 2 - Part (e (Step response))
%Define variables
l = 0.5;            % m
r = 1/6;            % m
N = 126;            % # coils
t_step = 0.0001;    %Step size
t_dur = 6;          %Time duration of 2 cycles
Ra = 0.07;          %ohms
La = 0.005;         %H
Rf = 1.15;          %ohms
Lf = 0.3;           %H
V = 250;            %V
gear = 9.73;        %Given ratio of motor to wheel revolutions
kb = 1.4e-4;        %T/A
m = 2110;           %kg
b = 62;             %N-sec/m
d = 0.48;           %m
rw = d / 2;         %m

%Run simulation
sim Part_E_Simulink;

%Plot motor torque, car velocity, and armature current for voltage step
figure(1);
subplot(3,1,1);
plot(Tm.Time, Tm.Data, 'b-', 'LineWidth', 1.5);
xlabel ('t [sec]');
ylabel ('T (t) [N-m]');
title('Motor Torque Response for Voltage Step');
subplot(3,1,2);
plot(xdot.Time, xdot.Data, 'b-', 'LineWidth', 1.5);
xlabel ('t [sec]');
ylabel ('xdot(t) [m/s]');
title('Car Velocity Response for Voltage Step');
subplot(3,1,3);
plot(i_a.Time, i_a.Data, 'b-', 'LineWidth', 1.5);
xlabel ('t [sec]');
ylabel ('i_a(t) [A]');
title('Armature Current Response for Voltage Step');