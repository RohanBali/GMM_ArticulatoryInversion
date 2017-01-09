function cepstVals = findCepstralCoeff(acSegment)
acSegment = makeIntoRowVector(acSegment);
cepstVals = [];

if sum(abs(acSegment)) > 0
    acSegment = acSegment - mean(acSegment);
    acSegment = acSegment.*hamming(length(acSegment));
    c = cceps(acSegment);
    cepstVals = c(1:20)';
else
    cepstVals = zeros(1,20);
end
end


function vector = makeIntoRowVector(vector)

if size(vector,2) > 1
    vector = vector';
end
    
end