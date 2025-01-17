function makeAndTestGaussian()

datasetName = 'FrancescaCepstKinData.mat';
load(datasetName);
indexToRemove = [1:2,21:22];
indexToLoop = 1:40;
indexToLoop(indexToRemove) = [];

vocalTractArray = [];
kinematicArray = [];

for j = indexToLoop
    v = trialData{j};
    acousticValues = v{1};
    kinematicValeus = v{2};
    vocalTractArray = vertcat(vocalTractArray,acousticValues);
    kinematicArray = vertcat(kinematicArray,kinematicValeus);
end
kinematicArray = kinematicArray(:,1);


vocalTractTestArray = [];
kinematicTestArray = [];

for j = indexToRemove
    v = trialData{j};
    acousticValues = v{1};
    kinematicValeus = v{2};
    vocalTractTestArray = vertcat(vocalTractTestArray,acousticValues);
    kinematicTestArray = vertcat(kinematicTestArray,kinematicValeus);
end

kinematicTestArray = kinematicTestArray(1:1000,1);
vocalTractTestArray = vocalTractTestArray(1:1000,:);


vcKinArray = [kinematicArray vocalTractArray];

flag = 0;
numDist = 50;
while(flag == 0)
   try
        numDist
        GMModel = fitgmdist(vcKinArray,numDist);
        flag = 1;
   catch
       numDist = numDist-1;
   end
       
end

GMModel = fitgmdist(vcKinArray,20);

predictedArray = zeros(size(kinematicTestArray));

for i = 1:size(vocalTractTestArray)
    i
    tempPredictedArray = [];
    
    tmpP = [];
    
    for step = -15:0.1:15
        tmpP(end+1) = 0.1*pdf(GMModel,[step vocalTractTestArray(i,:)]);
    end
    
    normFactor = sum(tmpP);
    
    for step = -15:0.1:15
        tempPredictedArray(end+1) = step*0.1*pdf(GMModel,[step vocalTractTestArray(i,:)])/normFactor;
    end
    
    predictedArray(i) = sum(tempPredictedArray);
end

c = corr(kinematicTestArray,predictedArray);
r = sqrt(mean((predictedArray - kinematicTestArray).^2));



end