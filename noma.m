% Create parameters and random users
Users = 20;
W = 20; % Bandwidth Mhz
Pdis = 10; % BS Sector Power Watios
P = Pdis/W; % Spectral power density W/Mhz
Radio = 1000; % Meters
k = 1.3806488*10^-23;
T = 290; % Kelvin
F = 3.6*10^9; % Hz
c = 3*10^8; % Meters/second
lamda = c/F; % Meters
azimuth = 2*pi*rand(Users,1); % Radians
radio = Radio*rand(Users,1); % Meters
[x,y] = pol2cart(azimuth,radio);
figure
plot(x,y,'.')
hold on
viscircles([0 0],1000);
% Divide the cell in sectors
AreaUsers = zeros(Users,1);
rhosArea = cell(5,1);
for user = 1:Users
 if (azimuth(user) < 2*pi/5)
 AreaUsers(user) = 1;
 rhosArea{1} = [rhosArea{1} radio(user)];
 elseif ((azimuth(user) < 4*pi/5) && (azimuth(user) > 2*pi/5))
 AreaUsers(user) = 2;
 rhosArea{2} = [rhosArea{2} radio(user)];
 elseif((azimuth(user) < 6*pi/5) && (azimuth(user) > 4*pi/5))
 AreaUsers(user) = 3;
 rhosArea{3} = [rhosArea{3} radio(user)];
 elseif ((azimuth(user) < 8*pi/5) && (azimuth(user) > 6*pi/5))
 AreaUsers(user) = 4;
 rhosArea{4} = [rhosArea{4} radio(user)];
 elseif ((azimuth(user) < 10*pi/5) && (azimuth(user) > 8
*pi/5))
 AreaUsers(user) = 5;
 rhosArea{5} = [rhosArea{5} radio(user)];
 end
end
% Sort the users in each sector by distance to the BS
rhosArea{1} = sort(rhosArea{1});
rhosArea{2} = sort(rhosArea{2});
rhosArea{3} = sort(rhosArea{3});
rhosArea{4} = sort(rhosArea{4});
rhosArea{5} = sort(rhosArea{5});
% Count users per sector
Users1 = 0;
Users2 = 0;
1
Users3 = 0;
Users4 = 0;
Users5 = 0;
for user = 1:Users
 if (AreaUsers(user) == 1)
 Users1 = Users1 + 1;
 elseif (AreaUsers(user) == 2)
 Users2 = Users2 + 1;
 elseif (AreaUsers(user) == 3)
 Users3 = Users3 + 1;
 elseif (AreaUsers(user) == 4)
 Users4 = Users4 + 1;
 elseif (AreaUsers(user) == 5)
 Users5 = Users5 + 1;
 end
end
UsersArea = [Users1 Users2 Users3 Users4 Users5];
% Calculate power coefficients for each area/sector (Max. 10
users per sector) and bandwidth per user
% (OFDMA)
powers = cell(5,1);
bandwidths = zeros(5,1);
for area = 1:5
 if (UsersArea(area) == 1)
 power = Pdis/W;
 powers{area} = power;
 bandwidths(area) = W;
 elseif (UsersArea(area) == 2)
 syms P1 P2;
 eq1 = P2 == 2*P1;
 eq2 = Pdis == P1*20 + P2*20;
 eqs = [eq1 eq2];
 vars = [P1 P2];
 [sol1, sol2] = solve(eqs, vars);
 power = [sol1 sol2];
 powers{area} = power;
 bandwidths(area) = W/2;
 elseif (UsersArea(area) == 3)
 syms P1 P2 P3;
 eq1 = P2 == 2*P1;
 eq2 = Pdis == P1*20 + P2*20 + P3*20;
 eq3 = P3 == 2*(P2+P1);
 eqs = [eq1 eq2 eq3];
 vars = [P1 P2 P3];
 [sol1, sol2, sol3] = solve(eqs, vars);
 power = [sol1 sol2, sol3];
 powers{area} = power;
 bandwidths(area) = W/3;
 elseif (UsersArea(area) == 4)
 syms P1 P2 P3 P4;
 eq1 = P2 == 2*P1;
