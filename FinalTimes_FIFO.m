function [finaltime] = FinalTimes_FIFO( timeproces,totthreads,totmessages )
%totthreads;%numero de threads do pool
numtasks=size(timeproces,1);%quantidade de tarefas
finaltime=zeros(numtasks,totmessages);%tempos finais
j=1;% variavel auxiliar, apenas incrementa a coluna de 1 em 1
k=1;b=1;% variavel auxiliar, apenas incrementa a coluna de n em n
pool=zeros(totthreads,1);
delay=0;

for i=1: numtasks
    while  j<=totmessages

        while k<=totthreads
            if j<=totmessages
                finaltime(i,j)=timeproces(i)+delay;
            else
                break
            end
            
            if b<=totthreads
                pool(b)=finaltime(i,k);
            else
                for k=1:totthreads-1
                    pool(k)=pool(k+1);
                end
                pool(totthreads)=timeproces(i);
            end
            k=k+1;j=j+1;b=b+1;
        end
        delay=min(pool);
        if k>=totthreads
            k=1;
        end;
        i=i+1;
     end
    j=1;
end

