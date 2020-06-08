function[features,elec] = getMostImportantFeat(nFeat,eigVec,features,nElec,FeatPerElec)
   [~,idx] = maxk(eigVec,nFeat);
   elec = ceil(idx/nElec);
   features = features(mod(idx-1,FeatPerElec)+1);    
end