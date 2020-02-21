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

% %Recebe entrada de dados
% prompt = {'Enter the number of thread pool configuration solutions to test:  ', ...
%           'Enter the total of threads in all pools:   ', ...
%           'Enter the total number of messages to process:   ', ...
%           'Enter the task processing time vector:  '};
% dlg_title = 'Input Parameters';
% num_lines = 1;
% defaultans = {'10','10','10','15;7;10'};
% answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
% 
% numsolutions = str2num(answer{1});
% totthreads = str2num(answer{2});
% totmessages = str2num(answer{3});
timeprocessing = str2num(answer{4});
% % 
numsolutions = 10;
totthreads = 100;
%totmessages = 1000;
timeprocessing = [2.005; 1.003; 1.553; 1.005; 4.005; 1.004; 1.005; 1.553; 2.005; 1.005; 1.003; 1.005; 1.005; 1.003; 1.005; 1.005];

numpool = size(timeprocessing,1);%number of tasks
BestConf=zeros(numpool,1);%melhor configuração de pools de threads
TFP=zeros(numpool,totmessages);%tempos finais
TTAP=zeros(numsolutions,1);% tempo total de processamento



%menor tempo total médio de processamento
MinTTP=0;
%inicializando o menor tempo total médio de processamento
for i=1:numpool
    MinTTP=MinTTP + totmessages * timeprocessing(i);
end    

%Gera populacao de solucoes
PoolConf = Population_Generation( numsolutions,numpool,totthreads );

%Calcula tempo total medio de processamento
for i=1:numsolutions
    %Seleciona uma solução
    poolconfig=PoolConf(i,:);
    %Calcula tempo total medio de processamento
    TFP = FinalTimes_OTIMO( timeprocessing,poolconfig,totmessages );
    [TTP,TTAP(i,1)] = TotalProcessingTime(TFP,totmessages);
    %Testa se tempo total medio de processamento da solucao e menor que o
    %minimo
    if TTAP(i,1)<MinTTP
        MinTTP=TTAP(i,1);
        BestConf=PoolConf(i,:);
    end
end
%Apresenta o menor tempo total medio de processamento do conjunto de solucoes 
str_MinTTP = num2str(MinTTP);
%Apresenta a configuracao de threads que gera o menor tempo total medio de processamento do conjunto de solucoes 
str_BestConf = num2str(BestConf);

%Apresenta o menor tempo total medio de processamento do conjunto de solucoes 
MinTTP/1000
%Apresenta a configuracao de threads que gera o menor tempo total medio de processamento do conjunto de solucoes 
BestConf;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%GRAFICO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% h=figure;
% set(gca,'XLim',[1, length(TFP)]);
% barh(TFP','hist');
% title('Message Processing Sequence');
% ylabel('mesages');
% xlabel('time');
% legend(strcat(num2str(timeprocessing),' time unit'),'Location', 'best');
% grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUTS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% d = dialog('Position',[300 300 250 150],'Name','Results','Resize','on');
%     txt = uicontrol('Parent',d,...
%            'Style','text',...
%            'Position',[20 80 210 40],...
%            'String',strcat('Minimum total average processing time: ',str_MinTTP));
%        
%      txt = uicontrol('Parent',d,...
%            'Style','text',...
%            'Position',[20 80 210 25],...
%            'String',strcat('Best configuration for thread pools: ',str_BestConf))
%        
%     btn = uicontrol('Parent',d,...
%            'Position',[89 20 70 25],...
%            'String','Close',...
%            'Callback','delete(gcf)');
%        
%     % Wait for d to close before running to completion
%     uiwait(d);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%IMPRIME%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choice  = questdlg('Would you like to print?','Priting...','yes','no','no');
% % Handle response
% switch choice
%     case 'yes'
%     printdlg;
% end
