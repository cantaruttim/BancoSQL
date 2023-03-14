import psycopg
import psycopg2
from usuario import Usuario
#  print(psycopg)

# verificando se o usuário existe
def existe(usuario):
    with psycopg.connect(
            host='localhost',
            port=5432,
            dbname='Aulas',
            password='123456',
            user='postgres'
    ) as conexao:
        with conexao.cursor() as cursor:
            cursor.execute('SELECT * FROM tb_usuario WHERE login=%s AND senha=%s',
                           (f'{usuario.login}', f'{usuario.senha}'))

            result = cursor.fetchone()

    return result != None

# definição da função menu

def menu():
    texto = "0-Fechar Sistema\n1-Login\n2-Logoff\n3-Cadastrar Usuário\n"
    usuario = None
    op = int(input(texto))

    while op != 0:
        if op == 1:

            login = input("Digite seu login\n")
            senha = input("Digite sua senha\n")
            usuario = Usuario(login, senha)
            print("Usuário já existe. Usuário OK!!!" if existe(usuario) else "Usuário NOK!!!")

        elif op == 2:

            usuario = None
            print("Logoff realizado com sucesso")

        elif op == 3:

            login_cadastro = input("Digite o login a ser cadastrado\n")
            senha_cadastro = input("Digite a senha a ser cadastrada\n")
            usuario = Usuario(login_cadastro, senha_cadastro)
            print("Usuário já existe" if existe(usuario) else "Até Mais!")

            # Vamos estabelecer a conexão com o banco
            conn = psycopg2.connect("dbname=Aulas user=postgres password=123456")
            cur = conn.cursor()

            while not existe(usuario):

                cur.execute("INSERT INTO tb_usuario (login, senha) VALUES (%s, %s) ",
                            (f'{login_cadastro}', f'{senha_cadastro}'))

                # fazendo um commit no banco
                conn.commit()
                print('Usuário cadastrado com sucesso')

            #fechando a conexão
            cur.close()
            conn.close()

        op = int(input(texto))

    else:
        print("Até Mais!")

menu()
