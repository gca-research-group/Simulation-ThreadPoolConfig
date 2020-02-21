
numsolutions = 10;
timeprocessing = [2.005; 1.003; 1.553; 1.005; 4.005; 1.004; 1.005; 1.553; 2.005; 1.005; 1.003; 1.005; 1.005; 1.003; 1.005; 1.005];
;
% totthreads = 3;até 10;
totmessages = 100;
%menor tempo total médio de processamento
MinTTP_Otimo=0;
TTAP_Fifo=0;
numpool = size(timeprocessing,1);%number of tasks
BestConf=zeros(numpool,1);%melhor configuração de pools de threads
TTAP=zeros(numsolutions,1);% tempo total de processamento
TFP=zeros(numpool,totmessages);%tempos finais
Results_TTAP=zeros(8,3);
Results_BestConf =zeros(8,4);

%inicializando o menor tempo total médio de processamento
for i=1:numpool
    MinTTP_Otimo=MinTTP_Otimo + totmessages * timeprocessing(i);
end

for k=1:8
    totthreads=k+2;
    %Gera populacao de solucoes
    PoolConf = Population( numsolutions,numpool,totthreads );
    
    %Calcula tempo total medio de processamento
    for i=1:numsolutions
        %Seleciona uma solução
        poolconfig=PoolConf(i,:);
        %Calcula tempo total medio de processamento
        TFP = FinalTimes_OTIMO( timeprocessing,poolconfig,totmessages );
        [TTP,TTAP(i,1)] = TotalProcessingTime(TFP,totmessages);
        %Testa se tempo total medio de processamento da solucao e menor que o
        %minimo
        if TTAP(i,1)<MinTTP_Otimo
            MinTTP_Otimo=TTAP(i,1);
            BestConf=PoolConf(i,:);
        end
    end
    Results_TTAP(k,1)=totthreads;
    Results_TTAP(k,2)=MinTTP_Otimo;
    Results_BestConf(k,1)=totthreads;
    for j=1:numpool
        Results_BestConf(k,j+1)=BestConf(1,j);
    end    
    
    %Para FIFO
    [finaltime] = FinalTimes_FIFO( timeprocessing,totthreads,totmessages )
    [TTP,TTAP_Fifo] = TotalProcessingTime(finaltime,totmessages);
    Results_TTAP(k,3)=TTAP_Fifo;
     

end
%Apresenta o menor tempo total medio de processamento do conjunto de solucoes 
Results_TTAP;
%Apresenta a configuracao de threads que gera o menor tempo total medio de processamento do conjunto de solucoes 
Results_BestConf;
