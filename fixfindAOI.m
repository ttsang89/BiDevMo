% % Fixation AOI for FV
% After basic parsing of data, you have index of saccade, blink and lost. 
% With the left over fixations, you can identify which AOI the current
% cross hair is in. for ThisClipIndex = 1:length(WhichClips)
currentDir = dir('/Users/tawnytsang/Desktop/Projects/DevMo/');
this_part = 'bilingual/batch_FV-0609-fix.xlsx';
[data, txt, raw] = xlsread(this_part,'batch_FV-0609-fix.xls','A:H');

% 
% % ------------------------%
% % Structure of data file:
% % column 1: SUBJECT ID
% % column 2: trial Index
% % column 3: Video Name
% % Column 4: startFrame Fix
% % Column 5: endFrame Fix
% % Column 6: current Fix Index
% % Column 7: X
% % Column 8: Y
% 
data(isnan(data(:,4)),4)=1;
save('/Users/tawnytsang/Desktop/Projects/DevMo/FV_data/bilingual_batch/last_batch.mat','data');


xData = data(:,7); yData = data(:,8);
% inBoundX = find(xData>200 | xData<1480);
% inBoundY = find(yData>165 | yData<885);
% adjX = round(xData(inBoundX))-200; adjY = round(yData(inBoundY));
adjX= round(xData-200); adjY = round(yData - 165);

fixationAOIIndex = zeros(length(xData),1);
% % code out of bounds as lost!
out = find(adjX<0 | adjX>1280| adjY<0 | adjY>720);
% blink_lost = find(thisPart(:,6)==1);
% saccade = find(thisPart(:,4)==1);
% % now the tough part....AOIS!

clip1 = find(data(:,3)==1);

    fileNames = dir('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/01_AOI/untitled folder/*.tif');
%     AOI_file = imread(fileName);
    
    realVal = find((adjX(clip1)>0 & adjX(clip1)<1280) & (adjY(clip1)>0 & adjY(clip1)<720));
    for index = 1:length(realVal) 
        currentAOI = strcat('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/01_AOI/untitled folder/', fileNames(index).name);
        AOI_file = imread(currentAOI);
        thisAOI = AOI_file(adjY(clip1(realVal(index))), adjX(clip1(realVal(index))));
        if thisAOI == 255;
            fixationAOIIndex(clip1(realVal(index)))=1;
        elseif thisAOI == 0;
            fixationAOIIndex(clip1(realVal(index)))=2;
        else fixationAOIIndex(clip1(realVal(index)))=3;
        end
    end
%     figure; image(real); hold on; image(AOI_file); alpha(.3); plot(adjX(clip1), adjY(clip1), '.');
clear AOI_file fileName realVal

clip2 = find(data(:,3)==2);
realVal = find((adjX(clip2)>0 & adjX(clip2)<1280) & (adjY(clip2)>0 & adjY(clip2)<720));
frameChange = [1 22 41 168 193 213 291 558 615];
AOI_files = dir('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/02_AOI/untitled folder/*.tif');

for p = 1:length(frameChange)-1
for index = 1:length(realVal)
    if (data(clip2(realVal(index)),5) >= frameChange(p) & data(clip2(realVal(index)),5) <= frameChange(p+1))
        currentAOI = strcat('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/02_AOI/untitled folder/', AOI_files(p).name);
        AOI_file = imread(currentAOI);
        thisAOI = AOI_file(adjY(clip2(realVal(index))), adjX(clip2(realVal(index))));
        
        if thisAOI == 0;
            fixationAOIIndex(clip2(realVal(index)))=2;
        elseif thisAOI == 255;
            fixationAOIIndex(clip2(realVal(index)))=1;
        else fixationAOIIndex(clip2(realVal(index)))=3;
        end
    end
    
        
end
% 
end

% image(AOI_file); hold on; plot(adjX(clip2(realVal)), adjY(clip2(realVal)), '.')
clear AOI_file fileName realVal frameChange


clip3 = find(data(:,3)==3);

