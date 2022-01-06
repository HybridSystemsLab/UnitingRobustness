% Rerun on existing data in workspace, to make adjustments to plot.

%% Nominal plots: Think about making these subplots (left-right)!
% z1 vs time:
figure(1)
clf
modificatorF{1} = '';
modificatorF{2} = 'LineWidth';
modificatorF{3} = 1.5;
modificatorJ{1} = '*--';
modificatorJ{2} = 'LineWidth';
modificatorJ{3} = 1.5;
subplot(1,2,1),plotHarc(tNom,jNom,xNom(:,1),[],modificatorF,modificatorJ);
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)

axes('Position',[0.3 0.8 0.2 0.1])
box on
plotHarc(tNom,jNom,xNom(:,1),[],modificatorF,modificatorJ);
set(gca,'xtick',[0 2.5 5])
set(gca,'ytick',[0 25 60])
axis([0 5 -10 60])

% Log scale L(z_1)-L^* vs time:
subplot(1,2,2),semilogy(tNomA,lNomA,'LineWidth',1.5);
axis([0 2000 10^(-36) 10^(4)]);
set(gca,'ytick',[10^(-36) 10^(-32) 10^(-28) 10^(-24) 10^(-20) 10^(-16) 10^(-12) 10^(-8) 10^(-4) 10^(0) 10^4])
legend({'c_{1,0}=6819.67593','c_{1,0}=6819.676','c_{1,0}=6819.68','c_{1,0}=6820'},'Location','northeast')
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)

axes('Position',[0.65 0.4 0.2 0.1])
box on
hold on
semilogy(tNomA,lNomA,'LineWidth',1.5);
hold off
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[10^(-20) 10^(-10) 10^(0)])
axis([0 2 10^(-20) 10^(4)])
hold off

saveas(gcf,'Plots\PlotNominalLog','epsc')

%% Plots with different amounts of Gaussian noise:
% z1 vs time, using sigmas 0.25, 0.5, and 1:
figure(2)
clf
subplot(3,1,1),plotHarc(tf,jf,xf(:,1)); % Purple
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)
subplot(3,1,2),plotHarc(tb,jb,xb(:,1)); % Red
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)
subplot(3,1,3),plotHarc(tc,jc,xc(:,1)); % Green
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)

axes('Position',[0.7 0.8 0.2 0.1])
box on
plotHarc(tf,jf,xf(:,1));
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[-10 25 60])
axis([0 2 -10 60])

axes('Position',[0.7 0.5 0.2 0.1])
box on
plotHarc(tb,jb,xb(:,1));
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[-10 25 60])
axis([0 2 -10 60])

axes('Position',[0.7 0.2 0.2 0.1])
box on
plotHarc(tc,jc,xc(:,1));
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[-10 25 60])
axis([0 2 -10 60])

saveas(gcf,'Plots\PlotsNoise','epsc')

% Log scale L(z_1)-L^* vs time, using sigmas 0.25, 0.5, and 1:
figure(3)
clf
subplot(3,1,1),semilogy(tf,lF,'Color',[0.4940 0.1840 0.5560],'LineWidth',1.5);
axis([0 2000 10^(-19) 10^(4)]);
set(gca,'ytick',[10^(-16) 10^(-8) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)
subplot(3,1,2),semilogy(tb,lB,'Color',[0.6350 0.0780 0.1840],'Linewidth',1.5);
axis([0 2000 10^(-19) 10^(4)]);
set(gca,'ytick',[10^(-16) 10^(-8) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)
subplot(3,1,3),semilogy(tc,lC,'Color',[0.4660 0.6740 0.1880],'Linewidth',1.5);
axis([0 2000 10^(-19) 10^(4)]);
set(gca,'ytick',[10^(-16) 10^(-8) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)

axes('Position',[0.2 0.8 0.2 0.1])
box on
hold on
semilogy(tf,lF,'Color',[0.4940 0.1840 0.5560],'LineWidth',1.5);
hold off
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[10^(-3) 10^(0) 10^(4)])
axis([0 2 10^(-3) 10^(4)])

axes('Position',[0.2 0.5 0.2 0.1])
box on
hold on
semilogy(tb,lB,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);
hold off
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[10^(-3) 10^(0) 10^(4)])
axis([0 2 10^(-3) 10^(4)])

axes('Position',[0.2 0.2 0.2 0.1])
box on
hold on
semilogy(tc,lC,'Color',[0.4660 0.6740 0.1880],'LineWidth',1.5);
hold off
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[10^(-3) 10^(0) 10^(4)])
axis([0 2 10^(-3) 10^(4)])

saveas(gcf,'Plots\PlotsNoiseLogLong','epsc')


%% More noisy plots, won't be in the journal (unless we decide to show it all), just so I can see the results:

% z1 vs time, using sigmas 0.01, 0.05. and 0.1:
figure(4)
clf
subplot(3,1,1),plotHarc(td,jd,xd(:,1)); % Purple
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)
subplot(3,1,2),plotHarc(te,je,xe(:,1)); % Red
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)
subplot(3,1,3),plotHarc(ta,ja,xa(:,1)); % Green
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)

