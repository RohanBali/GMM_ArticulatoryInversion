% This code analysis the function acoustics = f(kinematics)
%

function makeCepstAndKinematicArrays(divisionNumber)

load('E:\AllDatasets\RohanJune32016Francesca\ContinuousDataset\FrancescaContinuousSegments.mat')


acTemp = [];

for i = 1:length(ac)
    acTrial = ac{i};
    for j = 1:length(acTrial)
        acTemp = vertcat(acTemp, acTrial{j});
    end
end

meanAcVal = 0.03*Fs*mean(abs(acTemp-mean(acTemp)));

trialData = [];

for trialNumber = 1:length(ac)
    
    trialNumber
    acTrial = ac{trialNumber};
    windowSamples = 0.03*Fs;

    vocalTractArray = [];
    kinematicArray = [];

    for sampleNumber = 1:length(acTrial)
        
        kin = [bc{trialNumber}{sampleNumber} ttx{trialNumber}{sampleNumber} ttz{trialNumber}{sampleNumber} ttt{trialNumber}{sampleNumber} tdx{trialNumber}{sampleNumber} tdz{trialNumber}{sampleNumber} tbx{trialNumber}{sampleNumber} tbz{trialNumber}{sampleNumber} jawx{trialNumber}{sampleNumber} jawz{trialNumber}{sampleNumber} ulx{trialNumber}{sampleNumber} ulz{trialNumber}{sampleNumber} llx{trialNumber}{sampleNumber} llz{trialNumber}{sampleNumber}];
        %kin = [ttz{trialNumber}{sampleNumber}];
        acSample = acTrial{sampleNumber};
        
        for i = 1:windowSamples/2:length(acSample)-windowSamples
            sI = i;
            eI = i+windowSamples-1;
            
            acSegment = acSample(sI:eI);
            kinSegment = kin(sI:eI,:);
            if ~isSilent(acSegment,meanAcVal)
                vocalTractSegment = findCepstralCoeff(acSegment);
                vocalTractArray(end+1,:) = vocalTractSegment;
                kinematicArray(end+1,:) = mean(kinSegment);
            end
        end
    end
    trialData{end+1} = {vocalTractArray,kinematicArray};
end

end