fileNames = dir('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/03_AOI/untitled folder/*.tif');
realVal = find((adjX(clip3)>0 & adjX(clip3)<1280) & (adjY(clip3)>0 & adjY(clip3)<720));
        for index = 1:length(realVal) 
            currentAOI = strcat('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/03_AOI/untitled folder/', fileNames(index).name);
            AOI_file = imread(currentAOI);
            thisAOI = AOI_file(adjY(clip3(realVal(index))), adjX(clip3(realVal(index))));
        if thisAOI == 255;
            fixationAOIIndex(clip3(realVal(index)))=1;
        elseif thisAOI == 0;
            fixationAOIIndex(clip3(realVal(index)))=2;
        else fixationAOIIndex(clip3(realVal(index)))=3;
        end
    end
    figure; image(AOI_file); hold on; alpha(.3); plot(adjX(clip3), adjY(clip3), '.');
clear AOI_file fileName realVal



clip4 = find(data(:,3)==4);
% %     clip 1 has 1 AOI
    fileName = strcat('stims/devMoStims/04_AOI/04_block_AOI/04_talk_block001.tif');
    AOI_file = imread(fileName);
    realVal = find((adjX(clip4)>0 & adjX(clip4)<1280) & (adjY(clip4)>0 & adjY(clip4)<720));
    image(AOI_file); hold on; plot(adjX(clip4(realVal)), adjY(clip4(realVal)), '.')
    for index = 1:length(realVal) 
        thisAOI = AOI_file(adjY(clip4(realVal(index))), adjX(clip4(realVal(index))));
        if thisAOI == 255;
            fixationAOIIndex(clip4(realVal(index)))=1;
        elseif thisAOI == 0;
            fixationAOIIndex(clip4(realVal(index)))=2;
        else fixationAOIIndex(clip4(realVal(index)))=3;
        end
    end

    clear AOI_file fileName realVal
    
clip5 = find(data(:,3)==5);
realVal = find((adjX(clip5)>0 & adjX(clip5)<1280) & (adjY(clip5)>0 & adjY(clip5)<720));
frameChange = [1 86 135 206 243 487 543 571];
AOI_files = dir('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/05_AOI/05_wbus_AOI/*.tif');
for p = 1:length(frameChange)-1
for index = 1:length(realVal)
    if (data(clip5(realVal(index)),5) >= frameChange(p) & data(clip5(realVal(index)),5) <= frameChange(p+1))
        currentAOI = strcat('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/05_AOI/05_wbus_AOI/', AOI_files(p).name);
        AOI_file = imread(currentAOI);
% 
        thisAOI = AOI_file(adjY(clip5(realVal(index))), adjX(clip5(realVal(index))));
        if thisAOI > 145;
            fixationAOIIndex(clip5(realVal(index)))=1;
        elseif thisAOI ==0;
            fixationAOIIndex(clip5(realVal(index)))=2;
        else fixationAOIIndex(clip5(realVal(index)))=3;
        end
    end
end
end    
clear AOI_file fileName realVal frameChange

clip6 = find(data(:,3)==6);
realVal = find((adjX(clip6)>0 & adjX(clip6)<1280) & (adjY(clip6)>0 & adjY(clip6)<720));
frameChange = [1 23 133 182 248 519];
AOI_files = dir('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/06_AOI/06_farm_AOI/*.tif');

for p = 1:length(frameChange)-1
for index = 1:length(realVal)
    if (data(clip6(realVal(index)),5) >= frameChange(p) & data(clip6(realVal(index)),5) <= frameChange(p+1))
        currentAOI = strcat('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/06_AOI/06_farm_AOI/', AOI_files(p).name);
        AOI_file = imread(currentAOI);
                image(AOI_file)
        thisAOI = AOI_file(adjY(clip6(realVal(index))), adjX(clip6(realVal(index))));
        if thisAOI == 255;
            fixationAOIIndex(clip6(realVal(index)))=1;
        elseif thisAOI ==0;
            fixationAOIIndex(clip6(realVal(index)))=2;
        else fixationAOIIndex(clip6(realVal(index)))=3;
        end
    end
end
end  
clear AOI_file fileName realVal frameChange

clip7 = find(data(:,3)==7);
realVal = find((adjX(clip7)>0 & adjX(clip7)<1280) & (adjY(clip7)>0 & adjY(clip7)<720));
frameChange = [1 25 64 112 247 283 319 423 480];
AOI_files = dir('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/07_AOI/07_love_AOI/*.tif');

