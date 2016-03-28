files = dir('*.fig')

i = 0;

while (i < length(files))
    save = files(i + 1).name;
    fig = openfig(save);
    ax = gca;
    ax.TitleFontSizeMultiplier = 1;
    saveas(fig, strcat(save(1:end-4), '.png'), 'png');
    i = i + 1;
    
end
