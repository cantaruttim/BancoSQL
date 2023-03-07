import psycopg
print(psycopg)

# Criando a classe usuário
class Usuario:
    def __init__(self, login, senha):
        self.login = login
        self.senha = senha

#verificando se o usuário existe
def existe(usuario):
    with psycopg.connect(
        host='localhost',
        port=5432,
        dbname='postgres',
        password='123456',
        user='postgres'
    ) as conexao:
        with conexao.cursor() as cursor:
            cursor.execute('SELECT * FROM tb_usuario WHERE login=%s AND senha=%s', 
            (f'{usuario.login}', f'{usuario.senha}'))

            result = cursor.fetchone()

    return result != None

# print(existe(Usuario('matheus', 'admin')))
        
#definição da função menu
def menu():
    texto="0-Fechar Sistema\n1-Login\n2-Logoff\n"    
    #usuário ainda não existe
    usuario = None
    #capturamos a opção do usuário
    op= int(input(texto))
            
    while op != 0:
        
        if op==1:
            login = input("Digite seu login\n")
            senha = input("Digite sua senha\n")
            usuario = Usuario(login,senha)
            print("Usuário OK!!!" if existe(usuario)
                                    else "Usuário OK!!!")
            
        #se ele digitar 2, configuramos o usuario como "None" novamente
            
        elif op == 2:
            usuario = None
            print("Logoff realizado com sucesso")
            
            op=int(input(texto))

    else:
        #se digitar zero, dizemos adeus. Observe que esse else está associado ao while
        print("Até mais")
#chamamos a função menu
menu()