2
 eq2 = Pdis == P1*20 + P2*20 + P3*20 + P4*20;
 eq3 = P3 == 2*(P2+P1);
 eq4 = P4 == 2*(P3+P2+P1);
 eqs = [eq1 eq2 eq3 eq4];
 vars = [P1 P2 P3 P4];
 [sol1, sol2, sol3, sol4] = solve(eqs, vars);
 power = [sol1 sol2 sol3 sol4];
 powers{area} = power;
 bandwidths(area) = W/4;
 elseif (UsersArea(area) == 5)
 syms P1 P2 P3 P4 P5;
 eq1 = P2 == 2*P1;
 eq2 = Pdis == P1*20 + P2*20 + P3*20 + P4*20 + P5*20;
 eq3 = P3 == 2*(P2+P1);
 eq4 = P4 == 2*(P3+P2+P1);
 eq5 = P5 == 2*(P1+P2+P3+P4);
 eqs = [eq1 eq2 eq3 eq4 eq5];
 vars = [P1 P2 P3 P4 P5];
 [sol1, sol2, sol3, sol4, sol5] = solve(eqs, vars);
 power = [sol1 sol2 sol3 sol4 sol5];
 powers{area} = power;
 bandwidths(area) = W/5;
 elseif (UsersArea(area) == 6)
 syms P1 P2 P3 P4 P5 P6;
 eq1 = P2 == 2*P1;
 eq2 = Pdis == P1*20 + P2*20 + P3*20 + P4*20 + P5*20 + P6*
20;
 eq3 = P3 == 2*(P2+P1);
 eq4 = P4 == 2*(P3+P2+P1);
 eq5 = P5 == 2*(P1+P2+P3+P4);
 eq6 = P6 == 2*(P1+P2+P3+P4+P5);
 eqs = [eq1 eq2 eq3 eq4 eq5 eq6];
 vars = [P1 P2 P3 P4 P5 P6];
 [sol1, sol2, sol3, sol4, sol5, sol6] = solve(eqs, vars);
 power = [sol1 sol2 sol3 sol4 sol5 sol6];
 powers{area} = power;
 bandwidths(area) = W/6;
 elseif (UsersArea(area) == 7)
 syms P1 P2 P3 P4 P5 P6 P7;
 eq1 = P2 == 2*P1;
 eq2 = Pdis == P1*20 + P2*20 + P3*20 + P4*20 + P5*20 + P6*
20 + P7*20;
 eq3 = P3 == 2*(P2+P1);
 eq4 = P4 == 2*(P3+P2+P1);
 eq5 = P5 == 2*(P1+P2+P3+P4);
 eq6 = P6 == 2*(P1+P2+P3+P4+P5);
 eq7 = P7 == 2*(P1+P2+P3+P4+P5+P6);
 eqs = [eq1 eq2 eq3 eq4 eq5 eq6 eq7];
 vars = [P1 P2 P3 P4 P5 P6 P7];
 [sol1, sol2, sol3, sol4, sol5, sol6, sol7] = solve(eqs,
vars);
 power = [sol1 sol2 sol3 sol4 sol5 sol6 sol7];
3
 powers{area} = power;
 bandwidths(area) = W/7;
 elseif (UsersArea(area) == 8)
 syms P1 P2 P3 P4 P5 P6 P7 P8;
 eq1 = P2 == 2*P1;
 eq2 = Pdis == P1*20 + P2*20 + P3*20 + P4*20 + P5*20 + P6*
20 + P7*20 + P8*20;
 eq3 = P3 == 2*(P2+P1);
 eq4 = P4 == 2*(P3+P2+P1);
 eq5 = P5 == 2*(P1+P2+P3+P4);
 eq6 = P6 == 2*(P1+P2+P3+P4+P5);
 eq7 = P7 == 2*(P1+P2+P3+P4+P5+P6);
 eq8 = P8 == 2*(P1+P2+P3+P4+P5+P6+P7);
 eqs = [eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8];
 vars = [P1 P2 P3 P4 P5 P6 P7 P8];
 [sol1, sol2, sol3, sol4, sol5, sol6, sol7, sol8] =
solve(eqs, vars);
 power = [sol1 sol2 sol3 sol4 sol5 sol6 sol7 sol8];
 powers{area} = power;
 bandwidths(area) = W/8;
 elseif (UsersArea(area) == 9)
 syms P1 P2 P3 P4 P5 P6 P7 P8 P9;
 eq1 = P2 == 2*P1;
 eq2 = Pdis == P1*20 + P2*20 + P3*20 + P4*20 + P5*20 + P6*
20 + P7*20 +P8*20 + P9*20;
 eq3 = P3 == 2*(P2+P1);
 eq4 = P4 == 2*(P3+P2+P1);
 eq5 = P5 == 2*(P1+P2+P3+P4);
 eq6 = P6 == 2*(P1+P2+P3+P4+P5);
 eq7 = P7 == 2*(P1+P2+P3+P4+P5+P6);
 eq8 = P8 == 2*(P1+P2+P3+P4+P5+P6+P7);
 eq9 = P9 == 2*(P1+P2+P3+P4+P5+P6+P7+P8);
 eqs = [eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8 eq9];
 vars = [P1 P2 P3 P4 P5 P6 P7 P8 P9];
 [sol1, sol2, sol3, sol4, sol5, sol6, sol7, sol8, sol9] =
