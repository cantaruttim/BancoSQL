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

#print(existe(Usuario('matheus', 'admin')))

# definição da função menu



def menu():
    texto = "0-Fechar Sistema\n1-Login\n2-Logoff\n"
    # usuário ainda não existe
    usuario = None
    # capturamos a opção do usuário
    op = int(input(texto))

    while op != 0:

        if op == 1:
            login = input("Digite seu login\n")
            senha = input("Digite sua senha\n")
            usuario = Usuario(login, senha)

            # cadastra um novo usuário no banco (está repetindo o valor)
            if op == 3:

                if not existe(usuario):
                    usuario = None

                    # conectando ao banco
                    # Abrindo um cursos
                    conn = psycopg2.connect("dbname=Aulas user=postgres password=123456")
                    cur = conn.cursor()
                    cur.execute("INSERT INTO tb_usuario (login, senha) VALUES (%s, %s)",
                                (f'{login}', f'{senha}'))

                    # faz um commit no banco
                    conn.commit()

                    # Fechando a comunicação
                    cur.close()
                    conn.close()

                    return print('Usuário cadastrado com sucesso')

            return print('Usuário já existe no banco')


        # se ele digitar 2, configuramos o usuario como "None" novamente
        elif op == 2:
            usuario = None
            print("Logoff realizado com sucesso")

            op = int(input(texto))

    else:
        # se digitar zero, dizemos adeus. Observe que esse else está associado ao while
        print("Até mais")


# chamamos a função menu
menu()