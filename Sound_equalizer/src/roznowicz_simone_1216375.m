%% *** TESINA SEGNALI E SISTEMI ***
clear 
close all
clc 


%% PRIMA PARTE: ascoltare i segnali audio

load audio;
player = audioplayer(x,Fc);
%play(player);
player_dis = audioplayer(x_dis,Fc);
%play(player_dis);


%% SECONDA PARTE: 
% calcolo trasformata di Fourier dei segnali x e x_dis con plot associato.
N = length(x);
fc = Fc/N;
X = (1/Fc)*fft(x);
X = fftshift(X);   
f = fc*(-N/2:N/2-1);
figure;
subplot(1,3,1);
plot(f,abs(X),'r');
grid on
xlabel('Frequenza [Hz]');
ylabel('|X(f)|');

% plot del modulo della trasformata di Fourier del segnale x_dis
N_dis = length(x_dis);
X_dis = (1/Fc)*fft(x_dis);
X_dis = fftshift(X_dis);   
f = fc*(-N_dis/2:N_dis/2-1);
subplot(1,3,2);
plot(f,abs(X_dis),'b');
grid on
xlabel('Frequenza [Hz]');
ylabel('|X_d_i_s(f)|');

% definisco i vettori delle frequenzee e dei coefficienti.
% creo il banco di filtri con l'apposita funzione, infine applico il filtraggio
f_vals = [1,2e3,3.25e3,6e3,8e3,10e3,23.999e3];
eq_vals = [7,1,2,0.5,1,1];
H = filter_bank(eq_vals, f_vals, Fc, false);
x_f = filter(H.Numerator{:},H.Denominator{:},x_dis);

% plot del modulo della trasformata di Fourier del segnale x_f
N_f = length(x_f);
fc = Fc/N_f;
X_f = (1/Fc)*fft(x_f);
X_f = fftshift(X_f);    
f = fc*(-N_f/2:N_f/2-1);
subplot(1,3,3);
plot(f,abs(X_f),'b');
grid on
xlabel('Frequenza [Hz]');
ylabel('|X_f(f)|');

% ascolto il nuovo segnale ottenuto filtrando il segnale x_dis 
player_f = audioplayer(x_f,Fc);
%play(player_f);


%% TERZA PARTE:
%ripeto tre analisi separate per nus = 3,4,6, generando i segnali x_nus3, 
%x_nus4, x_nus6 rispettivamente (sono generati scegliendo 1 campione su 
%3,4 o 6 del segnale x originario). Tali segnali possono essere ascoltati e
%vengono plottati nel dominio delle frequenze (stabilendo uguali i limiti 
%dell'asse x in modo che si possano vedere immediatamente gli effetti dei 
%diversi campionamenti confrontando i grafici).

%caso nus = 3
nus = 3;
Fus = Fc/nus;
N = ceil(length(x)/nus);
fc = Fus/N;
x_nus3 = zeros(N,1);
i=1; k=1;
while i< length(x)
    x_nus3(k) = x(i);
    k=k+1;
    i=i+nus;
end
X_nus3 = (1/Fus)*fft(x_nus3);
X_nus3 = fftshift(X_nus3);    
f = fc*(-N/2:N/2-1);
figure;
subplot(1,3,1);
plot(f,abs(X_nus3),'g');
grid on
xlabel('Frequenza [Hz]');
ylabel('|X_n_u_s_=_3(f)|');
axis([-2.5*10^4 2.5*10^4 0 inf]);
playerus3 = audioplayer(x_nus3,Fus);
%play(playerus3);

%caso nus = 4
nus = 4;
Fus = Fc/nus;
N = ceil(length(x)/nus);
fc = Fus/N;
x_nus4 = zeros(N,1);
i=1; k=1;
while i< length(x)
    x_nus4(k) = x(i);
    k=k+1;
    i=i+nus;
end
X_nus4 = (1/Fus)*fft(x_nus4);
X_nus4 = fftshift(X_nus4);    
f = fc*(-N/2:N/2-1);
subplot(1,3,2);
plot(f,abs(X_nus4),'g');
grid on
xlabel('Frequenza [Hz]');
ylabel('|X_n_u_s_=_4(f)|');
axis([-2.5*10^4 2.5*10^4 0 inf]);
playerus4 = audioplayer(x_nus4,Fus);
%play(playerus4);

%caso nus = 6
nus = 6;
Fus = Fc/nus;
N = ceil(length(x)/nus);
fc = Fus/N;
x_nus6 = zeros(N,1);
i=1; k=1;
while i< length(x)
    x_nus6(k) = x(i);
    k=k+1;
    i=i+nus;
end
X_nus6 = (1/Fus)*fft(x_nus6);
X_nus6 = fftshift(X_nus6);    
f = fc*(-N/2:N/2-1);
subplot(1,3,3);
plot(f,abs(X_nus6),'g');
grid on
xlabel('Frequenza [Hz]');
ylabel('|X_n_u_s_=_6(f)|');
axis([-2.5*10^4 2.5*10^4 0 inf]);
playerus6 = audioplayer(x_nus6,Fus);
%play(playerus6);


%% PARTE QUATTRO:
% prima filtro x e ottengo x_ff
% poi sottocampiono x_ff (ottenendo x_cappello) e analizzo, nel dominio 
% delle frequenze, che x_ff non dovrebbe presentare aliasing.
% Ascolto e confronto (in frequenza) x_ff e x_cappello.

%generazione e applicazione del filtro per la creazione di x_ff 
nus = 6;
Fus = Fc/nus;
N = ceil(length(x)/nus);
eq_vals = [1,0.05,0.03,0.01,0.01,0.01];    
H = filter_bank(eq_vals, f_vals, Fc, false); 
% applico il filtro al segnale x sottocampionato (Fus = Fc/6), ottengo x_ff
x_ff = filter(H.Numerator{:},H.Denominator{:},x); 

%rappresentazione segnale x_ff in frequenza
N = length(x_ff);
fc = Fc/N;
X_ff = (1/Fc)*fft(x_ff);
X_ff = fftshift(X_ff);    
f = fc*(-N/2:N/2-1);
figure;
subplot(1,2,1);
plot(f,abs(X_ff),'m');
grid on
xlabel('Frequenza [Hz]');
ylabel('|X_f_f(f)|');
playerff = audioplayer(x_ff,Fc);    
%play(playerff);

%rappresentazione segnale x_cappello in frequenza
fc = Fus/N;
x_cappello = zeros(N,1);
i=1; k=1;
while i< length(x_ff)
    x_cappello(k) = x_ff(i);
    k=k+1;
    i=i+nus;
end
X_cappello = (1/Fus)*fft(x_cappello);
X_cappello = fftshift(X_cappello);    
f = fc*(-N/2:N/2-1);
subplot(1,2,2);
plot(f,abs(X_cappello),'m');
grid on
xlabel('Frequenza [Hz]');
ylabel('|X_c_a_p_p_e_l_l_o(f)|');
axis([-2.5*10^4 2.5*10^4 0 inf]);
%verifico il miglioramento del suono a seguito del filtro anti aliasing
player6 = audioplayer(x_cappello,Fus);    
%play(player6);


