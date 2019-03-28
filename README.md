
# Movies
Seja bem vindo ao repositório do projeto Movies, um caso de uso implementado contendo a versão para dispositivos móveis iOS. Veja instruções de como usar e também acompanhe os processos realizados neste aplicativo desenvolvido com o auxílio de ferramentas e tecnologias como Sketch, Xcode, Trello, Swift e outros.


- Protótipo 


![](https://media.giphy.com/media/8Z5MqfvHwTatWpxkJ1/giphy.gif) 

- App em execução


![](https://media.giphy.com/media/kPuEqXbqAAi6s4OPGU/giphy.gif) 

## Como executar o projeto 
Você só precisa realizar o clone do projeto em sua máquina e depois executar o pod install. O arquivo de configuração Keys foi versionado devido a questões de cunho educacional. 

Vale ressaltar que, não deve-se adicionar chaves secretas no código fonte do projeto ou em repositórios remotos, ou seja, é uma chave individual dos envolvidos no projeto, atendendo requisitos de segurança. 


## Estrutura de arquivos do projeto
````
root
+--Movies // 
     Fonts // 
|
     Utils // 
|       Results // 
|       K // 
|       UIView+Inspectable // 
|
    Request // 
|        Requester // 
|        MovieFetcher // 
|        TheMovieDataBaseFetcher // 
|        RequesterDelegate // 
|
     Coordinator // 
|        Display // 
|        Coordinable // 
|        Coordinator // 
|        MoviesCoordinator // 
|
     DisplayMovies // 
|        Model // 
|           Movie // 
|        Storyboards // 
|           Cells//
|               MovieCell//
|               GenreCell//
|        Controllers // 
|            MovieDetailsViewController//
|            UIViewController+PresentError//
|            MoviesViewController//
|    ...// Pods, plist and tests    
````

## Frameworks aplicadas no projeto

**Hero** - Biblioteca para criar transições de visualização em iOS. 

**Alamofire** - Biblioteca que atua na camada de rede usando a linguagem swift.


## Experiência com o projeto 

    # Com este projeto aprimorei a qualidade técnica e o conhecimento ao se trabalhar com requisições e boas 
      práticas baseadas em conceitos altamente importantes no desenvolvimento de software.
    
    - Single Responsibility Principle para separar atividades diferentes em diferentes partes do código, para
      que no futuro se houver alterações ou incrementos em lugares específicos, mantenha-se a redução nos
      custos de épicos relacionados a bugs no código.

    - Criação de um 'Fetcher', que é a abstração da requisição e a obtenção dos dados. 

    - Conhecimento adquirido em 'Separation of concern design principles', que parte da organização lógica
      dos arquivos e pastas do projeto.

    - Criação de um Arquivo de constantes com valores parametrizados em prol de realizar 
      alterações propagáveis, aumentando assim a manutenibilidade.

    - Testes unitários que permeiam o controle de qualidade, assegurando que o software está contemplando
      todas as funcionalidades esperadas, no caso deste projeto a requisição.

    - Gerenciamento de memória, através da manipulação de memória cache, aumentando a performance
      da aplicação em uso.

    - Documentação em código e utilização do Jazzy para gerar um arquivo index.html, onde é possível
      analisar a cobertura de código do projeto de forma visual e interativa. 
    
  
    
- Neste projeto foi utilizado Coordinator, que permite desacoplar o fluxo lógico do projeto, agregando valor na escalabilidade de novas telas.

- O Factory foi usado com a intenção de desacoplar a instanciação da classe de atualização dos dados de Movies.
	
- Singleton, Delegate entre outros padrões também foram utilizados.

## Futuro

Os planos para este projeto são:

- [ ] Criação de uma Launch Screen customizada
        
      Em prol de aprimorar o conhecimento em customizar animações. 

- [ ] Criação de um UserOnboarding 

      Facilitar a informação para o melhor entendimento e usabilidade do aplicativo.

- [ ] Criação de um Banco de Dados 

      Proposta de aplicação prática em torno do conhecimento adquirido até o momento. 
    
    
    
     
    - Cobertura de código de 65%
    
    ![](https://media.giphy.com/media/tZDz2o12cwKYl8ZFHW/giphy.gif)          

    - Kanban 
    
    ![](https://media.giphy.com/media/8UHSrOmENxnwIgb8T9/giphy.gif)
    

### Autor

- [Arthur de Castro](https://github.com/arthurfjadecastro)

