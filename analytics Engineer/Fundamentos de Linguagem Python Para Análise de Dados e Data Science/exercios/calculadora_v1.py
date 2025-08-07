import os
import time

def calcular():
    while True:
        try:
            os.system("cls")
            print("******************* Calculadora em Python *******************")
            print("Esta é uma calculadora simples em Python.")
            print("Você pode realizar as seguintes operações:")
            print("1. Adição (+)")
            print("2. Subtração (-)")
            print("3. Multiplicação (*)")
            print("4. Divisão (/)")
            print("5. Exponenciação (**)")
            print("6. Módulo (%)")
            print("7. Divisão inteira (//)")
            print("8. Sair")
            print("\n******************* Calculadora em Python *******************")
            operacao = input("Digite a operação desejada (ou 'sair' para encerrar): ")
            operacao = int(operacao) if operacao.isdigit() else operacao.strip().lower()
            operacao1 = operacao
            if operacao == 8 or operacao == 'sair':
                print("Encerrando a calculadora. Até logo!")
                break
            
            num1 = float(input("Digite o primeiro número: "))
            num2 = float(input("Digite o segundo número: "))
            
            if operacao == 1 or operacao == '+':
                resultado = num1 + num2
            elif operacao == 2 or operacao == '-':
                resultado = num1 - num2
            elif operacao == 3 or operacao == '*':
                resultado = num1 * num2
            elif operacao == 4 or operacao == '/':
                if num2 == 0:
                    print("Erro: Divisão por zero não é permitida.")
                    continue
                resultado = num1 / num2
                
            elif operacao == 5 or operacao == '**':
                if num1 < 0 and num2 % 1 != 0:
                    print("Erro: Raiz de número negativo não é permitida.")
                    continue
                resultado = num1 ** num2
                
            elif operacao == 6 or operacao == '%':
                if num2 == 0:
                    print("Erro: Divisão por zero não é permitida.")
                    continue
                
                resultado = num1 % num2
            elif operacao == '//' or operacao == '7':
                if num2 == 0:
                    print("Erro: Divisão por zero não é permitida.")
                    continue
                resultado = num1 // num2
                            
            print(f"O resultado de {num1} {operacao1} {num2} é: {resultado}")
            time.sleep(3) 
        except ValueError:            
            print("Entrada inválida. Por favor, insira números válidos.")

        except Exception as e:
            print(f"Ocorreu um erro: {e}. Tente novamente.")       

calcular()