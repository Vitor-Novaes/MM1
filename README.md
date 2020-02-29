
## Threads e Queues em ruby MM/1

### Execução

- Ruby version: <= 2.5

- No diretório da pasta MM1, execute :
	`$ bundle install` => Instalar dependências
	`$ ruby main.rb`     => Iniciar execução
	`...Espere até que o programa finalize por completo para gerar o XLSX`
	
> Ao finalizar  será gerado relatório em xlsx com os devidos valores organizados em planilha assim como um resumo das threads em execução na saída do terminal 
> (Diretório raiz do programa **report.xlsx**)

### Mudar parâmetros de execução
- Número de pessoas na fila : `/main.rb` 
	`20.times.map`  => 20 pessoas
	
- Probabilidade do tempo de serviço e tempo entre chegadas: `/lib/helpers/sort_timer.rb`
	 ( 'Tempo' => probabilidade )
	 
      `$TIME_LAST_ARRIVAL_PROBABILITY = { '10' => 35, '12' => 40, '14' => 25 } # { number: probability }`
      `$TIME_OF_PROCESSING = { '9' => 30, '10' => 50, '11' => 20 } # { number: probability }`
	