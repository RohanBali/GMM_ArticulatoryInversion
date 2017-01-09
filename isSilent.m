function bool = isSilent(acousticSegment,meanAcoustic)
bool = 0;
acousticSegment = acousticSegment - mean(acousticSegment);
if sum(abs(acousticSegment)) < 0.25*meanAcoustic
    bool = 1;
end

end
