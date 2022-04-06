%% Code for part 3 solution

clear;
clc;
close all;

%% Parameters used in all simulations
l = 0.5;            % m
r = 1/6;            % m
N = 126;            % # coils
Rf = 6.5;           % ohm
Ra = 0.07;          % ohm
Lf = 0.3;           % H
La = 0.005;         % H
k_b = 1.4e-4;       % H
Delta = 9.73;       % unitless
m = 2110;           % kg
g = 9.81;           % m/sec^2
b = 62;             % N-sec/m
D = 0.48;           % m
t_f = 70;           % sec
bar_vel = 26.8224;  %m/s
bar_alpha = 0;      %deg

%%
%Creates symbols a f v to be used in steady state calculations
syms a f v

%Solves the steady state equations found on paper for bar_i_a, bar_i_f,
%and bar_v
Y = vpasolve(v == Rf*f, v == Ra*a+4*N*k_b*f*Delta*r*l*bar_vel/D, b*bar_vel == (4*Delta*N*k_b*l*r/D)*a*f, [a f v]);
bar_v = double(Y.v(2));
bar_i_a = double(Y.a(2));
bar_i_f = double(Y.f(2));

%Creates the transfer functions G_2_1 and G_2_2 found in part 3
%Does so by defining variable 's', inputing the numerators and denominator
%in terms of s, then extracting the coefficients from those expressions.
%These coefficients are converted into doubles, flipped to get in the
%correct order, made into a transfer function, then a zpk model to get the
%poles, zeros and gain for them
syms s
Denom = fliplr(double(coeffs((Rf+Lf*s) * ( (Ra+La*s)*(m*s+b) + 16*Delta^2*N^2*r^2*l^2*k_b^2*bar_i_f^2/(D^2)))));
G_2_1_num = fliplr(double(coeffs((4*Delta*N*l*r*k_b/D) * ( (Rf+Lf*s)*bar_i_f + (Ra+La*s)*bar_i_a - 4*Delta*N*l*r*k_b*bar_vel*bar_i_f/D))));
G_2_1 = zpk(tf(G_2_1_num, Denom));
[pole_2_1, zero_2_1] = pzmap(G_2_1);
G_2_2_num = fliplr(double(coeffs(-m*g*(Rf+Lf*s)*(Ra+La*s))));
G_2_2 = zpk(tf(G_2_2_num, Denom));
[pole_2_2, zero_2_2] = pzmap(G_2_2);

%%
%Define parameters used in the simulation, including the initial and final
%velocities for the step having bar_vel subtracted from them
%An increase from 60 mph to 70 mph is given as well as a road grade change
%of 3 degrees
%Velocities are converted into m/s and angles are converted into rad
v_step_time = 1;
v_initial = 26.8224 - bar_vel;
v_final = 31.2928 - bar_vel;
alpha_step_time = 15;
alpha_initial = 0;
alpha_final = 3*pi/180;
%Getting the transfer functions in a form usable in the simulation
%Namely, in tf form so the .num command works
G1 = tf(zpk([-0.065],[-0.013],[41]));
G_2_1 = tf(G_2_1);
G_2_2 = tf(G_2_2);

%%
%Simulate the linear model and plot the velocity in mph
sim part_3_linear
plot(t_lin, dot_x_lin*2.237);
hold on;
plot(t_lin, vel*2.237, 'k--');
plot(t_lin, alph*180/pi, 'r--');
title('Linearized Response');
legend('Linear Response', 'Set Point', 'Road Grade', 'Location', 'Best');
xlabel('Time [sec]');
ylabel('Velocity [mph], Angle [deg]');
ylim([0 11]);

%Set the initial and final velocities back to their true values for
%non-linear model
v_initial = 26.8224;
v_final = 31.2928;
%Simulate the non-linear model and plot the results in mph
sim part_3_sim_w_car
figure();
plot(t,dot_x*2.237);
hold on;
plot(t_lin, dot_x_lin*2.237+60);
plot(t, r*2.237, 'k--');
plot(t, alpha*180/pi+60, 'r--');
legend('Non-Linear Response', 'Linear Response', 'Set Point', 'Road Grade', 'Location', 'Best');
xlabel('Time [sec]');
ylabel('Velocity [mph], Angle [deg]+60');
title('Nonlinear Response');
ylim([60 71]);