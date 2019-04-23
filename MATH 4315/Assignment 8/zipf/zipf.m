novel=fileread('novel.txt');
novel=splitlines(novel);
TF=(novel =="");
novel(TF)=[];
p=[".","?","!",",",";",":",'"'];
novel=replace(novel,p," ");
novel=strip(novel);

novelWords = strings(0);
for i = 1:length(novel)
   novelWords = [novelWords ; split(novel(i))];
end

novelWords=lower(novelWords);
[words,~,idx] = unique(novelWords);
numOccurrences = histcounts(idx,numel(words));
[rankOfOccurrences,rankIndex] = sort(numOccurrences,'descend');
wordsByFrequency = words(rankIndex);

loglog(rankOfOccurrences);
xlabel('Rank of word (most to least common)');
ylabel('Number of Occurrences');

numOccurrences = numOccurrences(rankIndex);
numOccurrences = numOccurrences';
numWords = length(novelWords);
T = table;
T.Words = wordsByFrequency;
T.NumOccurrences = numOccurrences;
T.PercentOfText = numOccurrences / numWords * 100.0;
T.CumulativePercentOfText = cumsum(numOccurrences) / numWords * 100.0;
T(1:10,:)