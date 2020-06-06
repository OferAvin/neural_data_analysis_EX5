function[] = pca_plot(data,t,idx,name)

fig = figure(idx);
set(fig,'units','centimeters','position',[5,0,30,12]) ;

subplot(1,2,1);
scatter(data.comp(:,1),data.comp(:,2),5,t,'filled');
colorbar;
colormap(winter);
xlabel('PC1'); ylabel('PC2'); zlabel('PC3');

subplot(1,2,2);
scatter3(data.comp(:,1),data.comp(:,2),data.comp(:,3),5,t,'filled');
colorbar;
colormap(winter);
xlabel('PC1'); ylabel('PC2');

suptitle(["subject " + name + " : seizure " + data.seiz_num]);