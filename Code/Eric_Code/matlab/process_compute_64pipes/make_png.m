files = dir('*KKI*.fig')

i = 0;

while (i < length(files))
    save = files(i + 1).name;
    fig = openfig(save);
    ax = gca;
    ax.TitleFontSizeMultiplier = 1;
    fig.Position = [230 550 1900 420];
    set(fig, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 4]);
    saveas(fig, strcat(save(1:end-4), '.png'), 'png');
    i = i + 1;
    
end
