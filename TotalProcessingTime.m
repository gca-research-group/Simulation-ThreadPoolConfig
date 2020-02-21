function [ttp,attp] = TotalProcessingTime( finaltime,totmessages )
%finaltime=final time vetor
%totmessages=total messages
nt=size(finaltime,1);%number of tasks
ttp=zeros(1,totmessages);
sttp=0; % sum of total processing times
%attp=mean(ttp)

for i=1:totmessages
    ttp(1,i)=finaltime(nt,i);%total processing time
    sttp=sttp+ttp(1,i);
end
attp=sttp/totmessages;
end

