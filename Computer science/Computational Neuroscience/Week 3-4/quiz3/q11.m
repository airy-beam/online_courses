load('tuning.mat')
ave1 = mean(neuron1);
ave2 = mean(neuron2);
ave3 = mean(neuron3);
ave4 = mean(neuron4);

figure(1);
plot(stim', ave1, stim', ave2, stim', ave3, stim', ave4);
xlim([0 360])
ylim([-35 35])
ave1(9)
