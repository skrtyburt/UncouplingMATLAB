function uncoupling_preprocessing(ref_pop,exp_pop,regions)

[nrA, ncA] = size(ref_pop);
[nrB, ncB] = size(exp_pop);

%% Perform data checks
% ensure number of regions in arrays matches regions input
% parameter
if nrA ~= regions
    fprintf(2,'Number of brain regions in input array A does not match specified region count. Exiting...\n')
    return
end
if nrB ~= regions
    fprintf(2,'Number of brain regions in input array B does not match specified region count. Exiting...\n')
    return
end

%% compute the mean, standard deviation of the reference and experimental populations for
% every region
for i=1:ncA
    meanA(i) = mean(ref_pop(:,i));
    stdevA(i) = std(ref_pop(:,i));
end
for i=1:ncB
    meanB(i) = mean(exp_pop(:,i));
    stdevB(i) = std(exp_pop(:,i));
end
% compute the regional z-score of exp pop referenced to mean and stdev of ref, ref
% to ref, exp to exp
for i=1:nrA
    for j=1:ncA
        z_ref(i,j) = (ref_pop(i,j)-meanA(j))/stdevA(j);
    end
end

for i=1:nrB
    for j=1:ncB
        z_exp(i,j) = (exp_pop(i,j)-meanB(j))/stdevB(j);
    end
end

for i=1:nrA
    for j=1:ncA
        z_exp2ref(i,j) = (exp_pop(i,j)-meanA(j))/stdevA(j);
    end
end

% fetch size of z-score matrices (should be same size as the original
% matrices)
[z_ref_r, z_ref_c] = size(z_ref);
[z_exp_r, z_exp_c] = size(z_exp);
[z_exp2ref_r, z_exp2ref_c] = size(z_exp2ref);

% create vectors of mean, SEM data
for k=1:z_ref_r
    z_ref_mean(k) = mean(z_ref(k,:));
    z_ref_SEM(k) = std(z_ref(k,:))/sqrt(z_ref_c);
end

for k=1:z_exp_r
    z_exp_mean(k) = mean(z_exp(k,:));
    z_exp_SEM(k) = std(z_exp(k,:))/sqrt(z_exp_c);
end

for k=1:z_exp2ref_r
    z_exp2ref_mean(k) = mean(z_exp(k,:));
    z_exp2ref_SEM(k) = std(z_exp(k,:))/sqrt(z_exp2ref_c);
end

% compare the relative position of a specific brain region between ref and exp 
for i=1:nrB
    [h,p1,ci,stats] = ttest2(z_exp(i,:),z_ref(i,:),"Vartype","unequal","Tail","both");
    ttest_dir_comp(i,1) = h; ttest_dir_comp(i,2) = p1;
end
t1 = array2table(ttest_dir_comp,"RowNames",{'AI','AuDMV','CPu','Cg','CC','DLO','DLIVEnt','DI','ECT','Fornix','FrA','HIP','LO','MO','PtPR','PtA','PRH','PrL','M1','S1','RSC','M2','S2','TeA','TH','VO','V1V2'},"VariableNames",{'Logical Output', 'p-value'});

% compare the z-scores of a specific brain between ref z-scored to exp and
% exp z-scored to exp
for l=1:z_exp2ref_r
    [h,p2,ci,stats] = ttest2(z_exp2ref(l,:),z_ref(l,:),"Vartype","unequal","Tail","both");
    ttest_of_zscores(l,1) = h; ttest_of_zscores(l,2) = p2;
end
t2 = array2table(ttest_of_zscores,"RowNames",{'AI','AuDMV','CPu','Cg','CC','DLO','DLIVEnt','DI','ECT','Fornix','FrA','HIP','LO','MO','PtPR','PtA','PRH','PrL','M1','S1','RSC','M2','S2','TeA','TH','VO','V1V2'},"VariableNames",{'Logical Output', 'p-value'});

save('preprocessed.mat',"z_exp","z_exp_mean","z_ref","z_ref_mean","z_exp2ref","z_exp2ref_mean","z_exp2ref_SEM","t1","t2","p1","p2","ttest_of_zscores","ttest_dir_comp")

end