axes('Position',[0.7 0.8 0.2 0.1])
box on
plotHarc(td,jd,xd(:,1));
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[-10 25 60])
axis([0 2 -10 60])

axes('Position',[0.7 0.5 0.2 0.1])
box on
plotHarc(te,je,xe(:,1));
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[-10 25 60])
axis([0 2 -10 60])

axes('Position',[0.7 0.2 0.2 0.1])
box on
plotHarc(ta,ja,xa(:,1));
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[-10 25 60])
axis([0 2 -10 60])
hold off

saveas(gcf,'Plots\PlotsNoise2','epsc')

% Log scale L(z_1)-L^* vs time, using sigmas 0.01, 0.05. and 0.1:
figure(5)
clf
subplot(3,1,1),semilogy(td,lD,'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
axis([0 2000 10^(-19) 10^(4)]);
set(gca,'ytick',[10^(-16) 10^(-8) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)
subplot(3,1,2),semilogy(te,lE,'Color',[0.3010 0.7450 0.9330],'Linewidth',1.5);
axis([0 2000 10^(-19) 10^(4)]);
set(gca,'ytick',[10^(-16) 10^(-8) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)
subplot(3,1,3),semilogy(ta,lA,'Color',[0.9290 0.6940 0.1250],'Linewidth',1.5);
axis([0 2000 10^(-19) 10^(4)]);
set(gca,'ytick',[10^(-16) 10^(-8) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)

axes('Position',[0.2 0.8 0.2 0.1])
box on
hold on
semilogy(td,lD,'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
hold off
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[10^(-3) 10^(0) 10^(4)])
axis([0 2 10^(-3) 10^(4)])

axes('Position',[0.2 0.5 0.2 0.1])
box on
hold on
semilogy(te,lE,'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5);
hold off
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[10^(-3) 10^(0) 10^(4)])
axis([0 2 10^(-3) 10^(4)])

axes('Position',[0.2 0.2 0.2 0.1])
box on
hold on
semilogy(ta,lA,'Color',[0.9290 0.6940 0.1250],'LineWidth',1.5);
hold off
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[10^(-3) 10^(0) 10^(4)])
axis([0 2 10^(-3) 10^(4)])

saveas(gcf,'Plots\PlotsNoiseLog2','epsc')

%% The plots I will put in the paper: Sigmas 0.01, 0.1, 0.5, and 1:

figure(6)
clf
subplot(4,1,1),plotHarc(td,jd,xd(:,1)); % Purple
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)
subplot(4,1,2),plotHarc(ta,ja,xa(:,1)); % Red
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)
subplot(4,1,3),plotHarc(tb,jb,xb(:,1)); % Green
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)
subplot(4,1,4),plotHarc(tc,jc,xc(:,1)); % Green
grid on
axis([0 2000 -10 60]);
xlabel('t','FontSize',16)
ylabel('z_1','FontSize',16)

axes('Position',[0.7 0.8 0.2 0.1])
box on
plotHarc(td,jd,xd(:,1));
set(gca,'xtick',[0 2.5 5])
set(gca,'ytick',[-10 25 60])
axis([0 5 -10 60])

axes('Position',[0.7 0.55 0.2 0.1])
box on
plotHarc(ta,ja,xa(:,1));
set(gca,'xtick',[0 2.5 5])
set(gca,'ytick',[-10 25 60])
axis([0 5 -10 60])

axes('Position',[0.7 0.4 0.2 0.1])
box on
plotHarc(tb,jb,xb(:,1));
set(gca,'xtick',[0 1 2])
set(gca,'ytick',[-10 25 60])
axis([0 5 -10 60])

axes('Position',[0.7 0.2 0.2 0.1])
box on
plotHarc(tc,jc,xc(:,1));
set(gca,'xtick',[0 2.5 5])
set(gca,'ytick',[-10 25 60])
axis([0 5 -10 60])

saveas(gcf,'Plots\PlotsNoiseJournal','epsc')

% Log scale L(z_1)-L^* vs time, using sigmas 0.01, 0.05. and 0.1:
figure(7)
clf
subplot(4,1,1),semilogy(td,lD,'Color',[0.4940 0.1840 0.5560],'LineWidth',1.5);
axis([0 2000 10^(-20) 10^(4)]);
set(gca,'ytick',[10^(-20) 10^(-10) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)
subplot(4,1,2),semilogy(ta,lA,'Color',[0.3010 0.7450 0.9330],'Linewidth',1.5);
axis([0 2000 10^(-20) 10^(4)]);
set(gca,'ytick',[10^(-20) 10^(-10) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)
subplot(4,1,3),semilogy(tb,lB,'Color',[0.6350 0.0780 0.1840],'Linewidth',1.5);
axis([0 2000 10^(-20) 10^(4)]);
set(gca,'ytick',[10^(-20) 10^(-10) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)
subplot(4,1,4),semilogy(tc,lC,'Color',[0.4660 0.6740 0.1880],'Linewidth',1.5);
axis([0 2000 10^(-20) 10^(4)]);
set(gca,'ytick',[10^(-20) 10^(-10) 10^(0)])
xlabel('t','FontSize',16)
ylabel('L(z_1)-L^*','FontSize',16)

saveas(gcf,'Plots\PlotsNoiseLogJournal','epsc')
