%this function finds the nFeat max values of each eigVec and returns the
%coresponding features(name of feature and electrode) those features are
%the "most important" in that eigvector
function[features,elec] = getMostImportantFeat(nFeat,eigVec,features,nElec,FeatPerElec)
   [~,idx] = maxk(eigVec,nFeat);
   elec = ceil(idx/nElec);
   features = features(mod(idx-1,FeatPerElec)+1);    
end