solve(eqs, vars);
 power = [sol1 sol2 sol3 sol4 sol5 sol6 sol7 sol8 sol9];
 powers{area} = power;
 bandwidths(area) = W/9;
 elseif (UsersArea(area) == 10)
 syms P1 P2 P3 P4 P5 P6 P7 P8 P9 P10;
 eq1 = P2 == 2*P1;
 eq2 = Pdis == P1*20 + P2*20 + P3*20 + P4*20 + P5*20 + P6*
20 + P7*20 +P8*20 + P9*20 + P10*20;
 eq3 = P3 == 2*(P2+P1);
 eq4 = P4 == 2*(P3+P2+P1);
 eq5 = P5 == 2*(P1+P2+P3+P4);
 eq6 = P6 == 2*(P1+P2+P3+P4+P5);
 eq7 = P7 == 2*(P1+P2+P3+P4+P5+P6);
 eq8 = P8 == 2*(P1+P2+P3+P4+P5+P6+P7);
 eq9 = P9 == 2*(P1+P2+P3+P4+P5+P6+P7+P8);
 eq10 = P10 == 2*(P1+P2+P3+P4+P5+P6+P7+P8+P9);
4
 eqs = [eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8 eq9 eq10];
 vars = [P1 P2 P3 P4 P5 P6 P7 P8 P9 P10];
 [sol1, sol2, sol3, sol4, sol5, sol6, sol7, sol8, sol9,
sol10] = solve(eqs, vars);
 power = [sol1 sol2 sol3 sol4 sol5 sol6 sol7 sol8 sol9
sol10];
 powers{area} = power;
 bandwidths(area) = W/10;
 end
end
% Calculate SNR and capacity per user, then calculate total BS
capacity
Cnoma = 0;
Cofdma = 0;
N = k*T;
for area = 1:5
 for user = 1:length(powers{area})
 SNR = P/(N*(4*pi*rhosArea{area}(user)/lamda)^2);
 Cofdma = Cofdma + bandwidths(area)*10^6*log2(1+SNR);
 if (user == 1)
 I = 0;
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*10^6*log2(1+SNR));
 elseif (user == 2)
 I = powers{area}(user-1);
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*10^6*log2(1+SNR));
 elseif (user == 3)
 I = powers{area}(user-1) + powers{area}(user-2);
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*10^6*log2(1+SNR));
 elseif (user == 4)
 I = powers{area}(user-1) + powers{area}(user-2) +
powers{area}(user-3);
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*10^6*log2(1+SNR));
 elseif (user == 5)
 I = powers{area}(user-1) + powers{area}(user-2) +
powers{area}(user-3) + powers{area}(user-4);
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*10^6*log2(1+SNR));
 elseif (user == 6)
 I = powers{area}(user-1) + powers{area}(user-2) +
powers{area}(user-3) + powers{area}(user-4) + powers{area}
(user-5);
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
5
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*10^6*log2(1+SNR));
 elseif (user == 7)
 I = powers{area}(user-1) + powers{area}(user-2) +
powers{area}(user-3) + powers{area}(user-4) + powers{area}
(user-5) + powers{area}(user-6);
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*10^6*log2(1+SNR));
 elseif (user == 8)
 I = powers{area}(user-1) + powers{area}(user-2) +
powers{area}(user-3) + powers{area}(user-4) + powers{area}
(user-5) + powers{area}(user-6) + powers{area}(user-7);
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*10^6*log2(1+SNR));
 elseif (user == 9)
 I = powers{area}(user-1) + powers{area}(user-2) +
powers{area}(user-3) + powers{area}(user-4) + powers{area}
(user-5) + powers{area}(user-6) + powers{area}(user-7) +
powers{area}(user-8);
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*log2(1+SNR));
 elseif (user == 10)
 I = powers{area}(user-1) + powers{area}(user-2) +
powers{area}(user-3) + powers{area}(user-4) + powers{area}
(user-5) + powers{area}(user-6) + powers{area}(user-7) +
powers{area}(user-8) + powers{area}(user-9);
 SNR = (powers{area}(user)/(4*pi*rhosArea{area}
(user)/lamda)^2)/(N+I/(4*pi*rhosArea{area}(user)/lamda)^2);
 Cnoma = Cnoma + (W*10^6*log2(1+SNR));
 end
 end
end
BaseTotalCapacityWithNOMA = double(Cnoma)
BaseTotalCapacityWithOFDMA = double(Cofdma)
6
