main:
	.text
	addi a0, zero, 16       # Adicionando ao registrador a0 o número desejado (ex.: 31)
	jal ra, paridade
	jal zero, exit			# Depois que terminar a função, sair do programa
paridade:
	addi t0, zero, 2		# Adicionando ao registrador t0 o divisor 2
	rem a0, a0, t0			# Adicionando ao registrador a0 (valor de retorno) o resto da divisão por 2
	jalr zero, 0(ra)
exit:
