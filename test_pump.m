N = 1;
lambda = 1550e-9;
Psig0_dBm = -40:0.5:10; % input power 
Pase0_dBm = -40;
P_in_pump = 40e-3;
gain = zeros(1,length(Psig0_dBm));
ASE = zeros(1,length(Psig0_dBm));

for i = 1:1:length(Psig0_dBm)
    [y_sig_dBm ,y_ase_dBm, y_pmp_dBm] = EDFA_wdm_iter(Psig0_dBm(i),Pase0_dBm,P_in_pump,lambda);
    gain(i) = y_sig_dBm-Psig0_dBm(i);
    ASE(i) = y_ase_dBm;
end

figure(1)
plot(Psig0_dBm,gain,'linewidth',1.5);
xlabel('Optical input power (dBm)');
ylabel('Signal Gain (dB)');
title('EDFA predicted gain vs. input optical power @ signal wavelength = 1550 nm');
legend('pump wavelength = 980 nm, pump power = 40 mW','location','best');
grid on
figure(2)
plot(Psig0_dBm,ASE,'linewidth',1.5);
xlabel('Optical input power (dBm)');
ylabel('ASE noise power (dBm)');
title('EDFA predicted ASE power vs. input optical power @ signal wavelength = 1550 nm');
legend('pump wavelength = 980 nm, pump power = 40 mW','location','best');
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 1;
lambda = 1550e-9;
Psig0_dBm = 10*log10(50e-6/1e-3); % input power considered 50 uWatt
Pase0_dBm = -40;
P_in_pump = 0:1e-3:40e-3;
gain = zeros(1,length(P_in_pump));
ASE = zeros(1,length(P_in_pump));

for i = 1:1:length(P_in_pump),
    [y_sig_dBm y_ase_dBm y_pmp_dBm] = EDFA_wdm_iter(Psig0_dBm,Pase0_dBm,P_in_pump(i),lambda);
    gain(i) = y_sig_dBm-Psig0_dBm;
    ASE(i) = y_ase_dBm;
end
gain = smooth(P_in_pump,gain);
ASE = smooth(P_in_pump,gain);

figure(3)
plot(P_in_pump,gain,'linewidth',1.5);
axis([0 40e-3 0 30]);
xlabel('Optical pump power (dBm)');
ylabel('Signal Gain (dB)');
title('EDFA predicted gain vs. input pump power @ wavelength = 980 nm');
legend('signal wavelength = 1550 nm, signal power = 50 uW');
grid on
figure(4)
plot(P_in_pump,ASE,'linewidth',1.5);
axis([0 40e-3 0 30]);
xlabel('Optical pump power (dBm)');
ylabel('ASE noise power (dBm)');
title('EDFA predicted ASE power vs. input pump power @ wavelength = 980 nm');
legend('signal wavelength = 1550 nm, signal power = 50 uW');
grid on