for p = 1:length(frameChange)-1
for index = 1:length(realVal)
    if (data(clip7(realVal(index)),5) >= frameChange(p) & data(clip7(realVal(index)),5) <= frameChange(p+1))
        currentAOI = strcat('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/07_AOI/07_love_AOI/', AOI_files(p).name);
        AOI_file = imread(currentAOI);
        thisAOI = AOI_file(adjY(clip7(realVal(index))), adjX(clip7(realVal(index))));
        if thisAOI == 255;
            fixationAOIIndex(clip7(realVal(index)))=1;
        elseif thisAOI ==0;
            fixationAOIIndex(clip7(realVal(index)))=2;
        else fixationAOIIndex(clip7(realVal(index)))=3;
        end
    end
end
end  

clear AOI_file fileName realVal frameChange

clip8 = find(data(:,3)==8);
% %     clip 1 has 1 AOI
    fileName = strcat('/stims/devMoStims/08_AOI/08_song_suns001.tif');
    AOI_file = imread(fileName);
    realVal = find((adjX(clip8)>0 & adjX(clip8)<1280) & (adjY(clip8)>0 & adjY(clip8)<720));
    for index = 1:length(realVal) 
        thisAOI = AOI_file(adjY(clip8(realVal(index))), adjX(clip8(realVal(index))));
        if thisAOI == 255;
            fixationAOIIndex(clip8(realVal(index)))=1;
        elseif thisAOI == 0;
            fixationAOIIndex(clip8(realVal(index)))=2;
        else fixationAOIIndex(clip8(realVal(index)))=3;
        end
    end
clear AOI_file fileName realVal frameChange

clip9 = find(data(:,3)==9);
realVal = find((adjX(clip9)>0 & adjX(clip9)<1280) & (adjY(clip9)>0 & adjY(clip9)<720));
frameChange = [1 3 367 422 446 466 492 570 593];
AOI_files = dir('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/09_AOI/09_star_AOI/*.tif');

for p = 1:length(frameChange)-1
for index = 1:length(realVal)
    if (data(clip9(realVal(index)),5) >= frameChange(p) & data(clip9(realVal(index)),5)<= frameChange(p+1))
        currentAOI = strcat('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/09_AOI/09_star_AOI/', AOI_files(p).name);
        AOI_file = imread(currentAOI);
        thisAOI = AOI_file(adjY(clip9(realVal(index))), adjX(clip9(realVal(index))));
        if thisAOI == 0;
            fixationAOIIndex(clip9(realVal(index)))=2;
        elseif thisAOI > 100;
            fixationAOIIndex(clip9(realVal(index)))=1;
        else fixationAOIIndex(clip9(realVal(index)))=3;
        end
    end
end
end  

clear AOI_file fileName realVal frameChange

clip10 = find(data(:,3)==10);
realVal = find((adjX(clip10)>0 & adjX(clip10)<1280) & (adjY(clip10)>0 & adjY(clip10)<720));
frameChange = [1 39 287 1090];
AOI_files = dir('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/10_AOI/10_talk_AOI/*.tif');

for p = 1:length(frameChange)-1
for index = 1:length(realVal)
    if (data(clip10(realVal(index)),5)>= frameChange(p) & data(clip10(realVal(index)),5)<= frameChange(p+1))
        currentAOI = strcat('/Users/tawnytsang/Desktop/Projects/DevMo/stims/devMoStims/10_AOI/10_talk_AOI/', AOI_files(p).name);
        AOI_file = imread(currentAOI);
        thisAOI = AOI_file(adjY(clip10(realVal(index))), adjX(clip10(realVal(index))));
        if thisAOI == 255;
            fixationAOIIndex(clip10(realVal(index)))=1;
        elseif thisAOI ==0;
            fixationAOIIndex(clip10(realVal(index)))=2;
        else fixationAOIIndex(clip10(realVal(index)))=3;
        end
    end
end
end  
% 
% fixationAOIIndex(blink_lost)= 0;
% fixationAOIIndex(saccade)=-1;
fixationAOIIndex(out)=10;
data(:,9) = fixationAOIIndex;
csvwrite('/Users/tawnytsang/Desktop/Projects/DevMo/FV_data/bilingual_batch/newdata_0610.csv' ...
    ,data)
