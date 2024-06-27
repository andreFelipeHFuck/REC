#!/bin/bash

TECNICA=""
IP_SERVIDOR=""
LARGURA_BANDA=""
DURACAO_TESTE=60
PROTOCOLO=""
INTERFACE="eth0"
OUTPUT_FILE=""


cd ../dump/$TECNICA

ls 

for i in {1..20}
do
	echo "Execução $i de 20"

	DUMP_FILE="dump_$i.pcap"

	echo $DUMP_FILE

	touch $DUMP_FILE

	tshark -i $INTERFACE -w $DUMP_FILE & TSHARK_PID=$!

	iperf -c $IP_SERVIDOR -b $LARGURA_BANDA -t $DURACAO_TESTE $PROTOCOLO -V >>$OUTPUT_FILE 

	kill $TSHARK_PID

	echo "Teste $i concluído, dump salvo em $DUMP_FILE"

	sleep 1

done 

cd ../../../scripts

echo "Todos os teste foram concluídos."

