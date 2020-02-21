%Determina a melhor configuração de pools de threads para obter o menor
%tempo total médio de processamento de um conjunto de mensagens, MinTTP.
%A melhor configuração de pools de threads é um vetor, BestConf, onde cada elemento é
%o número de threads para um pool e o índice da coluna desse vetor
%determina para qual tarefa esse pool de threads estará dedicado.
%O tempo total médio de processamento de um conjunto de
%mensagens é obtido pela média do tempos de processamento total de cada
%mensagem.
%O tempo de processamento total que cada mensagem é obtido pelo cálculo do
%tempo final de processamento por todas as tarefas do processo de
%integração.
tic
% %Recebe entrada de dados
% prompt = {'Enter the number of thread pool configuration solutions to test:  ', ...
%           'Enter the total of threads in all pools:   ', ...
%           'Enter the total number of messages to process:   ', ...
%           'Enter the task processing time(ms) vector:  '};
% dlg_title = 'Input Parameters';
% num_lines = 1;
% defaultans = {'20','50','40000','2.531;1.303;4.005;1.005;1.003;4.005;1.005;1.531;1.003;1.001'};
% answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
% 
% numsolutions = str2num(answer{1});
% totthreads = str2num(answer{2});
% totmessages = str2num(answer{3});
% timeprocessing = str2num(answer{4});
% 
numsolutions = 10;
totthreads = 10;
totmessages = 10;
% timeprocessing = [2.005; 1.003; 1.553; 1.005; 4.005; 1.004; 1.005; 1.553; 2.005; 1.005; 1.003; 1.005; 1.005; 1.003; 1.005; 1.005];
 timeprocessing = [1;3;5];

numpools = size(timeprocessing,1);%number of tasks
BestConf=zeros(numpools,1);%melhor configuração de pools de threads
TFP=zeros(numpools,totmessages);%tempos finais
TTAP=zeros(numsolutions,1);% tempo total de processamento

%menor tempo total médio de processamento
MinTTP=0;
%inicializando o menor tempo total médio de processamento
for i=1:numpools
    MinTTP=MinTTP + totmessages * timeprocessing(i);
end    

%Gera populacao de solucoes
PoolConf = Population_Generation( numsolutions,numpools,totthreads );


%Calcula tempo total medio de processamento
for i=1:numsolutions
    %Seleciona uma solução
    poolconfig=PoolConf(i,:);
    %Calcula tempo total medio de processamento
   [TTAP(i,1)] =  ATTP_Calculation(timeprocessing,poolconfig,totmessages );
    %Testa se tempo total medio de processamento da solucao e menor que o
    %minimo
    if TTAP(i,1)<MinTTP
        MinTTP=TTAP(i,1);
        BestConf=PoolConf(i,:);
    end
end
%Apresenta o menor tempo total medio de processamento do conjunto de solucoes 
MinTTP/1000
%Apresenta a configuracao de threads que gera o menor tempo total medio de processamento do conjunto de solucoes 
BestConf
toc