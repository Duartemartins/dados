require 'fuzzy_match'
require 'CSV'

mai_records = %(
    Aguada de Cima
    Águeda e Borralha
    Barrô e Aguada de Baixo
    Belazaima do Chão, Castanheira do Vouga e Agadão
    Fermentelos
    Macinhata do Vouga
    Préstimo e Macieira de Alcoba
    Recardães e Espinhel
    Travassô e Óis da Ribeira
    Trofa, Segadães e Lamas do Vouga
    Valongo do Vouga
    Albergaria-a-Velha e Valmaior
    Alquerubim
    Angeja
    Branca
    Ribeira de Fráguas
    São João de Loure e Frossos
    Amoreira da Gândara, Paredes do Bairro e Ancas
    Arcos e Mogofores
    Avelãs de Caminho
    Avelãs de Cima
    Moita
    Sangalhos
    São Lourenço do Bairro
    Tamengos, Aguim e Óis do Bairro
    Vila Nova de Monsarros
    Vilarinho do Bairro
    Alvarenga
    Arouca e Burgo
    Cabreiros e Albergaria da Serra
    Canelas e Espiunca
    Chave
    Covelo de Paivó e Janarde
    Escariz
    Fermedo
    Mansores
    Moldes
    Rossas
    Santa Eulália
    São Miguel do Mato
    Tropeço
    Urrô
    Várzea
    Aradas
    Cacia
    Eixo e Eirol
    Esgueira
    Glória e Vera Cruz
    Oliveirinha
    Requeixo, Nossa Senhora de Fátima e Nariz
    Santa Joana
    São Bernardo
    São Jacinto
    Fornos
    Raiva, Pedorido e Paraíso
    Real
    Santa Maria de Sardoura
    São Martinho de Sardoura
    Sobrado e Bairros
    Anta e Guetim
    Espinho
    Paramos
    Silvalde
    Avanca
    Beduído e Veiros
    Canelas e Fermelã
    Pardilhó
    Salreu
    Argoncilhe
    Arrifana
    Caldas de São Jorge e Pigeiros
    Canedo, Vale e Vila Maior
    Escapães
    Fiães
    Fornos
    Lobão, Gião, Louredo e Guisande
    Lourosa
    Milheirós de Poiares
    Mozelos
    Nogueira da Regedoura
    Paços de Brandão
    Rio Meão
    Romariz
    Sanguedo
    Santa Maria da Feira, Travanca, Sanfins e Espargo
    Santa Maria de Lamas
    São João de Ver
    São Miguel de Souto e Mosteirô
    São Paio de Oleiros
    Gafanha da Encarnação
    Gafanha da Nazaré
    Gafanha do Carmo
    Ílhavo (São Salvador)
    Barcouço
    Casal Comba
    Luso
    Mealhada, Ventosa do Bairro e Antes
    Pampilhosa
    Vacariça
    Bunheiro
    Monte
    Murtosa
    Torreira
    Carregosa
    Cesar
    Fajões
    Loureiro
    Macieira de Sarnes
    Nogueira do Cravo e Pindelo
    O. Azeméis, Riba-Ul, Ul, Macinhata Seixa, Madail
    Ossela
    Pinheiro da Bemposta, Travanca e Palmaz
    São Martinho da Gândara
    São Roque
    Vila de Cucujães
    Bustos, Troviscal e Mamarrosa
    Oiã
    Oliveira do Bairro
    Palhaça
    Cortegaça
    Esmoriz
    Maceda
    Ovar, S.João, Arada e S.Vicente de Pereira Jusã
    Válega
    São João da Madeira
    Cedrim e Paradela
    Couto de Esteves
    Pessegueiro do Vouga
    Rocas do Vouga
    Sever do Vouga
    Silva Escura e Dornelas
    Talhadas
    Calvão
    Fonte de Angeão e Covão do Lobo
    Gafanha da Boa Hora
    Ouca
    Ponte de Vagos e Santa Catarina
    Santo André de Vagos
    Sosa
    Vagos e Santo António
    Arões
    Cepelos
    Junqueira
    Macieira de Cambra
    Roge
    São Pedro de Castelões
    Vila Chã, Codal e Vila Cova de Perrinho
    Aljustrel e Rio de Moinhos
    Ervidel
    Messejana
    São João de Negrilhos
    Aldeia dos Fernandes
    Almodôvar e Graça dos Padrões
    Rosário
    Santa Clara-a-Nova e Gomes Aires
    Santa Cruz
    São Barnabé
    Alvito
    Vila Nova da Baronia
    Barrancos
    Albernoa e Trindade
    Baleizão
    Beja (Salvador e Santa Maria da Feira)
    Beja (Santiago Maior e São João Baptista)
    Beringel
    Cabeça Gorda
    Nossa Senhora das Neves
    Salvada e Quintos
    Santa Clara de Louredo
    Santa Vitória e Mombeja
    São Matias
    Trigaches e São Brissos
    Castro Verde e Casével
    Entradas
    Santa Bárbara de Padrões
    São Marcos da Ataboeira
    Cuba
    Faro do Alentejo
    Vila Alva
    Vila Ruiva
    Alfundão e Peroguarda
    Ferreira do Alentejo e Canhestros
    Figueira dos Cavaleiros
    Odivelas
    Alcaria Ruiva
    Corte do Pinto
    Espírito Santo
    Mértola
    S.Mig. Pinheiro, S.Pedro Solis, S.Sebastião Carros
    Santana de Cambas
    São João dos Caldeireiros
    Amareleja
    Póvoa de São Miguel
    Safara e Santo Aleixo da Restauração
    Santo Agostinho e São João Baptista e Santo Amador
    Sobral da Adiça
    Boavista dos Pinheiros
    Colos
    Longueira/Almograve
    Luzianes-Gare
    Relíquias
    Sabóia
    Santa Clara-a-Velha
    São Luís
    São Martinho das Amoreiras
    São Salvador e Santa Maria
    São Teotónio
    Vale de Santiago
    Vila Nova de Milfontes
    Garvão e Santa Luzia
    Ourique
    Panoias e Conceição
    Santana da Serra
    Brinches
    Pias
    Serpa (Salvador e Santa Maria)
    Vila Nova de São Bento e Vale de Vargo
    Vila Verde de Ficalho
    Pedrógão
    Selmes
    Vidigueira
    Vila de Frades
    Amares e Figueiredo
    Barreiros
    Bico
    Bouro (Santa Maria)
    Bouro (Santa Marta)
    Caires
    Caldelas, Sequeiros e Paranhos
    Carrazedo
    Dornelas
    Ferreiros, Prozelo e Besteiros
    Fiscal
    Goães
    Lago
    Rendufe
    Torre e Portela
    Vilela, Seramil e Paredes Secas
    Abade de Neiva
    Aborim
    Adães
    Airó
    Aldreu
    Alheira e Igreja Nova
    Alvelos
    Alvito (São Pedro e São Martinho) e Couto
    Arcozelo
    Areias
    Areias de Vilar e Encourados
    Balugães
    Barcelinhos
    Barcelos, Vila Boa e Vila Frescainha
    Barqueiros
    Cambeses
    Campo e Tamel (São Pedro Fins)
    Carapeços
    Carreira e Fonte Coberta
    Carvalhal
    Carvalhas
    Chorente, Góios, Courel, Pedra Furada e Gueral
    Cossourado
    Creixomil e Mariz
    Cristelo
    Durrães e Tregosa
    Fornelos
    Fragoso
    Galegos (Santa Maria)
    Galegos (São Martinho)
    Gamil e Midões
    Gilmonde
    Lama
    Lijó
    Macieira de Rates
    Manhente
    Martim
    Milhazes, Vilar de Figos e Faria
    Moure
    Negreiros e Chavão
    Oliveira
    Palme
    Panque
    Paradela
    Pereira
    Perelhal
    Pousa
    Quintiães e Aguiar
    Remelhe
    Rio Covo (Santa Eugénia)
    Roriz
    Sequeade e Bastuço (São João e Santo Estevão)
    Silva
    Silveiros e Rio Covo (Santa Eulália)
    Tamel (Santa Leocádia) e Vilar do Monte
    Tamel (São Veríssimo)
    Ucha
    Várzea
    Viatodos, Grimancelos, Minhotães, Monte de Fralães
    Vila Cova e Feitos
    Vila Seca
    Adaúfe
    Arentim e Cunha
    Braga (Maximinos, Sé e Cividade)
    Braga (São José de São Lázaro e São João do Souto)
    Braga (São Vicente)
    Braga (São Vítor)
    Cabreiros e Passos (São Julião)
    Celeirós, Aveleda e Vimieiro
    Crespos e Pousada
    Escudeiros e Penso (Santo Estêvão e São Vicente)
    Espinho
    Esporões
    Este (São Pedro e São Mamede)
    Ferreiros e Gondizalves
    Figueiredo
    Gualtar
    Guisande e Oliveira (São Pedro)
    Lamas
    Lomar e Arcos
    Merelim (São Paio), Panoias e Parada de Tibães
    Merelim (São Pedro) e Frossos
    Mire de Tibães
    Morreira e Trandeiras
    Nogueira, Fraião e Lamaçães
    Nogueiró e Tenões
    Padim da Graça
    Palmeira
    Pedralva
    Priscos
    Real, Dume e Semelhe
    Ruilhe
    Santa Lucrécia de Algeriz e Navarra
    Sequeira
    Sobreposta
    Tadim
    Tebosa
    Vilaça e Fradelos
    Abadim
    Alvite e Passos
    Arco de Baúlhe e Vila Nune
    Basto
    Bucos
    Cabeceiras de Basto
    Cavez
    Faia
    Gondiães e Vilar de Cunhas
    Pedraça
    Refojos de Basto, Outeiro e Painzela
    Rio Douro
    Agilde
    Arnóia
    Basto (São Clemente)
    Borba de Montanha
    Britelo, Gémeos e Ourilhe
    Caçarilhe e Infesta
    Canedo de Basto e Corgo
    Carvalho e Basto (Santa Tecla)
    Codeçoso
    Fervença
    Moreira do Castelo
    Rego
    Ribas
    Vale de Bouro
    Veade, Gagos e Molares
    Antas
    Apúlia e Fão
    Belinho e Mar
    Esposende, Marinhas e Gandra
    Fonte Boa e Rio Tinto
    Forjães
    Gemeses
    Palmeira de Faro e Curvos
    Vila Chã
    Aboim, Felgueiras, Gontim e Pedraído
    Agrela e Serafão
    Antime e Silvares (São Clemente)
    Ardegão, Arnozela e Seidões
    Armil
    Arões (Santa Cristina)
    Arões (São Romão)
    Cepães e Fareja
    Estorãos
    Fafe
    Fornelos
    Freitas e Vila Cova
    Golães
    Medelo
    Monte e Queimadela
    Moreira do Rei e Várzea Cova
    Paços
    Quinchães
    Regadas
    Revelhe
    Ribeiros
    São Gens
    Silvares (São Martinho)
    Travassós
    Vinhós
    Abação e Gémeos
    Airão Santa Maria, Airão São João e Vermil
    Aldão
    Arosa e Castelões
    Atães e Rendufe
    Azurém
    Barco
    Briteiros Santo Estêvão e Donim
    Briteiros São Salvador e Briteiros Santa Leocádia
    Brito
    Caldelas
    Candoso (São Martinho)
    Candoso São Tiago e Mascotelos
    Conde e Gandarela
    Costa
    Creixomil
    Fermentões
    Gonça
    Gondar
    Guardizela
    Infantas
    Leitões, Oleiros e Figueiredo
    Longos
    Lordelo
    Mesão Frio
    Moreira de Cónegos
    Nespereira
    Oliveira, São Paio e São Sebastião
    Pencelo
    Pinheiro
    Polvoreira
    Ponte
    Prazins (Santa Eufémia)
    Prazins Santo Tirso e Corvite
    Ronfe
    Sande (São Martinho)
    Sande São Lourenço e Balazar
    Sande Vila Nova e Sande São Clemente
    São Torcato
    Selho (São Cristóvão)
    Selho (São Jorge)
    Selho São Lourenço e Gominhães
    Serzedelo
    Serzedo e Calvos
    Silvares
    Souto Santa Maria, Souto São Salvador e Gondomar
    Tabuadelo e São Faustino
    Urgezes
    Águas Santas e Moure
    Calvos e Frades
    Campos e Louredo
    Covelas
    Esperança e Brunhais
    Ferreiros
    Fonte Arcada e Oliveira
    Galegos
    Garfe
    Geraz do Minho
    Lanhoso
    Monsul
    Póvoa de Lanhoso (Nossa Senhora do Amparo)
    Rendufinho
    Santo Emilião
    São João de Rei
    Serzedelo
    Sobradelo da Goma
    Taíde
    Travassos
    Verim, Friande e Ajude
    Vilela
    Balança
    Campo do Gerês
    Carvalheira
    Chamoim e Vilar
    Chorense e Monte
    Cibões e Brufe
    Covide
    Gondoriz
    Moimenta
    Ribeira
    Rio Caldo
    Souto
    Valdosende
    Vilar da Veiga
    Anissó e Soutelo
    Anjos e Vilar do Chão
    Caniçada e Soengas
    Cantelães
    Eira Vedra
    Guilhofrei
    Louredo
    Mosteiro
    Parada de Bouro
    Pinheiro
    Rossas
    Ruivães e Campos
    Salamonde
    Tabuaças
    Ventosa e Cova
    Vieira do Minho
    Antas e Abade de Vermoim
    Arnoso (Santa Maria e Santa Eulália) e Sezures
    Avidos e Lagoa
    Bairro
    Brufe
    Carreira e Bente
    Castelões
    Cruz
    Delães
    Esmeriz e Cabeçudos
    Fradelos
    Gavião
    Gondifelos, Cavalões e Outiz
    Joane
    Landim
    Lemenhe, Mouquim e Jesufrei
    Louro
    Lousado
    Mogege
    Nine
    Oliveira (Santa Maria)
    Oliveira (São Mateus)
    Pedome
    Pousada de Saramagos
    Requião
    Riba de Ave
    Ribeirão
    Ruivães e Novais
    Seide
    Vale (São Cosme), Telhado e Portela
    Vale (São Martinho)
    Vermoim
    Vila Nova de Famalicão e Calendário
    Vilarinho das Cambas
    Aboim da Nóbrega e Gondomar
    Atiães
    Cabanelas
    Carreiras (São Miguel) e Carreiras (Santiago)
    Cervães
    Coucieiro
    Dossãos
    Escariz (São Mamede) e Escariz (São Martinho)
    Esqueiros, Nevogilde e Travassós
    Freiriz
    Gême
    Lage
    Lanhas
    Loureira
    Marrancos e Arcozelo
    Moure
    Oleiros
    Oriz (Santa Marinha) e Oriz (São Miguel)
    Parada de Gatim
    Pico
    Pico de Regalados, Gondiães e Mós
    Ponte
    Prado (São Miguel)
    Ribeira do Neiva
    Sabariz
    Sande, Vilarinho, Barros e Gomide
    Soutelo
    Turiz
    Vade
    Valbom (São Pedro), Passô e Valbom (São Martinho)
    Valdreu
    Vila de Prado
    Vila Verde e Barbudo
    Caldas de Vizela (São Miguel e São João)
    Infias
    Santa Eulália
    Tagilde e Vizela (São Paio)
    Vizela (Santo Adrião)
    Agrobom, Saldonha e Vale Pereiro
    Alfândega da Fé
    Cerejais
    Eucisia, Gouveia e Valverde
    Ferradosa e Sendim da Serra
    Gebelim e Soeima
    Parada e Sendim da Ribeira
    Pombal e Vales
    Sambade
    Vilar Chão
    Vilarelhos
    Vilares de Vilariça
    Alfaião
    Aveleda e Rio de Onor
    Babe
    Baçal
    Carragosa
    Castrelos e Carrazedo
    Castro de Avelãs
    Coelhoso
    Donai
    Espinhosela
    França
    Gimonde
    Gondesende
    Gostei
    Grijó de Parada
    Izeda, Calvelhe e Paradinha Nova
    Macedo do Mato
    Mós
    Nogueira
    Outeiro
    Parada e Faílde
    Parâmio
    Pinela
    Quintanilha
    Quintela de Lampaças
    Rabal
    Rebordainhos e Pombares
    Rebordãos
    Rio Frio e Milhão
    Salsas
    Samil
    Santa Comba de Rossas
    São Julião de Palácios e Deilão
    São Pedro de Sarracenos
    Sé, Santa Maria e Meixedo
    Sendas
    Serapicos
    Sortes
    Zoio
    Amedo e Zedes
    Belver e Mogo de Malta
    Carrazeda de Ansiães
    Castanheiro do Norte e Ribalonga
    Fonte Longa
    Lavandeira, Beira Grande e Selores
    Linhares
    Marzagão
    Parambos
    Pereiros
    Pinhal do Norte
    Pombal
    Seixo de Ansiães
    Vilarinho da Castanheira
    Freixo de Espada à Cinta e Mazouco
    Lagoaça e Fornos
    Ligares
    Poiares
    Ala e Vilarinho do Monte
    Amendoeira
    Arcas
    Bornes e Burga
    Carrapatas
    Castelãos e Vilar do Monte
    Chacim
    Cortiços
    Corujas
    Espadanedo, Edroso, Murçós e Soutelo Mourisco
    Ferreira
    Grijó
    Lagoa
    Lamalonga
    Lamas
    Lombo
    Macedo de Cavaleiros
    Morais
    Olmos
    Peredo
    Podence e Santa Combinha
    Salselas
    Sezulfe
    Talhas
    Talhinhas e Bagueixe
    Vale Benfeito
    Vale da Porca
    Vale de Prados
    Vilarinho de Agrochão
    Vinhas
    Constantim e Cicouro
    Duas Igrejas
    Genísio
    Ifanes e Paradela
    Malhadas
    Miranda do Douro
    Palaçoulo
    Picote
    Póvoa
    São Martinho de Angueira
    Sendim e Atenor
    Silva e Águas Vivas
    Vila Chã de Braciosa
    Abambres
    Abreiro
    Aguieiras
    Alvites
    Avantos e Romeu
    Avidagos, Navalho e Pereira
    Barcel, Marmelos e Valverde da Gestosa
    Bouça
    Cabanelas
    Caravelas
    Carvalhais
    Cedães
    Cobro
    Fradizela
    Franco e Vila Boa
    Frechas
    Freixeda e Vila Verde
    Lamas de Orelhão
    Mascarenhas
    Mirandela
    Múrias
    Passos
    São Pedro Velho
    São Salvador
    Suçães
    Torre de Dona Chama
    Vale de Asnes
    Vale de Gouvinhas
    Vale de Salgueiro
    Vale de Telhas
    Azinhoso
    Bemposta
    Bruçó
    Brunhoso
    Brunhozinho, Castanheira e Sanhoane
    Castelo Branco
    Castro Vicente
    Meirinhos
    Mogadouro, Valverde, Vale de Porco e Vilar de Rei
    Paradela
    Penas Roias
    Peredo da Bemposta
    Remondes e Soutelo
    Saldanha
    São Martinho do Peso
    Tó
    Travanca
    Urrós
    Vale da Madre
    Vila de Ala
    Vilarinho dos Galegos e Ventozelo
    Açoreira
    Adeganha e Cardanha
    Cabeça Boa
    Carviçais
    Castedo
    Felgar e Souto da Velha
    Felgueiras e Maçores
    Horta da Vilariça
    Larinho
    Lousa
    Mós
    Torre de Moncorvo
    Urros e Peredo dos Castelhanos
    Assares e Lodões
    Benlhevai
    Candoso e Carvalho de Egas
    Freixiel
    Roios
    Samões
    Sampaio
    Santa Comba de Vilariça
    Seixo de Manhoses
    Trindade
    Vale Frechoso
    Valtorno e Mourão
    Vila Flor e Nabo
    Vilas Boas e Vilarinho das Azenhas
    Algoso, Campo de Víboras e Uva
    Argozelo
    Caçarelhos e Angueira
    Carção
    Matela
    Pinelo
    Santulhão
    Vale de Frades e Avelanoso
    Vilar Seco
    Vimioso
    Agrochão
    Candedo
    Celas
    Curopos e Vale de Janeiro
    Edral
    Edrosa
    Ervedosa
    Moimenta e Montouto
    Nunes e Ousilhão
    Paçó
    Penhas Juntas
    Quirás e Pinheiro Novo
    Rebordelo
    Santalha
    Sobreiro de Baixo e Alvaredos
    Soeira, Fresulfe e Mofreita
    Travanca e Santa Cruz
    Tuizelo
    Vale das Fontes
    Vila Boa de Ousilhão
    Vila Verde
    Vilar de Lomba e São Jomil
    Vilar de Ossos
    Vilar de Peregrinos
    Vilar Seco de Lomba
    Vinhais
    Belmonte e Colmeal da Torre
    Caria
    Inguias
    Maçainhas
    Alcains
    Almaceda
    Benquerenças
    Castelo Branco
    Cebolais de Cima e Retaxo
    Escalos de Baixo e Mata
    Escalos de Cima e Lousa
    Freixial e Juncal do Campo
    Lardosa
    Louriçal do Campo
    Malpica do Tejo
    Monforte da Beira
    Ninho do Açor e Sobral do Campo
    Póvoa de Rio de Moinhos e Cafede
    Salgueiro do Campo
    Santo André das Tojeiras
    São Vicente da Beira
    Sarzedas
    Tinalhas
    Aldeia de São Francisco de Assis
    Barco e Coutada
    Boidobra
    Cantar-Galo e Vila do Carvalho
    Casegas e Ourondo
    Cortes do Meio
    Covilhã e Canhoso
    Dominguizo
    Erada
    Ferro
    Orjais
    Paul
    Peraboa
    Peso e Vales do Rio
    São Jorge da Beira
    Sobral de São Miguel
    Teixoso e Sarzedo
    Tortosendo
    Unhais da Serra
    Vale Formoso e Aldeia do Souto
    Verdelhos
    Alcaide
    Alcaria
    Alcongosta
    Alpedrinha
    Barroca
    Bogas de Cima
    Capinha
    Castelejo
    Castelo Novo
    Enxames
    Fatela
    Fundão, Valverde, Donas e Aldeias de Joanes e Cabo
    Janeiro de Cima e Bogas de Baixo
    Lavacolhos
    Orca
    Pêro Viseu
    Póvoa de Atalaia e Atalaia do Campo
    Silvares
    Soalheira
    Souto da Casa
    Telhado
    Três Povos
    Vale de Prazeres e Mata da Rainha
    Aldeia de Santa Margarida
    Idanha-a-Nova e Alcafozes
    Ladoeiro
    Medelim
    Monfortinho e Salvaterra do Extremo
    Monsanto e Idanha-a-Velha
    Oledo
    Penha Garcia
    Proença-a-Velha
    Rosmaninhal
    São Miguel de Acha
    Toulões
    Zebreira e Segura
    Álvaro
    Cambas
    Estreito-Vilar Barroco
    Isna
    Madeirã
    Mosteiro
    Oleiros-Amieira
    Orvalho
    Sarnadas de São Simão
    Sobral
    Aldeia do Bispo, Águas e Aldeia de João Pires
    Aranhas
    Benquerença
    Meimão
    Meimoa
    Pedrógão de São Pedro e Bemposta
    Penamacor
    Salvador
    Vale da Senhora da Póvoa
    Montes da Senhora
    Proença-a-Nova e Peral
    São Pedro do Esteval
    Sobreira Formosa e Alvito da Beira
    Cabeçudo
    Carvalhal
    Castelo
    Cernache do Bonjardim, Nesperal e Palhais
    Cumeada e Marmeleiro
    Ermida e Figueiredo
    Pedrógão Pequeno
    Sertã
    Troviscal
    Várzea dos Cavaleiros
    Fundada
    São João do Peso
    Vila de Rei
    Fratel
    Perais
    Sarnadas de Ródão
    Vila Velha de Ródão
    Arganil
    Benfeita
    Celavisa
    Cepos e Teixeira
    Cerdeira e Moura da Serra
    Côja e Barril de Alva
    Folques
    Piódão
    Pomares
    Pombeiro da Beira
    São Martinho da Cortiça
    Sarzedo
    Secarias
    Vila Cova de Alva e Anseriz
    Ançã
    Cadima
    Cantanhede e Pocariça
    Cordinhã
    Covões e Camarneira
    Febres
    Murtede
    Ourentã
    Portunhos e Outil
    Sanguinheira
    São Caetano
    Sepins e Bolho
    Tocha
    Vilamar e Corticeiro de Cima
    Almalaguês
    Antuzede e Vil de Matos
    Assafarge e Antanhol
    Brasfemes
    Ceira
    Cernache
    Eiras e São Paulo de Frades
    Santa Clara e Castelo Viegas
    Santo António dos Olivais
    São João do Campo
    São Martinho de Árvore e Lamarosa
    São Martinho do Bispo e Ribeira de Frades
    São Silvestre
    Sé Nova, Santa Cruz, Almedina e São Bartolomeu
    Souselas e Botão
    Taveiro, Ameal e Arzila
    Torres do Mondego
    Trouxemil e Torre de Vilela
    Anobra
    Condeixa-a-Velha e Condeixa-a-Nova
    Ega
    Furadouro
    Sebal e Belide
    Vila Seca e Bem da Fé
    Zambujal
    Alhadas
    Alqueidão
    Bom Sucesso
    Buarcos e São Julião
    Ferreira-a-Nova
    Lavos
    Maiorca
    Marinha das Ondas
    Moinhos da Gândara
    Paião
    Quiaios
    São Pedro
    Tavarede
    Vila Verde
    Alvares
    Cadafaz e Colmeal
    Góis
    Vila Nova do Ceira
    Foz de Arouce e Casal de Ermio
    Gândaras
    Lousã e Vilarinho
    Serpins
    Carapelhos
    Mira
    Praia de Mira
    Seixo
    Lamas
    Miranda do Corvo
    Semide e Rio Vide
    Vila Nova
    Abrunheira, Verride e Vila Nova da Barca
    Arazede
    Carapinheira
    Ereira
    Liceia
    Meãs do Campo
    Montemor-o-Velho e Gatões
    Pereira
    Santo Varão
    Seixo de Gatões
    Tentúgal
    Aldeia das Dez
    Alvoco das Várzeas
    Avô
    Bobadela
    Ervedal e Vila Franca da Beira
    Lagares
    Lagos da Beira e Lajeosa
    Lourosa
    Meruge
    Nogueira do Cravo
    Oliveira do Hospital e São Paio de Gramaços
    Penalva de Alva e São Sebastião da Feira
    Santa Ovaia e Vila Pouca da Beira
    São Gião
    Seixo da Beira
    Travanca de Lagos
    Cabril
    Dornelas do Zêzere
    Fajão-Vidual
    Janeiro de Baixo
    Pampilhosa da Serra
    Pessegueiro
    Portela do Fojo-Machio
    Unhais-o-Velho
    Carvalho
    Figueira de Lorvão
    Friúmes e Paradela
    Lorvão
    Oliveira do Mondego e Travanca do Mondego
    Penacova
    São Pedro de Alva e São Paio de Mondego
    Sazes do Lorvão
    Cumeeira
    Espinhal
    Podentes
    São Miguel, Santa Eufémia e Rabaçal
    Alfarelos
    Degracias e Pombalinho
    Figueiró do Campo
    Gesteira e Brunhós
    Granja do Ulmeiro
    Samuel
    Soure
    Tapéus
    Vila Nova de Anços
    Vinha da Rainha
    Ázere e Covelo
    Candosa
    Carapinha
    Covas e Vila Nova de Oliveirinha
    Espariz e Sinde
    Midões
    Mouronho
    Pinheiro de Coja e Meda de Mouros
    Póvoa de Midões
    São João da Boa Vista
    Tábua
    Arrifana
    Lavegadas
    Poiares (Santo André)
    São Miguel de Poiares
    Capelins (Santo António)
    N.S. Conceição, S.Brás Matos, Juromenha
    Santiago Maior
    Terena (São Pedro)
    Arraiolos
    Gafanhoeira (São Pedro) e Sabugueiro
    Igrejinha
    São Gregório e Santa Justa
    Vimieiro
    Borba (Matriz)
    Borba (São Bartolomeu)
    Orada
    Rio de Moinhos
    Ameixial (Santa Vitória e São Bento)
    Arcos
    Estremoz (Santa Maria e Santo André)
    Évora Monte (Santa Maria)
    Glória
    São Bento do Cortiço e Santo Estêvão
    São Domingos de Ana Loura
    São Lourenço de Mamporcão e São Bento de Ana Loura
    Veiros
    Bacelo e Senhora da Saúde
    Canaviais
    Évora (São Mamede, Sé, São Pedro e Santo Antão)
    Malagueira e Horta das Figueiras
    N.S. da Tourega e N.S. de Guadalupe
    Nossa Senhora da Graça do Divor
    Nossa Senhora de Machede
    S.Sebastião da Giesteira e N.S. da Boa Fé
    São Bento do Mato
    São Manços e São Vicente do Pigeiro
    São Miguel de Machede
    Torre de Coelheiros
    Cabrela
    Ciborro
    Cortiçadas de Lavre e Lavre
    Foros de Vale de Figueira
    N.S. da Vila, N.S. do Bispo e Silveiras
    Santiago do Escoural
    São Cristóvão
    Brotas
    Cabeção
    Mora
    Pavia
    Granja
    Luz
    Mourão
    Amieira e Alqueva
    Monte do Trigo
    Portel
    Santana
    São Bartolomeu do Outeiro e Oriola
    Vera Cruz
    Montoito
    Redondo
    Campo e Campinho
    Corval
    Monsaraz
    Reguengos de Monsaraz
    Landeira
    Vendas Novas
    Aguiar
    Alcáçovas
    Viana do Alentejo
    Bencatel
    Ciladas
    Nossa Senhora da Conceição e São Bartolomeu
    Pardais
    Albufeira e Olhos de Água
    Ferreiras
    Guia
    Paderne
    Alcoutim e Pereiro
    Giões
    Martim Longo
    Vaqueiros
    Aljezur
    Bordeira
    Odeceixe
    Rogil
    Altura
    Azinhal
    Castro Marim
    Odeleite
    Conceição e Estoi
    Faro (Sé e São Pedro)
    Montenegro
    Santa Bárbara de Nexe
    Estômbar e Parchal
    Ferragudo
    Lagoa e Carvoeiro
    Porches
    Bensafrim e Barão de São João
    Luz
    Odiáxere
    São Gonçalo de Lagos
    Almancil
    Alte
    Ameixial
    Boliqueime
    Loulé (São Clemente)
    Loulé (São Sebastião)
    Quarteira
    Querença, Tôr e Benafim
    Salir
    Alferce
    Marmelete
    Monchique
    Moncarapacho e Fuseta
    Olhão
    Pechão
    Quelfes
    Alvor
    Mexilhoeira Grande
    Portimão
    São Brás de Alportel
    Alcantarilha e Pêra
    Algoz e Tunes
    Armação de Pêra
    São Bartolomeu de Messines
    São Marcos da Serra
    Silves
    Cachopo
    Conceição e Cabanas de Tavira
    Luz de Tavira e Santo Estêvão
    Santa Catarina da Fonte do Bispo
    Santa Luzia
    Tavira (Santa Maria e Santiago)
    Barão de São Miguel
    Budens
    Sagres
    Vila do Bispo e Raposeira
    Monte Gordo
    Vila Nova de Cacela
    Vila Real de Santo António
    Aguiar da Beira e Coruche
    Carapito
    Cortiçada
    Dornelas
    Eirado
    Forninhos
    Pena Verde
    Pinheiro
    Sequeiros e Gradiz
    Souto de Aguiar da Beira e Valverde
    Almeida
    Amoreira, Parada e Cabreira
    Azinhal, Peva e Valverde
    Castelo Bom
    Castelo Mendo, Ade, Monteperobolso e Mesquitela
    Freineda
    Freixo
    Junça e Naves
    Leomil, Mido, Senouras e Aldeia Nova
    Malhada Sorda
    Malpartida e Vale de Coelha
    Miuzela e Porto de Ovelha
    Nave de Haver
    São Pedro de Rio Seco
    Vale da Mula
    Vilar Formoso
    Açores e Velosa
    Baraçal
    Carrapichana
    Casas do Soeiro
    Cortiçô da Serra, Vide entre Vinhas e Salgueirais
    Forno Telheiro
    Lajeosa do Mondego
    Linhares
    Maçal do Chão
    Mesquitela
    Minhocal
    Prados
    Rapa e Cadafaz
    Ratoeira
    São Pedro e Santa Maria e Vila Boa do Mondego
    Vale de Azares
    Algodres, Vale de Afonsinho e Vilar de Amargo
    Almofala e Escarigo
    Castelo Rodrigo
    Cinco Vilas e Reigada
    Colmeal e Vilar Torpim
    Escalhão
    Figueira de Castelo Rodrigo
    Freixeda Torrão, Quintã Pêro Martins, Penha Águia
    Mata de Lobos
    Vermiosa
    Algodres
    Casal Vasco
    Cortiçô e Vila Chã
    Figueiró da Granja
    Fornos de Algodres
    Infias
    Juncais, Vila Ruiva e Vila Soeiro do Chão
    Maceira
    Matança
    Muxagata
    Queiriz
    Sobral Pichorro e Fuinhas
    Aldeias e Mangualde da Serra
    Arcozelo
    Cativelos
    Figueiró da Serra e Freixo da Serra
    Folgosinho
    Gouveia
    Melo e Nabais
    Moimenta da Serra e Vinhó
    Nespereira
    Paços da Serra
    Ribamondego
    Rio Torto e Lagarinhos
    São Paio
    Vila Cortês da Serra
    Vila Franca da Serra
    Vila Nova de Tazem
    Adão
    Aldeia do Bispo
    Aldeia Viçosa
    Alvendre
    Arrifana
    Avelãs da Ribeira
    Avelãs de Ambom e Rocamondo
    Benespera
    Casal de Cinza
    Castanheira
    Cavadoude
    Codesseiro
    Corujeira e Trinta
    Faia
    Famalicão
    Fernão Joanes
    Gonçalo
    Gonçalo Bocas
    Guarda
    Jarmelo São Miguel
    Jarmelo São Pedro
    João Antão
    Maçainhas
    Marmeleiro
    Meios
    Mizarela, Pêro Soares e Vila Soeiro
    Panoias de Cima
    Pega
    Pêra do Moço
    Porto da Carne
    Pousade e Albardo
    Ramela
    Rochoso e Monte Margarida
    Santana da Azinha
    Sobral da Serra
    Vale de Estrela
    Valhelhas
    Vela
    Videmonte
    Vila Cortês do Mondego
    Vila Fernando
    Vila Franca do Deão
    Vila Garcia
    Manteigas (Santa Maria)
    Manteigas (São Pedro)
    Sameiro
    Vale de Amoreira
    Aveloso
    Barreira
    Coriscada
    Longroiva
    Marialva
    Mêda, Outeiro de Gatos e Fonte Longa
    Poço do Canto
    Prova e Casteição
    Rabaçal
    Ranhados
    Vale Flor, Carvalhal e Pai Penela
    Agregação das freguesias Sul de Pinhel
    Alto do Palurdo
    Alverca da Beira/Bouça Cova
    Atalaia e Safurdão
    Ervedosa
    Freixedas
    Lamegal
    Lameiras
    Manigoto
    Pala
    Pinhel
    Pínzio
    Souro Pires
    Terras de Massueime
    Valbom/Bogalhal
    Vale do Côa
    Vale do Massueime
    Vascoveiro
    Águas Belas
    Aldeia da Ponte
    Aldeia da Ribeira, Vilar Maior e Badamalos
    Aldeia do Bispo
    Aldeia Velha
    Alfaiates
    Baraçal
    Bendada
    Bismula
    Casteleiro
    Cerdeira
    Fóios
    Lajeosa e Forcalhos
    Malcata
    Nave
    Pousafoles do Bispo, Pena Lobo e Lomba
    Quadrazais
    Quintas de São Bartolomeu
    Rapoula do Côa
    Rebolosa
    Rendo
    Ruvina, Ruivós e Vale das Éguas
    Sabugal e Aldeia de Santo António
    Santo Estêvão e Moita
    Seixo do Côa e Vale Longo
    Sortelha
    Souto
    Vale de Espinho
    Vila Boa
    Vila do Touro
    Alvoco da Serra
    Carragozela e Várzea de Meruge
    Girabolhos
    Loriga
    Paranhos
    Pinhanços
    Sabugueiro
    Sameice e Santa Eulália
    Sandomil
    Santa Comba
    Santa Marinha e São Martinho
    Santiago
    Sazes da Beira
    Seia, São Romão e Lapa dos Dinheiros
    Teixeira
    Torrozelo e Folhadosa
    Tourais e Lajes
    Travancinha
    Valezim
    Vide e Cabeça
    Vila Cova à Coelheira
    Aldeia Nova
    Castanheira
    Cogula
    Cótimos
    Fiães
    Freches e Torres
    Granja
    Guilheiro
    Moimentinha
    Moreira de Rei
    Palhais
    Póvoa do Concelho
    Reboleiro
    Rio de Mel
    Tamanhos
    Torre do Terrenho, Sebadelhe da Serra e Terrenho
    Trancoso (São Pedro e Santa Maria) e Souto Maior
    Valdujo
    Vale do Seixo e Vila Garcia
    Vila Franca das Naves e Feital
    Vilares e Carnicães
    Almendra
    Castelo Melhor
    Cedovim
    Chãs
    Custóias
    Freixo de Numão
    Horta
    Muxagata
    Numão
    Santa Comba
    Sebadelhe
    Seixas
    Touça
    Vila Nova de Foz Côa
    Alcobaça e Vestiaria
    Alfeizerão
    Aljubarrota
    Bárrio
    Benedita
    Cela
    Coz, Alpedriz e Montes
    Évora de Alcobaça
    Maiorga
    Pataias e Martingança
    São Martinho do Porto
    Turquel
    Vimeiro
    Almoster
    Alvaiázere
    Maçãs de Dona Maria
    Pelmá
    Pussos São Pedro
    Alvorge
    Ansião
    Avelar
    Chão de Couce
    Pousaflores
    Santiago da Guarda
    Batalha
    Golpilheira
    Reguengo do Fetal
    São Mamede
    Bombarral e Vale Covo
    Carvalhal
    Pó
    Roliça
    A dos Francos
    Alvorninha
    Caldas da Rainha - Santo Onofre e Serra do Bouro
    Carvalhal Benfeito
    Foz do Arelho
    Landal
    Nadadouro
    Nossa Senhora do Pópulo, Coto e São Gregório
    Salir de Matos
    Santa Catarina
    Tornada e Salir do Porto
    Vidais
    Castanheira de Pêra e Coentral
    Aguda
    Arega
    Campelo
    Figueiró dos Vinhos e Bairradas
    Amor
    Arrabal
    Bajouca
    Bidoeira de Cima
    Caranguejeira
    Coimbrão
    Colmeias e Memória
    Leiria, Pousos, Barreira e Cortes
    Maceira
    Marrazes e Barosa
    Milagres
    Monte Real e Carvide
    Monte Redondo e Carreira
    Parceiros e Azoia
    Regueira de Pontes
    Santa Catarina da Serra e Chainça
    Santa Eufémia e Boa Vista
    Souto da Carpalhosa e Ortigosa
    Marinha Grande
    Moita
    Vieira de Leiria
    Famalicão
    Nazaré
    Valado dos Frades
    A dos Negros
    Amoreira
    Gaeiras
    Olho Marinho
    Santa Maria, São Pedro e Sobral da Lagoa
    Usseira
    Vau
    Graça
    Pedrógão Grande
    Vila Facaia
    Atouguia da Baleia
    Ferrel
    Peniche
    Serra d'El-Rei
    Abiul
    Almagreira
    Carnide
    Carriço
    Guia, Ilha e Mata Mourisca
    Louriçal
    Meirinhas
    Pelariga
    Pombal
    Redinha
    Santiago e S.Simão de Litém e Albergaria dos Doze
    Vermoil
    Vila Cã
    Alqueidão da Serra
    Alvados e Alcaria
    Arrimal e Mendiga
    Calvaria de Cima
    Juncal
    Mira de Aire
    Pedreiras
    Porto de Mós - São João Baptista e São Pedro
    São Bento
    Serro Ventoso
    Abrigada e Cabanas de Torres
    Aldeia Galega da Merceana e Aldeia Gavinha
    Alenquer (Santo Estêvão e Triana)
    Carnota
    Carregado e Cadafais
    Meca
    Olhalvo
    Ota
    Ribafria e Pereiro de Palhacana
    Ventosa
    Vila Verde dos Francos
    Arranhó
    Arruda dos Vinhos
    Cardosas
    São Tiago dos Velhos
    Alcoentre
    Aveiras de Baixo
    Aveiras de Cima
    Azambuja
    Manique do Intendente, V.N.de S.Pedro e Maçussa
    Vale do Paraíso
    Vila Nova da Rainha
    Alguber
    Cadaval e Pêro Moniz
    Lamas e Cercal
    Painho e Figueiros
    Peral
    Vermelha
    Vilar
    Alcabideche
    Carcavelos e Parede
    Cascais e Estoril
    São Domingos de Rana
    Ajuda
    Alcântara
    Alvalade
    Areeiro
    Arroios
    Avenidas Novas
    Beato
    Belém
    Benfica
    Campo de Ourique
    Campolide
    Carnide
    Estrela
    Lumiar
    Marvila
    Misericórdia
    Olivais
    Parque das Nações
    Penha de França
    Santa Clara
    Santa Maria Maior
    Santo António
    São Domingos de Benfica
    São Vicente
    Bucelas
    Camarate, Unhos e Apelação
    Fanhões
    Loures
    Lousa
    Moscavide e Portela
    Sacavém e Prior Velho
    Santa Iria de Azoia, São João da Talha e Bobadela
    Santo Antão e São Julião do Tojal
    Santo António dos Cavaleiros e Frielas
    Lourinhã e Atalaia
    Miragaia e Marteleira
    Moita dos Ferreiros
    Reguengo Grande
    Ribamar
    Santa Bárbara
    São Bartolomeu dos Galegos e Moledo
    Vimeiro
    Azueira e Sobral da Abelheira
    Carvoeira
    Encarnação
    Enxara do Bispo, Gradil e Vila Franca do Rosário
    Ericeira
    Igreja Nova e Cheleiros
    Mafra
    Malveira e São Miguel de Alcainça
    Milharado
    Santo Isidoro
    Venda do Pinheiro e Santo Estêvão das Galés
    Algés, Linda-a-Velha e Cruz Quebrada-Dafundo
    Barcarena
    Carnaxide e Queijas
    Oeiras e S.Julião da Barra, Paço de Arcos e Caxias
    Porto Salvo
    Agualva e Mira-Sintra
    Algueirão-Mem Martins
    Almargem do Bispo, Pêro Pinheiro e Montelavar
    Cacém e São Marcos
    Casal de Cambra
    Colares
    Massamá e Monte Abraão
    Queluz e Belas
    Rio de Mouro
    S.Maria, S.Miguel, S.Martinho, S.Pedro Penaferrim
    São João das Lampas e Terrugem
    Santo Quintino
    Sapataria
    Sobral de Monte Agraço
    A dos Cunhados e Maceira
    Campelos e Outeiro da Cabeça
    Carvoeira e Carmões
    Dois Portos e Runa
    Freiria
    Maxial e Monte Redondo
    Ponte do Rol
    Ramalhal
    Santa Maria, São Pedro e Matacães
    São Pedro da Cadeira
    Silveira
    Turcifal
    Ventosa
    Alhandra, São João dos Montes e Calhandriz
    Alverca do Ribatejo e Sobralinho
    Castanheira do Ribatejo e Cachoeiras
    Póvoa de Santa Iria e Forte da Casa
    Vialonga
    Vila Franca de Xira
    Águas Livres
    Alfragide
    Encosta do Sol
    Falagueira-Venda Nova
    Mina de Água
    Venteira
    Odivelas
    Pontinha e Famões
    Póvoa de Santo Adrião e Olival Basto
    Ramada e Caneças
    Alter do Chão
    Chancelaria
    Cunheira
    Seda
    Assunção
    Esperança
    Mosteiros
    Alcórrego e Maranhão
    Aldeia Velha
    Avis
    Benavila e Valongo
    Ervedal
    Figueira e Barros
    Nossa Senhora da Expectação
    Nossa Senhora da Graça dos Degolados
    São João Baptista
    Nossa Senhora da Graça de Póvoa e Meadas
    Santa Maria da Devesa
    Santiago Maior
    São João Baptista
    Aldeia da Mata
    Crato e Mártires, Flor da Rosa e Vale do Peso
    Gáfete
    Monte da Pedra
    Assunção, Ajuda, Salvador e Santo Ildefonso
    Barbacena e Vila Fernando
    Caia, São Pedro e Alcáçova
    Santa Eulália
    São Brás e São Lourenço
    São Vicente e Ventosa
    Terrugem e Vila Boim
    Cabeço de Vide
    Fronteira
    São Saturnino
    Belver
    Comenda
    Gavião e Atalaia
    Margem
    Beirã
    Santa Maria de Marvão
    Santo António das Areias
    São Salvador da Aramenha
    Assumar
    Monforte
    Santo Aleixo
    Vaiamonte
    Alpalhão
    Arez e Amieira do Tejo
    Espírito Santo, Nossa Senhora da Graça e São Simão
    Montalvão
    Santana
    São Matias
    Tolosa
    Foros de Arrão
    Galveias
    Longomel
    Montargil
    Ponte de Sor, Tramaga e Vale de Açor
    Alagoa
    Alegrete
    Fortios
    Reguengo e São Julião
    Ribeira de Nisa e Carreiras
    Sé e São Lourenço
    Urra
    Cano
    Casa Branca
    Santo Amaro
    Sousel
    Aboadela, Sanche e Várzea
    Amarante (São Gonçalo), Madalena, Cepelos e Gatão
    Ansiães
    Bustelo, Carneiro e Carvalho de Rei
    Candemil
    Figueiró (Santiago e Santa Cristina)
    Fregim
    Freixo de Cima e de Baixo
    Fridão
    Gondar
    Gouveia (São Simão)
    Jazente
    Lomba
    Louredo
    Lufrei
    Mancelos
    Olo e Canadelo
    Padronelo
    Rebordelo
    Salvador do Monte
    Telões
    Travanca
    Vila Caiz
    Vila Chã do Marão
    Vila Garcia, Aboim e Chapa
    Vila Meã
    Ancede e Ribadouro
    Baião (Santa Leocádia) e Mesquinhata
    Campelo e Ovil
    Frende
    Gestaçô
    Gove
    Grilo
    Loivos da Ribeira e Tresouras
    Loivos do Monte
    Santa Cruz do Douro e São Tomé de Covelas
    Santa Marinha do Zêzere
    Teixeira e Teixeiró
    Valadares
    Viariz
    Aião
    Airães
    Friande
    Idães
    Jugueiros
    Macieira da Lixa e Caramos
    Margaride, Várzea, Lagares, Varziela e Moure
    Pedreira, Rande e Sernande
    Penacova
    Pinheiro
    Pombeiro de Ribavizela
    Refontoura
    Regilde
    Revinhade
    Sendim
    Torrados e Sousa
    Unhão e Lordelo
    Vila Cova da Lixa e Borba de Godim
    Vila Fria e Vizela (São Jorge)
    Vila Verde e Santão
    Baguim do Monte (Rio Tinto)
    Fânzeres e São Pedro da Cova
    Foz do Sousa e Covelo
    Gondomar (São Cosme), Valbom e Jovim
    Lomba
    Melres e Medas
    Rio Tinto
    Aveleda
    Caíde de Rei
    Cernadelo e Lousada (São Miguel e Santa Margarida)
    Cristelos, Boim e Ordem
    Figueiras e Covas
    Lodares
    Lustosa e Barrosas (Santo Estêvão)
    Macieira
    Meinedo
    Nespereira e Casais
    Nevogilde
    Silvares, Pias, Nogueira e Alvarenga
    Sousela
    Torno
    Vilar do Torno e Alentém
    Águas Santas
    Castêlo da Maia
    Cidade da Maia
    Folgosa
    Milheirós
    Moreira
    Nogueira e Silva Escura
    Pedrouços
    São Pedro Fins
    Vila Nova da Telha
    Alpendorada, Várzea e Torrão
    Avessadas e Rosém
    Banho e Carvalhosa
    Bem Viver
    Constance
    Marco
    Paredes de Viadores e Manhuncelos
    Penha Longa e Paços de Gaiolo
    Sande e São Lourenço do Douro
    Santo Isidoro e Livração
    Soalhães
    Sobretâmega
    Tabuado
    Várzea, Aliviada e Folhada
    Vila Boa de Quires e Maureles
    Vila Boa do Bispo
    Custóias, Leça do Balio e Guifões
    Matosinhos e Leça da Palmeira
    Perafita, Lavra e Santa Cruz do Bispo
    São Mamede de Infesta e Senhora da Hora
    Carvalhosa
    Eiriz
    Ferreira
    Figueiró
    Frazão Arreigada
    Freamunde
    Meixomil
    Paços de Ferreira
    Penamaior
    Raimonda
    Sanfins Lamoso Codessos
    Seroa
    Aguiar de Sousa
    Astromil
    Baltar
    Beire
    Cete
    Cristelo
    Duas Igrejas
    Gandra
    Lordelo
    Louredo
    Parada de Todeia
    Paredes
    Rebordosa
    Recarei
    Sobreira
    Sobrosa
    Vandoma
    Vilela
    Abragão
    Boelhe
    Bustelo
    Cabeça Santa
    Canelas
    Capela
    Castelões
    Croca
    Duas Igrejas
    Eja
    Fonte Arcada
    Galegos
    Guilhufe e Urrô
    Irivo
    Lagares e Figueira
    Luzim e Vila Cova
    Oldrões
    Paço de Sousa
    Penafiel
    Perozelo
    Rans
    Recezinhos (São Mamede)
    Recezinhos (São Martinho)
    Rio de Moinhos
    Rio Mau
    Sebolido
    Termas de São Vicente
    Valpedre
    Aldoar, Foz do Douro e Nevogilde
    Bonfim
    Campanhã
    Cedofeita,Ildefonso,Sé,Miragaia,Nicolau,Vitória
    Lordelo do Ouro e Massarelos
    Paranhos
    Ramalde
    Aguçadoura e Navais
    Aver-o-Mar, Amorim e Terroso
    Balazar
    Estela
    Laundos
    Póvoa de Varzim, Beiriz e Argivai
    Rates
    Agrela
    Água Longa
    Areias, Sequeiró, Lama e Palmeira
    Aves
    Carreira e Refojos de Riba de Ave
    Lamelas e Guimarei
    Monte Córdova
    Negrelos (São Tomé)
    Rebordões
    Reguenga
    Roriz
    St.Tirso, Couto (S.Cristina e S.Miguel) e Burgães
    Vila Nova do Campo
    Vilarinho
    Alfena
    Campo e Sobrado
    Ermesinde
    Valongo
    Árvore
    Aveleda
    Azurara
    Bagunte, Ferreiró, Outeiro Maior e Parada
    Fajozes
    Fornelo e Vairão
    Gião
    Guilhabreu
    Junqueira
    Labruge
    Macieira da Maia
    Malta e Canidelo
    Mindelo
    Modivas
    Retorta e Tougues
    Rio Mau e Arcos
    Touguinha e Touguinhó
    Vila Chã
    Vila do Conde
    Vilar de Pinheiro
    Vilar e Mosteiró
    Arcozelo
    Avintes
    Canelas
    Canidelo
    Grijó e Sermonde
    Gulpilhares e Valadares
    Madalena
    Mafamude e Vilar do Paraíso
    Oliveira do Douro
    Pedroso e Seixezelo
    Sandim, Olival, Lever e Crestuma
    Santa Marinha e São Pedro da Afurada
    São Félix da Marinha
    Serzedo e Perosinho
    Vilar de Andorinho
    Alvarelhos e Guidões
    Bougado (São Martinho e Santiago)
    Coronado (São Romão e São Mamede)
    Covelas
    Muro
    Abrantes (São Vicente e São João) e Alferrarede
    Aldeia do Mato e Souto
    Alvega e Concavada
    Bemposta
    Carvalhal
    Fontes
    Martinchel
    Mouriscas
    Pego
    Rio de Moinhos
    São Facundo e Vale das Mós
    São Miguel do Rio Torto e Rossio ao Sul do Tejo
    Tramagal
    Alcanena e Vila Moreira
    Bugalhos
    Malhou, Louriceira e Espinheiro
    Minde
    Moitas Venda
    Monsanto
    Serra de Santo António
    Almeirim
    Benfica do Ribatejo
    Fazendas de Almeirim
    Raposa
    Alpiarça
    Barrosa
    Benavente
    Samora Correia
    Santo Estêvão
    Cartaxo e Vale da Pinta
    Ereira e Lapa
    Pontével
    Valada
    Vale da Pedra
    Vila Chã de Ourique
    Carregueira
    Chamusca e Pinheiro Grande
    Parreira e Chouto
    Ulme
    Vale de Cavalos
    Constância
    Montalvo
    Santa Margarida da Coutada
    Biscainho
    Branca
    Coruche, Fajarda e Erra
    Couço
    Santana do Mato
    São José da Lamarosa
    Nossa Senhora de Fátima
    São João Baptista
    Águas Belas
    Areias e Pias
    Beco
    Chãos
    Ferreira do Zêzere
    Igreja Nova do Sobral
    Nossa Senhora do Pranto
    Azinhaga
    Golegã
    Pombalinho
    Amêndoa
    Cardigos
    Carvoeiro
    Envendos
    Mação, Penhascoso e Aboboreira
    Ortiga
    Alcobertas
    Arrouquelas
    Asseiceira
    Azambujeira e Malaqueijo
    Fráguas
    Marmeleira e Assentiz
    Outeiro da Cortiçada e Arruda dos Pisões
    Rio Maior
    São João da Ribeira e Ribeira de São João
    São Sebastião
    Glória do Ribatejo e Granho
    Marinhais
    Muge
    Salvaterra de Magos e Foros de Salvaterra
    Abitureiras
    Abrã
    Achete, Azoia de Baixo e Póvoa de Santarém
    Alcanede
    Alcanhões
    Almoster
    Amiais de Baixo
    Arneiro das Milhariças
    Azoia de Cima e Tremês
    Casével e Vaqueiros
    Cidade de Santarém
    Gançaria
    Moçarria
    Pernes
    Póvoa da Isenta
    Romeira e Várzea
    São Vicente do Paul e Vale de Figueira
    Vale de Santarém
    Alcaravela
    Santiago de Montalegre
    Sardoal
    Valhascos
    Além da Ribeira e Pedreira
    Asseiceira
    Carregueiros
    Casais e Alviobeira
    Madalena e Beselga
    Olalhas
    Paialvo
    Sabacheira
    São João Baptista e Santa Maria dos Olivais
    São Pedro de Tomar
    Serra e Junceira
    Assentiz
    Brogueira, Parceiros de Igreja e Alcorochel
    Chancelaria
    Meia Via
    Olaia e Paço
    Pedrógão
    Riachos
    Torres Novas (Santa Maria, Salvador e Santiago)
    Torres Novas (São Pedro), Lapas e Ribeira Branca
    Zibreira
    Atalaia
    Praia do Ribatejo
    Tancos
    Vila Nova da Barquinha
    Alburitel
    Atouguia
    Caxarias
    Espite
    Fátima
    Freixianda, Ribeira do Fárrio e Formigais
    Gondemaria e Olival
    Matas e Cercal
    Nossa Senhora da Piedade
    Nossa Senhora das Misericórdias
    Rio de Couros e Casal dos Bernardos
    Seiça
    Urqueira
    Comporta
    Santa Maria do Castelo e Santiago e Santa Susana
    São Martinho
    Torrão
    Alcochete
    Samouco
    São Francisco
    Almada, Cova da Piedade, Pragal e Cacilhas
    Caparica e Trafaria
    Charneca de Caparica e Sobreda
    Costa da Caparica
    Laranjeiro e Feijó
    Alto do Seixalinho, Santo André e Verderena
    Barreiro e Lavradio
    Palhais e Coina
    Santo António da Charneca
    Azinheira dos Barros e São Mamede do Sádão
    Carvalhal
    Grândola e Santa Margarida da Serra
    Melides
    Alhos Vedros
    Baixa da Banheira e Vale da Amoreira
    Gaio-Rosário e Sarilhos Pequenos
    Moita
    Atalaia e Alto Estanqueiro-Jardia
    Canha
    Montijo e Afonsoeiro
    Pegões
    Sarilhos Grandes
    Palmela
    Pinhal Novo
    Poceirão e Marateca
    Quinta do Anjo
    Abela
    Alvalade
    Cercal
    Ermidas-Sado
    Santiago do Cacém, S.Cruz e S.Bartolomeu da Serra
    Santo André
    São Domingos e Vale de Água
    São Francisco da Serra
    Amora
    Corroios
    Fernão Ferro
    Seixal, Arrentela e Aldeia de Paio Pires
    Quinta do Conde
    Sesimbra (Castelo)
    Sesimbra (Santiago)
    Azeitão (São Lourenço e São Simão)
    Gâmbia-Pontes-Alto da Guerra
    S.Julião, N.S. da Anunciada e S.Maria da Graça
    Sado
    Setúbal (São Sebastião)
    Porto Covo
    Sines
    Aboim das Choças
    Aguiã
    Alvora e Loureda
    Arcos de Valdevez (Salvador), Vila Fonche e Parada
    Arcos de Valdevez (São Paio) e Giela
    Ázere
    Cabana Maior
    Cabreiro
    Cendufe
    Couto
    Eiras e Mei
    Gavieira
    Gondoriz
    Grade e Carralcova
    Guilhadeses e Santar
    Jolda (Madalena) e Rio Cabrão
    Jolda (São Paio)
    Miranda
    Monte Redondo
    Oliveira
    Paçô
    Padreiro (Salvador e Santa Cristina)
    Padroso
    Portela e Extremo
    Prozelo
    Rio de Moinhos
    Rio Frio
    Sabadim
    São Jorge e Ermelo
    Senharei
    Sistelo
    Soajo
    Souto e Tabaçô
    Távora (Santa Maria e São Vicente)
    Vale
    Vilela, São Cosme e São Damião e Sá
    Âncora
    Arga (Baixo, Cima e São João)
    Argela
    Caminha (Matriz) e Vilarelho
    Dem
    Gondar e Orbacém
    Lanhelas
    Moledo e Cristelo
    Riba de Âncora
    Seixas
    Venade e Azevedo
    Vila Praia de Âncora
    Vilar de Mouros
    Vile
    Alvaredo
    Castro Laboreiro e Lamas de Mouro
    Chaviães e Paços
    Cousso
    Cristoval
    Fiães
    Gave
    Paderne
    Parada do Monte e Cubalhão
    Penso
    Prado e Remoães
    São Paio
    Vila e Roussas
    Abedim
    Anhões e Luzio
    Barbeita
    Barroças e Taias
    Bela
    Cambeses
    Ceivães e Badim
    Lara
    Longos Vales
    Mazedo e Cortes
    Merufe
    Messegães, Valadares e Sá
    Monção e Troviscoso
    Moreira
    Pias
    Pinheiros
    Podame
    Portela
    Riba de Mouro
    Sago, Lordelo e Parada
    Segude
    Tangil
    Troporiz e Lapela
    Trute
    Agualonga
    Bico e Cristelo
    Castanheira
    Cossourado e Linhares
    Coura
    Cunha
    Formariz e Ferreira
    Infesta
    Insalde e Porreiras
    Mozelos
    Padornelo
    Parada
    Paredes de Coura e Resende
    Romarigães
    Rubiães
    Vascões
    Azias
    Boivães
    Bravães
    Britelo
    Crasto, Ruivos e Grovelas
    Cuide de Vila Verde
    Entre Ambos-os-Rios, Ermida e Germil
    Lavradas
    Lindoso
    Nogueira
    Oleiros
    Ponte da Barca, V.N. Muía, Paço Vedro Magalhães
    Sampriz
    Touvedo (São Lourenço e Salvador)
    Vade (São Pedro)
    Vade (São Tomé)
    Vila Chã (São João Baptista e Santiago)
    Anais
    Arca e Ponte de Lima
    Arcozelo
    Ardegão, Freixo e Mato
    Associação de freguesias do Vale do Neiva
    Bárrio e Cepões
    Beiral do Lima
    Bertiandos
    Boalhosa
    Brandara
    Cabaços e Fojo Lobal
    Cabração e Moreira do Lima
    Calheiros
    Calvelo
    Correlhã
    Estorãos
    Facha
    Feitosa
    Fontão
    Fornelos e Queijada
    Friastelas
    Gandra
    Gemieira
    Gondufe
    Labruja
    Labrujó, Rendufe e Vilar do Monte
    Navió e Vitorino dos Piães
    Poiares
    Rebordões (Santa Maria)
    Rebordões (Souto)
    Refóios do Lima
    Ribeira
    Sá
    Santa Comba
    Santa Cruz do Lima
    São Pedro d'Arcos
    Seara
    Serdedelo
    Vitorino das Donas
    Boivão
    Cerdal
    Fontoura
    Friestas
    Gandra e Taião
    Ganfei
    Gondomil e Sanfins
    São Julião e Silva
    São Pedro da Torre
    Valença, Cristelo Covo e Arão
    Verdoejo
    Afife
    Alvarães
    Amonde
    Anha
    Areosa
    Barroselas e Carvoeiro
    Cardielos e Serreleis
    Carreço
    Castelo do Neiva
    Chafé
    Darque
    Freixieiro de Soutelo
    Geraz do Lima e Deão
    Lanheses
    Mazarefes e Vila Fria
    Montaria
    Mujães
    Nogueira, Meixedo e Vilar de Murteda
    Outeiro
    Perre
    Santa Maria Maior e Monserrate e Meadela
    Santa Marta de Portuzelo
    São Romão de Neiva
    Subportela, Deocriste e Portela Susã
    Torre e Vila Mou
    Vila de Punhe
    Vila Franca
    Campos e Vila Meã
    Candemil e Gondar
    Cornes
    Covas
    Gondarém
    Loivo
    Mentrestido
    Reboreda e Nogueira
    Sapardos
    Sopo
    Vila Nova de Cerveira e Lovelhe
    Alijó
    Carlão e Amieiro
    Castedo e Cotas
    Favaios
    Pegarinhos
    Pinhão
    Pópulo e Ribalonga
    Sanfins do Douro
    Santa Eugénia
    São Mamede de Ribatua
    Vale de Mendiz, Casal de Loivos e Vilarinho
    Vila Chã
    Vila Verde
    Vilar de Maçada
    Alturas do Barroso e Cerdedo
    Ardãos e Bobadela
    Beça
    Boticas e Granja
    Codessoso, Curros e Fiães do Tâmega
    Covas do Barroso
    Dornelas
    Pinho
    Sapiãos
    Vilar e Viveiro
    Águas Frias
    Anelhe
    Bustelo
    Calvão e Soutelinho da Raia
    Cimo de Vila da Castanheira
    Curalha
    Eiras, São Julião de Montenegro e Cela
    Ervededo
    Faiões
    Lama de Arcos
    Loivos e Póvoa de Agrações
    Madalena e Samaiões
    Mairos
    Moreiras
    Nogueira da Montanha
    Oura
    Outeiro Seco
    Paradela
    Planalto de Monforte (Oucidres e Bobadela)
    Redondelo
    Sanfins
    Santa Cruz/Trindade e Sanjurge
    Santa Leocádia
    Santa Maria Maior
    Santo António de Monforte
    Santo Estêvão
    São Pedro de Agostém
    São Vicente
    Soutelo e Seara Velha
    Travancas e Roriz
    Tronco
    Vale de Anta
    Vidago, Arcossó, Selhariz, Vilarinho Paranheiras
    Vila Verde da Raia
    Vilar de Nantes
    Vilarelho da Raia
    Vilas Boas
    Vilela do Tâmega
    Vilela Seca
    Barqueiros
    Cidadelhe
    Mesão Frio (Santo André)
    Oliveira
    Vila Marim
    Atei
    Bilhó
    Campanhó e Paradança
    Ermelo e Pardelhas
    São Cristóvão de Mondim de Basto
    Vilar de Ferreiros
    Cabril
    Cambeses do Rio, Donões e Mourilhe
    Cervos
    Chã
    Covelo do Gerês
    Ferral
    Gralhas
    Meixedo e Padornelos
    Montalegre e Padroso
    Morgade
    Negrões
    Outeiro
    Paradela, Contim e Fiães
    Pitões das Junias
    Reigoso
    Salto
    Santo André
    Sarraquinhos
    Sezelhe e Covelães
    Solveira
    Tourém
    Venda Nova e Pondras
    Viade de Baixo e Fervidelas
    Vila da Ponte
    Vilar de Perdizes e Meixide
    Candedo
    Carva e Vilares
    Fiolhoso
    Jou
    Murça
    Noura e Palheiros
    Valongo de Milhais
    Fontelas
    Galafura e Covelinhas
    Loureiro
    Moura Morta e Vinhós
    Peso da Régua e Godim
    Poiares e Canelas
    Sedielos
    Vilarinho dos Freires
    Alvadia
    Canedo
    Cerva e Limões
    Salvador e Santo Aleixo de Além-Tâmega
    Santa Marinha
    Celeirós
    Covas do Douro
    Gouvinhas
    Paços
    Parada de Pinhão
    Provesende, Gouvães e S.Cristóvão do Douro
    Sabrosa
    São Lourenço de Ribapinhão
    São Martinho de Antas e Paradela de Guiães
    Souto Maior
    Torre do Pinhão
    Vilarinho de São Romão
    Alvações do Corgo
    Cumieira
    Fontes
    Lobrigos (S.Miguel e S.João Baptista) e Sanhoane
    Louredo e Fornelos
    Medrões
    Sever
    Água Revés e Crasto
    Algeriz
    Bouçoães
    Canaveses
    Carrazedo de Montenegro e Curros
    Ervões
    Fornos do Pinhal
    Friões
    Lebução, Fiães e Nozelos
    Padrela e Tazem
    Possacos
    Rio Torto
    Santa Maria de Emeres
    Santa Valha
    Santiago da Ribeira de Alhariz
    São João da Corveira
    São Pedro de Veiga de Lila
    Serapicos
    Sonim e Barreiros
    Tinhela e Alvarelhos
    Vales
    Valpaços e Sanfins
    Vassal
    Veiga de Lila
    Vilarandelo
    Alfarela de Jales
    Alvão
    Bornes de Aguiar
    Bragado
    Capeludos
    Pensalvos e Parada de Monteiros
    Sabroso de Aguiar
    Soutelo de Aguiar
    Telões
    Tresminas
    Valoura
    Vila Pouca de Aguiar
    Vreia de Bornes
    Vreia de Jales
    Abaças
    Adoufe e Vilarinho de Samardã
    Andrães
    Arroios
    Borbela e Lamas de Olo
    Campeã
    Constantim e Vale de Nogueiras
    Folhadela
    Guiães
    Lordelo
    Mateus
    Mondrões
    Mouçós e Lamares
    Nogueira e Ermida
    Parada de Cunhos
    Pena, Quintã e Vila Cova
    São Tomé do Castelo e Justes
    Torgueda
    Vila Marim
    Vila Real
    Aldeias
    Aricera e Goujoim
    Armamar
    Cimbres
    Folgosa
    Fontelo
    Queimada
    Queimadela
    Santa Cruz
    São Cosmado
    São Martinho das Chãs
    São Romão e Santiago
    Vacalar
    Vila Seca e Santo Adrião
    Beijós
    Cabanas de Viriato
    Carregal do Sal
    Oliveira do Conde
    Parada
    Almofala
    Cabril
    Castro Daire
    Cujó
    Gosende
    Mamouros, Alva e Ribolhos
    Mezio e Moura Morta
    Mões
    Moledo
    Monteiras
    Parada de Ester e Ester
    Pepim
    Picão e Ermida
    Pinheiro
    Reriz e Gafanhão
    São Joaninho
    Alhões, Bustelo, Gralheira e Ramires
    Cinfães
    Espadanedo
    Ferreiros de Tendais
    Fornelos
    Moimenta
    Nespereira
    Oliveira do Douro
    Santiago de Piães
    São Cristóvão de Nogueira
    Souselo
    Tarouquela
    Tendais
    Travanca
    Avões
    Bigorne, Magueija e Pretarouca
    Britiande
    Cambres
    Cepões, Meijinhos e Melcões
    Ferreirim
    Ferreiros de Avões
    Figueira
    Lalim
    Lamego (Almacave e Sé)
    Lazarim
    Parada do Bispo e Valdigem
    Penajóia
    Penude
    Samodães
    Sande
    Várzea de Abrunhais
    Vila Nova de Souto d'El-Rei
    Abrunhosa-a-Velha
    Alcafache
    Cunha Baixa
    Espinho
    Fornos de Maceira Dão
    Freixiosa
    Mangualde, Mesquitela e Cunha Alta
    Moimenta de Maceira Dão e Lobelhe do Mato
    Quintela de Azurara
    Santiago de Cassurrães e Póvoa de Cervães
    São João da Fresta
    Tavares (Chãs, Várzea e Travanca)
    Alvite
    Arcozelos
    Baldos
    Cabaços
    Caria
    Castelo
    Leomil
    Moimenta da Beira
    Paradinha e Nagosa
    Passô
    Pêra Velha, Aldeia de Nacomba e Ariz
    Peva e Segões
    Sarzedo
    Sever
    Vila da Rua
    Vilar
    Cercosa
    Espinho
    Marmeleira
    Mortágua, Vale de Remígio, Cortegaça e Almaça
    Pala
    Sobral
    Trezói
    Canas de Senhorim
    Carvalhal Redondo e Aguieira
    Lapa do Lobo
    Nelas
    Santar e Moreira
    Senhorim
    Vilar Seco
    Arca e Varzielas
    Arcozelo das Maias
    Destriz e Reigoso
    Oliveira de Frades, Souto de Lafões e Sejães
    Pinheiro
    Ribeiradio
    São João da Serra
    São Vicente de Lafões
    Antas e Matela
    Castelo de Penalva
    Esmolfe
    Germil
    Ínsua
    Lusinde
    Pindo
    Real
    Sezures
    Trancozelos
    Vila Cova do Covelo/Mareco
    Antas e Ourozinho
    Beselga
    Castainço
    Penedono e Granja
    Penela da Beira
    Póvoa de Penela
    Souto
    Anreade e São Romão de Aregos
    Barrô
    Cárquere
    Felgueiras e Feirão
    Freigil e Miomães
    Ovadas e Panchorra
    Paus
    Resende
    São Cipriano
    São João de Fontoura
    São Martinho de Mouros
    Ovoa e Vimieiro
    Pinheiro de Ázere
    Santa Comba Dão e Couto do Mosteiro
    São Joaninho
    São João de Areias
    Treixedo e Nagozela
    Castanheiro do Sul
    Ervedosa do Douro
    Nagozelo do Douro
    Paredes da Beira
    Riodades
    São João da Pesqueira e Várzea de Trevões
    Soutelo do Douro
    Trevões e Espinhosa
    Vale de Figueira
    Valongo dos Azeites
    Vilarouco e Pereiros
    Bordonhos
    Carvalhais e Candal
    Figueiredo de Alva
    Manhouce
    Pindelo dos Milagres
    Pinho
    Santa Cruz da Trapa e São Cristóvão de Lafões
    São Félix
    São Martinho das Moitas e Covas do Rio
    São Pedro do Sul, Várzea e Baiões
    Serrazes
    Sul
    Valadares
    Vila Maior
    Águas Boas e Forles
    Avelal
    Ferreira de Aves
    Mioma
    Rio de Moinhos
    Romãs, Decermilo e Vila Longa
    São Miguel de Vila Boa
    Sátão
    Silvã de Cima
    Arnas
    Carregal
    Chosendo
    Cunha
    Faia
    Ferreirim e Macieira
    Fonte Arcada e Escurquela
    Granjal
    Lamosa
    Penso e Freixinho
    Quintela
    Sernancelhe e Sarzeda
    Vila da Ponte
    Adorigo
    Arcos
    Barcos e Santa Leocádia
    Chavães
    Desejosa
    Granja do Tedo
    Longa
    Paradela e Granjinha
    Pinheiros e Vale de Figueira
    Sendim
    Tabuaço
    Távora e Pereiro
    Valença do Douro
    Gouviães e Ucanha
    Granja Nova e Vila Chã da Beira
    Mondim da Beira
    Salzedas
    São João de Tarouca
    Tarouca e Dálvares
    Várzea da Serra
    Barreiro de Besteiros e Tourigo
    Campo de Besteiros
    Canas de Santa Maria
    Caparrosa e Silvares
    Castelões
    Dardavaz
    Ferreirós do Dão
    Guardão
    Lajeosa do Dão
    Lobão da Beira
    Molelos
    Mouraz e Vila Nova da Rainha
    Parada de Gonta
    Santiago de Besteiros
    São João do Monte e Mosteirinho
    São Miguel do Outeiro e Sabugosa
    Tonda
    Tondela e Nandufe
    Vilar de Besteiros e Mosteiro de Fráguas
    Pendilhe
    Queiriga
    Touro
    Vila Cova à Coelheira
    Vila Nova de Paiva, Alhais e Fráguas
    Abraveses
    Barreiros e Cepões
    Boa Aldeia, Farminhão e Torredeita
    Bodiosa
    Calde
    Campo
    Cavernães
    Cota
    Coutos de Viseu
    Fail e Vila Chã de Sá
    Fragosela
    Lordosa
    Mundão
    Orgens
    Povolide
    Ranhados
    Repeses e São Salvador
    Ribafeita
    Rio de Loba
    Santos Evos
    São Cipriano e Vil de Souto
    São João de Lourosa
    São Pedro de France
    Silgueiros
    Viseu
    Alcofra
    Cambra e Carvalhal de Vermilhas
    Campia
    Fataunços e Figueiredo das Donas
    Fornelo do Monte
    Queirã
    São Miguel do Mato
    Ventosa
    Vouzela e Paços de Vilharigues
    Arco da Calheta
    Calheta
    Estreito da Calheta
    Fajã da Ovelha
    Jardim do Mar
    Paul do Mar
    Ponta do Pargo
    Prazeres
    Câmara de Lobos
    Curral das Freiras
    Estreito de Câmara de Lobos
    Jardim da Serra
    Quinta Grande
    Funchal (Santa Luzia)
    Funchal (Santa Maria Maior)
    Funchal (São Pedro)
    Funchal (Sé)
    Imaculado Coração de Maria
    Monte
    Santo António
    São Gonçalo
    São Martinho
    São Roque
    Água de Pena
    Caniçal
    Machico
    Porto da Cruz
    Santo António da Serra
    Canhas
    Madalena do Mar
    Ponta do Sol
    Achadas da Cruz
    Porto Moniz
    Ribeira da Janela
    Seixal
    Campanário
    Ribeira Brava
    Serra de Água
    Tabua
    Camacha
    Caniço
    Gaula
    Santa Cruz
    Santo António da Serra
    Arco de São Jorge
    Faial
    Ilha
    Santana
    São Jorge
    São Roque do Faial
    Boa Ventura
    Ponta Delgada
    São Vicente
    Porto Santo
    Almagreira
    Santa Bárbara
    Santo Espírito
    São Pedro
    Vila do Porto
    Água de Pau
    Cabouco
    Lagoa (Nossa Senhora do Rosário)
    Lagoa (Santa Cruz)
    Ribeira Chã
    Achada
    Achadinha
    Algarvia
    Lomba da Fazenda
    Nordeste
    Salga
    Santana
    Santo António de Nordestinho
    São Pedro de Nordestinho
    Ajuda da Bretanha
    Arrifes
    Candelária
    Capelas
    Covoada
    Fajã de Baixo
    Fajã de Cima
    Fenais da Luz
    Feteiras
    Ginetes
    Mosteiros
    Pilar da Bretanha
    Ponta Delgada (São José)
    Ponta Delgada (São Pedro)
    Ponta Delgada (São Sebastião)
    Relva
    Remédios
    Rosto do Cão (Livramento)
    Rosto do Cão (São Roque)
    Santa Bárbara
    Santa Clara
    Santo António
    São Vicente Ferreira
    Sete Cidades
    Ajuda da Bretanha
    Arrifes
    Candelária
    Capelas
    Covoada
    Fajã de Baixo
    Fajã de Cima
    Fenais da Luz
    Feteiras
    Ginetes
    Mosteiros
    Pilar da Bretanha
    Ponta Delgada (São José)
    Ponta Delgada (São Pedro)
    Ponta Delgada (São Sebastião)
    Relva
    Remédios
    Rosto do Cão (Livramento)
    Rosto do Cão (São Roque)
    Santa Bárbara
    Santa Clara
    Santo António
    São Vicente Ferreira
    Sete Cidades
    Calhetas
    Fenais da Ajuda
    Lomba da Maia
    Lomba de São Pedro
    Maia
    Pico da Pedra
    Porto Formoso
    Rabo de Peixe
    Ribeira Grande (Conceição)
    Ribeira Grande (Matriz)
    Ribeira Seca
    Ribeirinha
    Santa Bárbara
    São Brás
    Água de Alto
    Ponta Garça
    Ribeira das Tainhas
    Ribeira Seca
    Vila Franca do Campo (São Miguel)
    Vila Franca do Campo (São Pedro)
    Altares
    Angra (Nossa Senhora da Conceição)
    Angra (Santa Luzia)
    Angra (São Pedro)
    Angra (Sé)
    Cinco Ribeiras
    Doze Ribeiras
    Feteira
    Porto Judeu
    Posto Santo
    Raminho
    Ribeirinha
    Santa Bárbara
    São Bartolomeu de Regatos
    São Bento
    São Mateus da Calheta
    Serreta
    Terra Chã
    Vila de São Sebastião
    Agualva
    Biscoitos
    Cabo da Praia
    Fonte do Bastardo
    Fontinhas
    Lajes
    Porto Martins
    Praia da Vitória (Santa Cruz)
    Quatro Ribeiras
    São Brás
    Vila Nova
    Guadalupe
    Luz
    Santa Cruz da Graciosa
    São Mateus
    Calheta
    Norte Pequeno
    Ribeira Seca
    Santo Antão
    Topo (Nossa Senhora do Rosário)
    Manadas (Santa Bárbara)
    Norte Grande (Neves)
    Rosais
    Santo Amaro
    Urzelina (São Mateus)
    Velas (São Jorge)
    Calheta de Nesquim
    Lajes do Pico
    Piedade
    Ribeiras
    Ribeirinha
    São João
    Bandeiras
    Candelária
    Criação Velha
    Madalena
    São Caetano
    São Mateus
    Prainha
    Santa Luzia
    Santo Amaro
    Santo António
    São Roque do Pico
    Capelo
    Castelo Branco
    Cedros
    Feteira
    Flamengos
    Horta (Angústias)
    Horta (Conceição)
    Horta (Matriz)
    Pedro Miguel
    Praia do Almoxarife
    Praia do Norte
    Ribeirinha
    Salão
    Fajã Grande
    Fajãzinha
    Fazenda
    Lajedo
    Lajes das Flores
    Lomba
    Mosteiro
    Caveira
    Cedros
    Ponta Delgada
    Santa Cruz das Flores
    Corvo
).strip.split(/\n+/).map { |e| e.strip }
dw_records = %(
    Aguada de Cima
    Fermentelos
    Macinhata do Vouga
    Valongo do Vouga
    União das freguesias de Águeda e Borralha
    União das freguesias de Barrô e Aguada de Baixo
    União das freguesias de Belazaima do Chão, Castanheira do Vouga e Agadão
    União das freguesias de Recardães e Espinhel
    União das freguesias de Travassô e Óis da Ribeira
    União das freguesias de Trofa, Segadães e Lamas do Vouga
    União das freguesias do Préstimo e Macieira de Alcoba
    Alquerubim
    Angeja
    Branca – Albergaria-A-Velha
    Ribeira de Fráguas
    Albergaria-a-Velha e Valmaior
    São João de Loure e Frossos
    Avelãs de Caminho
    Avelãs de Cima
    Moita – Anadia
    Sangalhos
    São Lourenço do Bairro
    Vila Nova de Monsarros
    Vilarinho do Bairro
    União das freguesias de Amoreira da Gândara, Paredes do Bairro e Ancas
    União das freguesias de Arcos e Mogofores
    União das freguesias de Tamengos, Aguim e Óis do Bairro
    Alvarenga
    Chave
    Escariz
    Fermedo
    Mansores
    Moldes
    Rossas – Arouca
    Santa Eulália – Arouca
    São Miguel do Mato – Arouca
    Tropeço
    Urrô
    Várzea – Arouca
    União das freguesias de Arouca e Burgo
    União das freguesias de Cabreiros e Albergaria da Serra
    União das freguesias de Canelas e Espiunca
    União das freguesias de Covelo de Paivó e Janarde
    Aradas
    Cacia
    Esgueira
    Oliveirinha
    São Bernardo
    São Jacinto
    Santa Joana
    Eixo e Eirol
    Requeixo, Nossa Senhora de Fátima e Nariz
    União das freguesias de Glória e Vera Cruz
    Fornos – Castelo de Paiva
    Real – Castelo de Paiva
    Santa Maria de Sardoura
    São Martinho de Sardoura
    União das freguesias de Raiva, Pedorido e Paraíso
    União das freguesias de Sobrado e Bairros
    Espinho – Espinho
    Paramos
    Silvalde
    União das freguesias de Anta e Guetim
    Avanca
    Pardilhó
    Salreu
    União das freguesias de Beduído e Veiros
    União das freguesias de Canelas e Fermelã
    Argoncilhe
    Arrifana – Santa Maria da Feira
    Escapães
    Fiães – Santa Maria da Feira
    Fornos – Santa Maria da Feira
    Lourosa – Santa Maria da Feira
    Milheirós de Poiares
    Mozelos – Santa Maria da Feira
    Nogueira da Regedoura
    São Paio de Oleiros
    Paços de Brandão
    Rio Meão
    Romariz
    Sanguedo
    Santa Maria de Lamas
    São João de Ver
    União das freguesias de Caldas de São Jorge e Pigeiros
    União das freguesias de Canedo, Vale e Vila Maior
    União das freguesias de Lobão, Gião, Louredo e Guisande
    União das freguesias de Santa Maria da Feira, Travanca, Sanfins e Espargo
    União das freguesias de São Miguel do Souto e Mosteirô
    Gafanha da Encarnação
    Gafanha da Nazaré
    Gafanha do Carmo
    Ílhavo (São Salvador)
    Barcouço
    Casal Comba
    Luso
    Pampilhosa
    Vacariça
    União das freguesias da Mealhada, Ventosa do Bairro e Antes
    Bunheiro
    Monte
    Murtosa
    Torreira
    Carregosa
    Cesar
    Fajões
    Loureiro – Oliveira de Azeméi
    Macieira de Sarnes
    Ossela
    São Martinho da Gândara
    São Roque
    Vila de Cucujães
    União das freguesias de Nogueira do Cravo e Pindelo
    União das freguesias de Oliveira de Azeméis, Santiago da Riba-Ul, Ul, Macinhata da Seixa e Madail
    União das freguesias de Pinheiro da Bemposta, Travanca e Palmaz
    Oiã
    Oliveira do Bairro
    Palhaça
    União das freguesias de Bustos, Troviscal e Mamarrosa
    Cortegaça
    Esmoriz
    Maceda
    Válega
    União das freguesias de Ovar, São João, Arada e São Vicente de Pereira Jusã
    São João da Madeira
    Couto de Esteves
    Pessegueiro do Vouga
    Rocas do Vouga
    Sever do Vouga
    Talhadas
    União das freguesias de Cedrim e Paradela
    União das freguesias de Silva Escura e Dornelas
    Calvão
    Gafanha da Boa Hora
    Ouca
    Sosa
    Santo André de Vagos
    União das freguesias de Fonte de Angeão e Covão do Lobo
    União das freguesias de Ponte de Vagos e Santa Catarina
    União das freguesias de Vagos e Santo António
    Arões
    São Pedro de Castelões
    Cepelos
    Junqueira – Vale de Cambra
    Macieira de Cambra
    Roge
    União das freguesias de Vila Chã, Codal e Vila Cova de Perrinho
    Ervidel
    Messejana
    São João de Negrilhos
    União das freguesias de Aljustrel e Rio de Moinhos
    Rosário
    Santa Cruz – Almodôvar
    São Barnabé
    Aldeia dos Fernandes
    União das freguesias de Almodôvar e Graça dos Padrões
    União das freguesias de Santa Clara-a-Nova e Gomes Aires
    Alvito
    Vila Nova da Baronia
    Barrancos
    Baleizão
    Beringel
    Cabeça Gorda
    Nossa Senhora das Neves
    Santa Clara de Louredo
    São Matias – Beja
    União das freguesias de Albernoa e Trindade
    União das freguesias de Beja (Salvador e Santa Maria da Feira)
    União das freguesias de Beja (Santiago Maior e São João Baptista)
    União das freguesias de Salvada e Quintos
    União das freguesias de Santa Vitória e Mombeja
    União das freguesias de Trigaches e São Brissos
    Entradas
    Santa Bárbara de Padrões
    São Marcos da Ataboeira
    União das freguesias de Castro Verde e Casével
    Cuba
    Faro do Alentejo
    Vila Alva
    Vila Ruiva
    Figueira dos Cavaleiros
    Odivelas – Ferreira do Alentejo
    União das freguesias de Alfundão e Peroguarda
    União das freguesias de Ferreira do Alentejo e Canhestros
    Alcaria Ruiva
    Corte do Pinto
    Espírito Santo
    Mértola
    Santana de Cambas
    São João dos Caldeireiros
    União das freguesias de São Miguel do Pinheiro, São Pedro de Solis e São Sebastião dos Carros
    Amareleja
    Póvoa de São Miguel
    Sobral da Adiça
    União das freguesias de Moura (Santo Agostinho e São João Baptista) e Santo Amador
    União das freguesias de Safara e Santo Aleixo da Restauração
    Relíquias
    Sabóia
    São Luís
    São Martinho das Amoreiras
    Vila Nova de Milfontes
    Luzianes-Gare
    Boavista dos Pinheiros
    Longueira/Almograve
    Colos
    Santa Clara-a-Velha
    São Salvador e Santa Maria
    São Teotónio
    Vale de Santiago
    Ourique
    Santana da Serra
    União das freguesias de Garvão e Santa Luzia
    União das freguesias de Panoias e Conceição
    Brinches
    Pias – Serpa
    Vila Verde de Ficalho
    União das freguesias de Serpa (Salvador e Santa Maria)
    União das freguesias de Vila Nova de São Bento e Vale de Vargo
    Pedrógão – Vidigueira
    Selmes
    Vidigueira
    Vila de Frades
    Barreiros
    Bico
    Caires
    Carrazedo
    Dornelas – Amares
    Fiscal
    Goães
    Lago
    Rendufe
    Bouro (Santa Maria)
    Bouro (Santa Marta)
    União das freguesias de Amares e Figueiredo
    União das freguesias de Caldelas, Sequeiros e Paranhos
    União das freguesias de Ferreiros, Prozelo e Besteiros
    União das freguesias de Torre e Portela
    União das freguesias de Vilela, Seramil e Paredes Secas
    Abade de Neiva
    Aborim
    Adães
    Airó
    Aldreu
    Alvelos
    Arcozelo – Barcelos
    Areias
    Balugães
    Barcelinhos
    Barqueiros – Barcelos
    Cambeses – Barcelos
    Carapeços
    Carvalhal – Barcelos
    Carvalhas
    Cossourado
    Cristelo – Barcelos
    Fornelos – Barcelos
    Fragoso
    Gilmonde
    Lama
    Lijó
    Macieira de Rates
    Manhente
    Martim
    Moure – Barcelos
    Oliveira – Barcelos
    Palme
    Panque
    Paradela – Barcelos
    Pereira – Barcelos
    Perelhal
    Pousa
    Remelhe
    Roriz – Barcelos
    Rio Covo (Santa Eugénia)
    Galegos (Santa Maria)
    Galegos (São Martinho)
    Tamel (São Veríssimo)
    Silva
    Ucha
    Várzea – Barcelos
    Vila Seca
    União das freguesias de Alheira e Igreja Nova
    União das freguesias de Alvito (São Pedro e São Martinho) e Couto
    União das freguesias de Areias de Vilar e Encourados
    União das freguesias de Barcelos, Vila Boa e Vila Frescainha (São Martinho e São Pedro)
    União das freguesias de Campo e Tamel (São Pedro Fins)
    União das freguesias de Carreira e Fonte Coberta
    União das freguesias de Chorente, Góios, Courel, Pedra Furada e Gueral
    União das freguesias de Creixomil e Mariz
    União das freguesias de Durrães e Tregosa
    União das freguesias de Gamil e Midões
    Adaúfe
    Espinho – Braga
    Esporões
    Figueiredo
    Gualtar
    Lamas – Braga
    Mire de Tibães
    Padim da Graça
    Palmeira
    Pedralva
    Priscos
    Ruilhe
    Braga (São Vicente)
    Braga (São Vítor)
    Sequeira
    Sobreposta
    Tadim
    Tebosa
    União das freguesias de Arentim e Cunha
    União das freguesias de Braga (Maximinos, Sé e Cividade)
    União das freguesias de Braga (São José de São Lázaro e São João do Souto)
    União das freguesias de Cabreiros e Passos (São Julião)
    União das freguesias de Celeirós, Aveleda e Vimieiro
    União das freguesias de Crespos e Pousada
    União das freguesias de Escudeiros e Penso (Santo Estêvão e São Vicente)
    União das freguesias de Este (São Pedro e São Mamede)
    União das freguesias de Ferreiros e Gondizalves
    União das freguesias de Guisande e Oliveira (São Pedro)
    União das freguesias de Lomar e Arcos
    União das freguesias de Merelim (São Paio), Panoias e Parada de Tibães
    União das freguesias de Merelim (São Pedro) e Frossos
    União das freguesias de Morreira e Trandeiras
    União das freguesias de Nogueira, Fraião e Lamaçães
    União das freguesias de Nogueiró e Tenões
    União das freguesias de Real, Dume e Semelhe
    União das freguesias de Santa Lucrécia de Algeriz e Navarra
    União das freguesias de Vilaça e Fradelos
    Abadim
    Basto
    Bucos
    Cabeceiras de Basto
    Cavez
    Faia – Cabeceiras de Basto
    Pedraça
    Rio Douro
    União das freguesias de Alvite e Passos
    União das freguesias de Arco de Baúlhe e Vila Nune
    União das freguesias de Gondiães e Vilar de Cunhas
    União das freguesias de Refojos de Basto, Outeiro e Painzela
    Agilde
    Arnóia
    Borba de Montanha
    Codeçoso
    Fervença
    Moreira do Castelo
    Rego
    Ribas
    Basto (São Clemente)
    Vale de Bouro
    União das freguesias de Britelo, Gémeos e Ourilhe
    União das freguesias de Caçarilhe e Infesta
    União das freguesias de Canedo de Basto e Corgo
    União das freguesias de Carvalho e Basto (Santa Tecla)
    União das freguesias de Veade, Gagos e Molares
    Antas
    Forjães
    Gemeses
    Vila Chã – Esposende
    União das freguesias de Apúlia e Fão
    União das freguesias de Belinho e Mar
    União das freguesias de Esposende, Marinhas e Gandra
    União das freguesias de Fonte Boa e Rio Tinto
    União das freguesias de Palmeira de Faro e Curvos
    Armil
    Estorãos – Fafe
    Fafe
    Fornelos – Fafe
    Golães
    Medelo
    Passos – Fafe
    Quinchães
    Regadas
    Revelhe
    Ribeiros
    Arões (Santa Cristina)
    São Gens
    Silvares (São Martinho)
    Arões (São Romão)
    Travassós
    Vinhós
    União de freguesias de Aboim, Felgueiras, Gontim e Pedraído
    União de freguesias de Agrela e Serafão
    União de freguesias de Antime e Silvares (São Clemente)
    União de freguesias de Ardegão, Arnozela e Seidões
    União de freguesias de Cepães e Fareja
    União de freguesias de Freitas e Vila Cova
    União de freguesias de Monte e Queimadela
    União de freguesias de Moreira do Rei e Várzea Cova
    Aldão
    Azurém
    Barco
    Brito
    Caldelas
    Costa
    Creixomil
    Fermentões
    Gonça
    Gondar – Guimarães
    Guardizela
    Infantas
    Longos
    Lordelo – Guimarães
    Mesão Frio
    Moreira de Cónegos
    Nespereira – Guimarães
    Pencelo
    Pinheiro – Guimarães
    Polvoreira
    Ponte – Guimarães
    Ronfe
    Prazins (Santa Eufémia)
    Selho (São Cristóvão)
    Selho (São Jorge)
    Candoso (São Martinho)
    Sande (São Martinho)
    São Torcato
    Serzedelo – Guimarães
    Silvares – Guimarães
    Urgezes
    União das freguesias de Abação e Gémeos
    União das freguesias de Airão Santa Maria, Airão São João e Vermil
    União das freguesias de Arosa e Castelões
    União das freguesias de Atães e Rendufe
    União das freguesias de Briteiros Santo Estêvão e Donim
    União das freguesias de Briteiros São Salvador e Briteiros Santa Leocádia
    União das freguesias de Candoso São Tiago e Mascotelos
    União das freguesias de Conde e Gandarela
    União das freguesias de Leitões, Oleiros e Figueiredo
    União das freguesias de Oliveira, São Paio e São Sebastião
    União das freguesias de Prazins Santo Tirso e Corvite
    União das freguesias de Sande São Lourenço e Balazar
    União das freguesias de Sande Vila Nova e Sande São Clemente
    União das freguesias de Selho São Lourenço e Gominhães
    União das freguesias de Serzedo e Calvos
    União das freguesias de Souto Santa Maria, Souto São Salvador e Gondomar
    União das freguesias de Tabuadelo e São Faustino
    Covelas – Póvoa de Lanhoso
    Ferreiros
    Galegos – Póvoa de Lanhoso
    Garfe
    Geraz do Minho
    Lanhoso
    Monsul
    Póvoa de Lanhoso (Nossa Senhora do Amparo)
    Rendufinho
    Santo Emilião
    São João de Rei
    Serzedelo – Póvoa de Lanhoso
    Sobradelo da Goma
    Taíde
    Travassos
    Vilela – Póvoa de Lanhoso
    União das freguesias de Águas Santas e Moure
    União das freguesias de Calvos e Frades
    União das freguesias de Campos e Louredo
    União das freguesias de Esperança e Brunhais
    União das freguesias de Fonte Arcada e Oliveira
    União das freguesias de Verim, Friande e Ajude
    Balança
    Campo do Gerês
    Carvalheira
    Covide
    Gondoriz – Terras de Bouro
    Moimenta – Terras de Bouro
    Ribeira – Terras de Bouro
    Rio Caldo
    Souto – Terras de Bouro
    Valdosende
    Vilar da Veiga
    União das freguesias de Chamoim e Vilar
    União das freguesias de Chorense e Monte
    União das freguesias de Cibões e Brufe
    Cantelães
    Eira Vedra
    Guilhofrei
    Louredo – Vieira do Minho
    Mosteiro – Vieira do Minho
    Parada de Bouro
    Pinheiro – Vieira do Minho
    Rossas – Vieira do Minho
    Salamonde
    Tabuaças
    Vieira do Minho
    União das freguesias de Anissó e Soutelo
    União das freguesias de Anjos e Vilar do Chão
    União das freguesias de Caniçada e Soengas
    União das freguesias de Ruivães e Campos
    União das freguesias de Ventosa e Cova
    Bairro
    Brufe
    Castelões – Vila Nova de Famalicão
    Cruz
    Delães
    Fradelos
    Gavião
    Joane
    Landim
    Louro
    Lousado
    Mogege
    Nine
    Pedome
    Pousada de Saramagos
    Requião
    Riba de Ave
    Ribeirão
    Oliveira (Santa Maria)
    Vale (São Martinho)
    Oliveira (São Mateus)
    Vermoim
    Vilarinho das Cambas
    União das freguesias de Antas e Abade de Vermoim
    União das freguesias de Arnoso (Santa Maria e Santa Eulália) e Sezures
    União das freguesias de Avidos e Lagoa
    União das freguesias de Carreira e Bente
    União das freguesias de Esmeriz e Cabeçudos
    União das freguesias de Gondifelos, Cavalões e Outiz
    União das freguesias de Lemenhe, Mouquim e Jesufrei
    União das freguesias de Ruivães e Novais
    União das freguesias de Seide
    União das freguesias de Vale (São Cosme), Telhado e Portela
    União das freguesias de Vila Nova de Famalicão e Calendário
    Atiães
    Cabanelas – Vila Verde
    Cervães
    Coucieiro
    Dossãos
    Freiriz
    Gême
    Lage
    Lanhas
    Loureira
    Moure – Vila Verde
    Oleiros – Vila Verde
    Parada de Gatim
    Pico
    Ponte – Vila Verde
    Sabariz
    Vila de Prado
    Prado (São Miguel)
    Soutelo
    Turiz
    Valdreu
    Aboim da Nóbrega e Gondomar
    União das freguesias da Ribeira do Neiva
    União das freguesias de Carreiras (São Miguel) e Carreiras (Santiago)
    União das freguesias de Escariz (São Mamede) e Escariz (São Martinho)
    União das freguesias de Esqueiros, Nevogilde e Travassós
    União das freguesias de Marrancos e Arcozelo
    União das freguesias de Oriz (Santa Marinha) e Oriz (São Miguel)
    União das freguesias de Pico de Regalados, Gondiães e Mós
    União das freguesias de Sande, Vilarinho, Barros e Gomide
    União das freguesias de Valbom (São Pedro), Passô e Valbom (São Martinho)
    União das freguesias do Vade
    Vila Verde e Barbudo
    Santa Eulália – Vizela
    Infias – Vizela
    Vizela (Santo Adrião)
    União das freguesias de Caldas de Vizela (São Miguel e São João)
    União das freguesias de Tagilde e Vizela (São Paio)
    Alfândega da Fé
    Cerejais
    Sambade
    Vilar Chão
    Vilarelhos
    Vilares de Vilariça
    União das freguesias de Agrobom, Saldonha e Vale Pereiro
    União das freguesias de Eucisia, Gouveia e Valverde
    União das freguesias de Ferradosa e Sendim da Serra
    União das freguesias de Gebelim e Soeima
    União das freguesias de Parada e Sendim da Ribeira
    União das freguesias de Pombal e Vales
    Alfaião
    Babe
    Baçal
    Carragosa
    Castro de Avelãs
    Coelhoso
    Donai
    Espinhosela
    França
    Gimonde
    Gondesende
    Gostei
    Grijó de Parada
    Macedo do Mato
    Mós – Bragança
    Nogueira – Bragança
    Outeiro – Bragança
    Parâmio
    Pinela
    Quintanilha
    Quintela de Lampaças
    Rabal
    Rebordãos
    Salsas
    Samil
    Santa Comba de Rossas
    São Pedro de Sarracenos
    Sendas
    Serapicos – Bragança
    Sortes
    Zoio
    União das freguesias de Aveleda e Rio de Onor
    União das freguesias de Castrelos e Carrazedo
    União das freguesias de Izeda, Calvelhe e Paradinha Nova
    União das freguesias de Parada e Faílde
    União das freguesias de Rebordainhos e Pombares
    União das freguesias de Rio Frio e Milhão
    União das freguesias de São Julião de Palácios e Deilão
    União das freguesias de Sé, Santa Maria e Meixedo
    Carrazeda de Ansiães
    Fonte Longa
    Linhares – Carrazeda de Ansiães
    Marzagão
    Parambos
    Pereiros
    Pinhal do Norte
    Pombal – Carrazeda de Ansiães
    Seixo de Ansiães
    Vilarinho da Castanheira
    União das freguesias de Amedo e Zedes
    União das freguesias de Belver e Mogo de Malta
    União das freguesias de Castanheiro do Norte e Ribalonga
    União das freguesias de Lavandeira, Beira Grande e Selores
    Ligares
    Poiares – Freixo de Espada À Cinta
    União das freguesias de Freixo de Espada à Cinta e Mazouco
    União das freguesias de Lagoaça e Fornos
    Amendoeira
    Arcas
    Carrapatas
    Chacim
    Cortiços
    Corujas
    Ferreira – Macedo de Cavaleiros
    Grijó
    Lagoa
    Lamalonga
    Lamas – Macedo de Cavaleiros
    Lombo
    Macedo de Cavaleiros
    Morais
    Olmos
    Peredo
    Salselas
    Sezulfe
    Talhas
    Vale Benfeito
    Vale da Porca
    Vale de Prados
    Vilarinho de Agrochão
    Vinhas
    União das freguesias de Ala e Vilarinho do Monte
    União das freguesias de Bornes e Burga
    União das freguesias de Castelãos e Vilar do Monte
    União das freguesias de Espadanedo, Edroso, Murçós e Soutelo Mourisco
    União das freguesias de Podence e Santa Combinha
    União das freguesias de Talhinhas e Bagueixe
    Duas Igrejas – Miranda do Douro
    Genísio
    Malhadas
    Miranda do Douro
    Palaçoulo
    Picote
    Póvoa
    São Martinho de Angueira
    Vila Chã de Braciosa
    União das freguesias de Constantim e Cicouro
    União das freguesias de Ifanes e Paradela
    União das freguesias de Sendim e Atenor
    União das freguesias de Silva e Águas Vivas
    Abambres
    Abreiro
    Aguieiras
    Alvites
    Bouça
    Cabanelas – Mirandela
    Caravelas
    Carvalhais
    Cedães
    Cobro
    Fradizela
    Frechas
    Lamas de Orelhão
    Mascarenhas
    Mirandela
    Múrias
    Passos – Mirandela
    São Pedro Velho
    São Salvador
    Suçães
    Torre de Dona Chama
    Vale de Asnes
    Vale de Gouvinhas
    Vale de Salgueiro
    Vale de Telhas
    União das freguesias de Avantos e Romeu
    União das freguesias de Avidagos, Navalho e Pereira
    União das freguesias de Barcel, Marmelos e Valverde da Gestosa
    União das freguesias de Franco e Vila Boa
    União das freguesias de Freixeda e Vila Verde
    Azinhoso
    Bemposta – Mogadouro
    Bruçó
    Brunhoso
    Castelo Branco – Mogadouro
    Castro Vicente
    Meirinhos
    Paradela – Mogadouro
    Penas Roias
    Peredo da Bemposta
    Saldanha
    São Martinho do Peso
    Tó
    Travanca – Mogadouro
    Urrós
    Vale da Madre
    Vila de Ala
    União das freguesias de Brunhozinho, Castanheira e Sanhoane
    União das freguesias de Mogadouro, Valverde, Vale de Porco e Vilar de Rei
    União das freguesias de Remondes e Soutelo
    União das freguesias de Vilarinho dos Galegos e Ventozelo
    Açoreira
    Cabeça Boa
    Carviçais
    Castedo
    Horta da Vilariça
    Larinho
    Lousa – Torre de Moncorvo
    Mós – Torre de Moncorvo
    Torre de Moncorvo
    União das freguesias de Adeganha e Cardanha
    União das freguesias de Felgar e Souto da Velha
    União das freguesias de Felgueiras e Maçores
    União das freguesias de Urros e Peredo dos Castelhanos
    Benlhevai
    Freixiel
    Roios
    Samões
    Sampaio
    Santa Comba de Vilariça
    Seixo de Manhoses
    Trindade
    Vale Frechoso
    União das freguesias de Assares e Lodões
    União das freguesias de Candoso e Carvalho de Egas
    União das freguesias de Valtorno e Mourão
    União das freguesias de Vila Flor e Nabo
    União das freguesias de Vilas Boas e Vilarinho das Azenhas
    Argozelo
    Carção
    Matela
    Pinelo
    Santulhão
    Vilar Seco – Vimioso
    Vimioso
    União das freguesias de Algoso, Campo de Víboras e Uva
    União das freguesias de Caçarelhos e Angueira
    União das freguesias de Vale de Frades e Avelanoso
    Agrochão
    Candedo – Vinhais
    Celas
    Edral
    Edrosa
    Ervedosa – Vinhais
    Paçó
    Penhas Juntas
    Rebordelo – Vinhais
    Santalha
    Tuizelo
    Vale das Fontes
    Vila Boa de Ousilhão
    Vila Verde – Vinhais
    Vilar de Ossos
    Vilar de Peregrinos
    Vilar Seco de Lomba
    Vinhais
    União das freguesias de Curopos e Vale de Janeiro
    União das freguesias de Moimenta e Montouto
    União das freguesias de Nunes e Ousilhão
    União das freguesias de Quirás e Pinheiro Novo
    União das freguesias de Sobreiró de Baixo e Alvaredos
    União das freguesias de Soeira, Fresulfe e Mofreita
    União das freguesias de Travanca e Santa Cruz
    União das freguesias de Vilar de Lomba e São Jomil
    Caria – Belmonte
    Inguias
    Maçainhas – Belmonte
    União das freguesias de Belmonte e Colmeal da Torre
    Alcains
    Almaceda
    Benquerenças
    Castelo Branco – Castelo Branco
    Lardosa
    Louriçal do Campo
    Malpica do Tejo
    Monforte da Beira
    Salgueiro do Campo
    Santo André das Tojeiras
    São Vicente da Beira
    Sarzedas
    Tinalhas
    União das freguesias de Cebolais de Cima e Retaxo
    União das freguesias de Escalos de Baixo e Mata
    União das freguesias de Escalos de Cima e Lousa
    União das freguesias de Freixial e Juncal do Campo
    União das freguesias de Ninho do Açor e Sobral do Campo
    União das freguesias de Póvoa de Rio de Moinhos e Cafede
    Aldeia de São Francisco de Assis
    Boidobra
    Cortes do Meio
    Dominguizo
    Erada
    Ferro
    Orjais
    Paul
    Peraboa
    São Jorge da Beira
    Sobral de São Miguel
    Tortosendo
    Unhais da Serra
    Verdelhos
    União das freguesias de Barco e Coutada
    União das freguesias de Cantar-Galo e Vila do Carvalho
    União das freguesias de Casegas e Ourondo
    União das freguesias de Covilhã e Canhoso
    União das freguesias de Peso e Vales do Rio
    União das freguesias de Teixoso e Sarzedo
    União das freguesias de Vale Formoso e Aldeia do Souto
    Alcaide
    Alcaria
    Alcongosta
    Alpedrinha
    Barroca
    Bogas de Cima
    Capinha
    Castelejo
    Castelo Novo
    Fatela
    Lavacolhos
    Orca
    Pêro Viseu
    Silvares – Fundão
    Soalheira
    Souto da Casa
    Telhado
    Enxames
    Três Povos
    União das freguesias de Janeiro de Cima e Bogas de Baixo
    União das freguesias de Fundão, Valverde, Donas, Aldeia de Joanes e Aldeia Nova do Cabo
    União das freguesias de Póvoa de Atalaia e Atalaia do Campo
    União das freguesias de Vale de Prazeres e Mata da Rainha
    Aldeia de Santa Margarida
    Ladoeiro
    Medelim
    Oledo
    Penha Garcia
    Proença-a-Velha
    Rosmaninhal
    São Miguel de Acha
    Toulões
    União das freguesias de Idanha-a-Nova e Alcafozes
    União das freguesias de Monfortinho e Salvaterra do Extremo
    União das freguesias de Monsanto e Idanha-a-Velha
    União das freguesias de Zebreira e Segura
    Álvaro
    Cambas
    Isna
    Madeirã
    Mosteiro – Oleiros
    Orvalho
    Sarnadas de São Simão
    Sobral – Oleiros
    Estreito-Vilar Barroco
    Oleiros-Amieira
    Aranhas
    Benquerença
    Meimão
    Meimoa
    Penamacor
    Salvador
    Vale da Senhora da Póvoa
    União das freguesias de Aldeia do Bispo, Águas e Aldeia de João Pires
    União das freguesias de Pedrógão de São Pedro e Bemposta
    Montes da Senhora
    São Pedro do Esteval
    União das freguesias de Proença-a-Nova e Peral
    União das freguesias de Sobreira Formosa e Alvito da Beira
    Cabeçudo
    Carvalhal – Sertã
    Castelo – Sertã
    Pedrógão Pequeno
    Sertã
    Troviscal
    Várzea dos Cavaleiros
    União das freguesias de Cernache do Bonjardim, Nesperal e Palhais
    União das freguesias de Cumeada e Marmeleiro
    União das freguesias de Ermida e Figueiredo
    Fundada
    São João do Peso
    Vila de Rei
    Fratel
    Perais
    Sarnadas de Ródão
    Vila Velha de Ródão
    Arganil
    Benfeita
    Celavisa
    Folques
    Piódão
    Pomares
    Pombeiro da Beira
    São Martinho da Cortiça
    Sarzedo – Arganil
    Secarias
    União das freguesias de Cepos e Teixeira
    União das freguesias de Cerdeira e Moura da Serra
    União das freguesias de Côja e Barril de Alva
    União das freguesias de Vila Cova de Alva e Anseriz
    Ançã
    Cadima
    Cordinhã
    Febres
    Murtede
    Ourentã
    Tocha
    São Caetano
    Sanguinheira
    União das freguesias de Cantanhede e Pocariça
    União das freguesias de Covões e Camarneira
    União das freguesias de Portunhos e Outil
    União das freguesias de Sepins e Bolho
    União das freguesias de Vilamar e Corticeiro de Cima
    Almalaguês
    Brasfemes
    Ceira
    Cernache
    Santo António dos Olivais
    São João do Campo
    São Silvestre
    Torres do Mondego
    União das freguesias de Antuzede e Vil de Matos
    União das freguesias de Assafarge e Antanhol
    União das freguesias de Coimbra (Sé Nova, Santa Cruz, Almedina e São Bartolomeu)
    União das freguesias de Eiras e São Paulo de Frades
    União das freguesias de Santa Clara e Castelo Viegas
    União das freguesias de São Martinho de Árvore e Lamarosa
    União das freguesias de São Martinho do Bispo e Ribeira de Frades
    União das freguesias de Souselas e Botão
    União das freguesias de Taveiro, Ameal e Arzila
    União das freguesias de Trouxemil e Torre de Vilela
    Anobra
    Ega
    Furadouro
    Zambujal
    União das freguesias de Condeixa-a-Velha e Condeixa-a-Nova
    União das freguesias de Sebal e Belide
    União das freguesias de Vila Seca e Bem da Fé
    Alqueidão
    Maiorca
    Marinha das Ondas
    Tavarede
    Vila Verde – Figueira da Foz
    São Pedro
    Bom Sucesso
    Moinhos da Gândara
    Alhadas
    Buarcos e São Julião
    Ferreira-a-Nova
    Lavos
    Paião
    Quiaios
    Alvares
    Góis
    Vila Nova do Ceira
    União das freguesias de Cadafaz e Colmeal
    Serpins
    Gândaras
    União das freguesias de Foz de Arouce e Casal de Ermio
    União das freguesias de Lousã e Vilarinho
    Mira
    Seixo
    Carapelhos
    Praia de Mira
    Lamas – Miranda do Corvo
    Miranda do Corvo
    Vila Nova
    União das freguesias de Semide e Rio Vide
    Arazede
    Carapinheira
    Liceia
    Meãs do Campo
    Pereira – Montemor-O-Velho
    Santo Varão
    Seixo de Gatões
    Tentúgal
    Ereira
    União das freguesias de Abrunheira, Verride e Vila Nova da Barca
    União das freguesias de Montemor-o-Velho e Gatões
    Aldeia das Dez
    Alvoco das Várzeas
    Avô
    Bobadela
    Lagares
    Lourosa – Oliveira do Hospital
    Meruge
    Nogueira do Cravo
    São Gião
    Seixo da Beira
    Travanca de Lagos
    União das freguesias de Ervedal e Vila Franca da Beira
    União das freguesias de Lagos da Beira e Lajeosa
    União das freguesias de Oliveira do Hospital e São Paio de Gramaços
    União das freguesias de Penalva de Alva e São Sebastião da Feira
    União das freguesias de Santa Ovaia e Vila Pouca da Beira
    Cabril – Pampilhosa da Serra
    Dornelas do Zêzere
    Janeiro de Baixo
    Pampilhosa da Serra
    Pessegueiro
    Unhais-o-Velho
    Fajão-Vidual
    Portela do Fojo-Machio
    Carvalho
    Figueira de Lorvão
    Lorvão
    Penacova – Penacova
    Sazes do Lorvão
    União das freguesias de Friúmes e Paradela
    União das freguesias de Oliveira do Mondego e Travanca do Mondego
    União das freguesias de São Pedro de Alva e São Paio de Mondego
    Cumeeira
    Espinhal
    Podentes
    União das freguesias de São Miguel, Santa Eufémia e Rabaçal
    Alfarelos
    Figueiró do Campo
    Granja do Ulmeiro
    Samuel
    Soure
    Tapéus
    Vila Nova de Anços
    Vinha da Rainha
    União das freguesias de Degracias e Pombalinho
    União das freguesias de Gesteira e Brunhós
    Candosa
    Carapinha
    Midões
    Mouronho
    Póvoa de Midões
    São João da Boa Vista
    Tábua
    União das freguesias de Ázere e Covelo
    União das freguesias de Covas e Vila Nova de Oliveirinha
    União das freguesias de Espariz e Sinde
    União das freguesias de Pinheiro de Coja e Meda de Mouros
    Arrifana – Vila Nova de Poiares
    Lavegadas
    Poiares (Santo André)
    São Miguel de Poiares
    Santiago Maior – Alandroal
    Capelins (Santo António)
    Terena (São Pedro)
    União das freguesias de Alandroal (Nossa Senhora da Conceição), São Brás dos Matos (Mina do Bugalho) e Juromenha (Nossa Senhora do Loreto)
    Arraiolos
    Igrejinha
    Vimieiro
    União das freguesias de Gafanhoeira (São Pedro) e Sabugueiro
    União das freguesias de São Gregório e Santa Justa
    Borba (Matriz)
    Orada
    Rio de Moinhos – Borba
    Borba (São Bartolomeu)
    Arcos – Estremoz
    Glória
    Évora Monte (Santa Maria)
    São Domingos de Ana Loura
    Veiros
    União das freguesias de Estremoz (Santa Maria e Santo André)
    União das freguesias de São Bento do Cortiço e Santo Estêvão
    União das freguesias de São Lourenço de Mamporcão e São Bento de Ana Loura
    União das freguesias do Ameixial (Santa Vitória e São Bento)
    Nossa Senhora da Graça do Divor
    Nossa Senhora de Machede
    São Bento do Mato
    São Miguel de Machede
    Torre de Coelheiros
    Canaviais
    União das freguesias de Bacelo e Senhora da Saúde
    União das freguesias de Évora (São Mamede, Sé, São Pedro e Santo Antão)
    União das freguesias de Malagueira e Horta das Figueiras
    União das freguesias de Nossa Senhora da Tourega e Nossa Senhora de Guadalupe
    União das freguesias de São Manços e São Vicente do Pigeiro
    União das freguesias de São Sebastião da Giesteira e Nossa Senhora da Boa Fé
    Cabrela
    Santiago do Escoural
    São Cristóvão
    Ciborro
    Foros de Vale de Figueira
    União das freguesias de Cortiçadas de Lavre e Lavre
    União das freguesias de Nossa Senhora da Vila, Nossa Senhora do Bispo e Silveiras
    Brotas
    Cabeção
    Mora
    Pavia
    Granja – Mourão
    Luz – Mourão
    Mourão
    Monte do Trigo
    Portel
    Santana – Portel
    Vera Cruz
    União das freguesias de Amieira e Alqueva
    União das freguesias de São Bartolomeu do Outeiro e Oriola
    Montoito
    Redondo
    Corval
    Monsaraz
    Reguengos de Monsaraz
    União das freguesias de Campo e Campinho
    Vendas Novas
    Landeira
    Alcáçovas
    Viana do Alentejo
    Aguiar
    Bencatel
    Ciladas
    Pardais
    Nossa Senhora da Conceição e São Bartolomeu
    Guia
    Paderne – Albufeira
    Ferreiras
    Albufeira e Olhos de Água
    Giões
    Martim Longo
    Vaqueiros
    União das freguesias de Alcoutim e Pereiro
    Aljezur
    Bordeira
    Odeceixe
    Rogil
    Azinhal
    Castro Marim
    Odeleite
    Altura
    Santa Bárbara de Nexe
    Montenegro
    União das freguesias de Conceição e Estoi
    União das freguesias de Faro (Sé e São Pedro)
    Ferragudo
    Porches
    União das freguesias de Estômbar e Parchal
    União das freguesias de Lagoa e Carvoeiro
    Luz – Lagos
    Odiáxere
    União das freguesias de Bensafrim e Barão de São João
    São Gonçalo de Lagos
    Almancil
    Alte
    Ameixial
    Boliqueime
    Quarteira
    Salir
    Loulé (São Clemente)
    Loulé (São Sebastião)
    União de freguesias de Querença, Tôr e Benafim
    Alferce
    Marmelete
    Monchique
    Olhão
    Pechão
    Quelfes
    União das freguesias de Moncarapacho e Fuseta
    Alvor
    Mexilhoeira Grande
    Portimão
    São Brás de Alportel
    Armação de Pêra
    São Bartolomeu de Messines
    São Marcos da Serra
    Silves
    União das freguesias de Alcantarilha e Pêra
    União das freguesias de Algoz e Tunes
    Cachopo
    Santa Catarina da Fonte do Bispo
    Santa Luzia
    União das freguesias de Conceição e Cabanas de Tavira
    União das freguesias de Luz de Tavira e Santo Estêvão
    União das freguesias de Tavira (Santa Maria e Santiago)
    Barão de São Miguel
    Budens
    Sagres
    Vila do Bispo e Raposeira
    Vila Nova de Cacela
    Vila Real de Santo António
    Monte Gordo
    Carapito
    Cortiçada
    Dornelas – Aguiar da Beira
    Eirado
    Forninhos
    Pena Verde
    Pinheiro – Aguiar da Beira
    União das freguesias de Aguiar da Beira e Coruche
    União das freguesias de Sequeiros e Gradiz
    União das freguesias de Souto de Aguiar da Beira e Valverde
    Almeida
    Castelo Bom
    Freineda
    Freixo
    Malhada Sorda
    Nave de Haver
    São Pedro de Rio Seco
    Vale da Mula
    Vilar Formoso
    União das freguesias de Amoreira, Parada e Cabreira
    União das freguesias de Azinhal, Peva e Vale Verde
    União das freguesias de Castelo Mendo, Ade, Monteperobolso e Mesquitela
    União das freguesias de Junça e Naves
    União das freguesias de Leomil, Mido, Senouras e Aldeia Nova
    União das freguesias de Malpartida e Vale de Coelha
    União das freguesias de Miuzela e Porto de Ovelha
    Baraçal – Celorico da Beira
    Carrapichana
    Forno Telheiro
    Lajeosa do Mondego
    Linhares – Celorico da Beira
    Maçal do Chão
    Mesquitela
    Minhocal
    Prados
    Ratoeira
    Vale de Azares
    Casas do Soeiro
    União das freguesias de Açores e Velosa
    União das freguesias de Celorico (São Pedro e Santa Maria) e Vila Boa do Mondego
    União das freguesias de Cortiçô da Serra, Vide entre Vinhas e Salgueirais
    União das freguesias de Rapa e Cadafaz
    Castelo Rodrigo
    Escalhão
    Figueira de Castelo Rodrigo
    Mata de Lobos
    Vermiosa
    União das freguesias de Algodres, Vale de Afonsinho e Vilar de Amargo
    União das freguesias de Almofala e Escarigo
    União das freguesias de Cinco Vilas e Reigada
    União das freguesias de Freixeda do Torrão, Quintã de Pêro Martins e Penha de Águia
    União das freguesias do Colmeal e Vilar Torpim
    Algodres
    Casal Vasco
    Figueiró da Granja
    Fornos de Algodres
    Infias – Fornos de Algodres
    Maceira – Fornos de Algodres
    Matança
    Muxagata – Fornos de Algodres
    Queiriz
    União das freguesias de Cortiçô e Vila Chã
    União das freguesias de Juncais, Vila Ruiva e Vila Soeiro do Chão
    União das freguesias de Sobral Pichorro e Fuinhas
    Arcozelo – Gouveia
    Cativelos
    Folgosinho
    Nespereira – Gouveia
    Paços da Serra
    Ribamondego
    São Paio – Gouveia
    Vila Cortês da Serra
    Vila Franca da Serra
    Vila Nova de Tazem
    União das freguesias de Aldeias e Mangualde da Serra
    União das freguesias de Figueiró da Serra e Freixo da Serra
    Gouveia
    União das freguesias de Melo e Nabais
    União das freguesias de Moimenta da Serra e Vinhó
    União das freguesias de Rio Torto e Lagarinhos
    Aldeia do Bispo – Guarda
    Aldeia Viçosa
    Alvendre
    Arrifana – Guarda
    Avelãs da Ribeira
    Benespera
    Casal de Cinza
    Castanheira – Guarda
    Cavadoude
    Codesseiro
    Faia – Guarda
    Famalicão – Guarda
    Fernão Joanes
    Gonçalo Bocas
    João Antão
    Maçainhas – Guarda
    Marmeleiro
    Meios
    Panoias de Cima
    Pega
    Pêra do Moço
    Porto da Carne
    Ramela
    Santana da Azinha
    Sobral da Serra
    Vale de Estrela
    Valhelhas
    Vela
    Videmonte
    Vila Cortês do Mondego
    Vila Fernando
    Vila Franca do Deão
    Vila Garcia
    Gonçalo
    Guarda
    Jarmelo São Miguel
    Jarmelo São Pedro
    União de freguesias de Avelãs de Ambom e Rocamondo
    União de freguesias de Corujeira e Trinta
    União de freguesias de Mizarela, Pêro Soares e Vila Soeiro
    União de freguesias de Pousade e Albardo
    União de freguesias de Rochoso e Monte Margarida
    Adão
    Sameiro
    Manteigas (Santa Maria)
    Manteigas (São Pedro)
    Vale de Amoreira
    Aveloso
    Barreira
    Coriscada
    Longroiva
    Marialva
    Poço do Canto
    Rabaçal
    Ranhados – Mêda
    Mêda, Outeiro de Gatos e Fonte Longa
    Prova e Casteição
    União das freguesias de Vale Flor, Carvalhal e Pai Penela
    Ervedosa – Pinhel
    Freixedas
    Lamegal
    Lameiras
    Manigoto
    Pala – Pinhel
    Pinhel
    Pínzio
    Souro Pires
    Vascoveiro
    Agregação das freguesias Sul de Pinhel
    Alverca da Beira/Bouça Cova
    Terras de Massueime
    Valbom/Bogalhal
    Alto do Palurdo
    Vale do Côa
    Vale do Massueime
    União das freguesias de Atalaia e Safurdão
    Águas Belas – Sabugal
    Aldeia do Bispo – Sabugal
    Aldeia da Ponte
    Aldeia Velha – Sabugal
    Alfaiates
    Baraçal – Sabugal
    Bendada
    Bismula
    Casteleiro
    Cerdeira
    Fóios
    Malcata
    Nave
    Quadrazais
    Quintas de São Bartolomeu
    Rapoula do Côa
    Rebolosa
    Rendo
    Sortelha
    Souto – Sabugal
    Vale de Espinho
    Vila Boa
    Vila do Touro
    União das freguesias de Aldeia da Ribeira, Vilar Maior e Badamalos
    União das freguesias de Lajeosa e Forcalhos
    União das freguesias de Pousafoles do Bispo, Pena Lobo e Lomba
    União das freguesias de Ruvina, Ruivós e Vale das Éguas
    União das freguesias do Sabugal e Aldeia de Santo António
    União das freguesias de Santo Estêvão e Moita
    União das freguesias de Seixo do Côa e Vale Longo
    Alvoco da Serra
    Girabolhos
    Loriga
    Paranhos – Seia
    Pinhanços
    Sabugueiro
    Sandomil
    Santa Comba – Seia
    Santiago
    Sazes da Beira
    Teixeira
    Travancinha
    Valezim
    Vila Cova à Coelheira – Seia
    União das freguesias de Carragozela e Várzea de Meruge
    União das freguesias de Sameice e Santa Eulália
    União das freguesias de Santa Marinha e São Martinho
    União das freguesias de Seia, São Romão e Lapa dos Dinheiros
    União das freguesias de Torrozelo e Folhadosa
    União das freguesias de Tourais e Lajes
    União das freguesias de Vide e Cabeça
    Aldeia Nova
    Castanheira – Trancoso
    Cogula
    Cótimos
    Fiães – Trancoso
    Granja – Trancoso
    Guilheiro
    Moimentinha
    Moreira de Rei
    Palhais
    Póvoa do Concelho
    Reboleiro
    Rio de Mel
    Tamanhos
    Valdujo
    União das freguesias de Freches e Torres
    União das freguesias de Torre do Terrenho, Sebadelhe da Serra e Terrenho
    União das freguesias de Trancoso (São Pedro e Santa Maria) e Souto Maior
    União das freguesias de Vale do Seixo e Vila Garcia
    União das freguesias de Vila Franca das Naves e Feital
    União das freguesias de Vilares e Carnicães
    Almendra
    Castelo Melhor
    Cedovim
    Chãs
    Custóias
    Horta
    Muxagata – Vila Nova de Foz Côa
    Numão
    Santa Comba – Vila Nova de Foz Côa
    Sebadelhe
    Seixas – Vila Nova de Foz Côa
    Touça
    Freixo de Numão
    Vila Nova de Foz Côa
    Alfeizerão
    Bárrio
    Benedita
    Cela
    Évora de Alcobaça
    Maiorga
    São Martinho do Porto
    Turquel
    Vimeiro – Alcobaça
    Aljubarrota
    União das freguesias de Alcobaça e Vestiaria
    União das freguesias de Coz, Alpedriz e Montes
    União das freguesias de Pataias e Martingança
    Almoster – Alvaiázere
    Maçãs de Dona Maria
    Pelmá
    Alvaiázere
    Pussos São Pedro
    Alvorge
    Avelar
    Chão de Couce
    Pousaflores
    Santiago da Guarda
    Ansião
    Batalha
    Reguengo do Fetal
    São Mamede
    Golpilheira
    Carvalhal – Bombarral
    Roliça
    Pó
    União das freguesias do Bombarral e Vale Covo
    A dos Francos
    Alvorninha
    Carvalhal Benfeito
    Foz do Arelho
    Landal
    Nadadouro
    Salir de Matos
    Santa Catarina
    Vidais
    União das freguesias de Caldas da Rainha - Nossa Senhora do Pópulo, Coto e São Gregório
    União das freguesias de Caldas da Rainha - Santo Onofre e Serra do Bouro
    União das freguesias de Tornada e Salir do Porto
    União das freguesias de Castanheira de Pêra e Coentral
    Aguda
    Arega
    Campelo
    União das freguesias de Figueiró dos Vinhos e Bairradas
    Amor
    Arrabal
    Caranguejeira
    Coimbrão
    Maceira – Leiria
    Milagres
    Regueira de Pontes
    Bajouca
    Bidoeira de Cima
    União das freguesias de Colmeias e Memória
    União das freguesias de Leiria, Pousos, Barreira e Cortes
    União das freguesias de Marrazes e Barosa
    União das freguesias de Monte Real e Carvide
    União das freguesias de Monte Redondo e Carreira
    União das freguesias de Parceiros e Azoia
    União das freguesias de Santa Catarina da Serra e Chainça
    União das freguesias de Santa Eufémia e Boa Vista
    União das freguesias de Souto de Carpalhosa e Ortigosa
    Marinha Grande
    Vieira de Leiria
    Moita – Marinha Grande
    Famalicão – Nazaré
    Nazaré
    Valado dos Frades
    A dos Negros
    Amoreira
    Olho Marinho
    Vau
    Gaeiras
    Usseira
    Santa Maria, São Pedro e Sobral da Lagoa
    Graça
    Pedrógão Grande
    Vila Facaia
    Atouguia da Baleia
    Serra d'El-Rei
    Ferrel
    Peniche
    Abiul
    Almagreira
    Carnide – Pombal
    Carriço
    Louriçal
    Pelariga
    Pombal – Pombal
    Redinha
    Vermoil
    Vila Cã
    Meirinhas
    União das freguesias de Guia, Ilha e Mata Mourisca
    União das freguesias de Santiago e São Simão de Litém e Albergaria dos Doze
    Alqueidão da Serra
    Calvaria de Cima
    Juncal
    Mira de Aire
    Pedreiras
    São Bento
    Serro Ventoso
    Porto de Mós - São João Baptista e São Pedro
    União das freguesias de Alvados e Alcaria
    União das freguesias de Arrimal e Mendiga
    Carnota
    Meca
    Olhalvo
    Ota
    Ventosa – Alenquer
    Vila Verde dos Francos
    União das freguesias de Abrigada e Cabanas de Torres
    União das freguesias de Aldeia Galega da Merceana e Aldeia Gavinha
    União das freguesias de Alenquer (Santo Estêvão e Triana)
    União das freguesias de Carregado e Cadafais
    União das freguesias de Ribafria e Pereiro de Palhacana
    Arranhó
    Arruda dos Vinhos
    Cardosas
    S. Tiago dos Velhos
    Alcoentre
    Aveiras de Baixo
    Aveiras de Cima
    Azambuja
    Vale do Paraíso
    Vila Nova da Rainha
    União das freguesias de Manique do Intendente, Vila Nova de São Pedro e Maçussa
    Alguber
    Peral
    Vermelha
    Vilar – Cadaval
    União das freguesias do Cadaval e Pêro Moniz
    União das freguesias de Lamas e Cercal
    União das freguesias de Painho e Figueiros
    Alcabideche
    São Domingos de Rana
    União das freguesias de Carcavelos e Parede
    União das freguesias de Cascais e Estoril
    Ajuda
    Alcântara
    Beato
    Benfica
    Campolide
    Carnide – Lisboa
    Lumiar
    Marvila
    Olivais
    São Domingos de Benfica
    Alvalade – Lisboa
    Areeiro
    Arroios – Lisboa
    Avenidas Novas
    Belém
    Campo de Ourique
    Estrela
    Misericórdia
    Parque das Nações
    Penha de França
    Santa Clara
    Santa Maria Maior – Lisboa
    Santo António
    São Vicente – Lisboa
    Bucelas
    Fanhões
    Loures
    Lousa – Loures
    União das freguesias de Moscavide e Portela
    União das freguesias de Sacavém e Prior Velho
    União das freguesias de Santa Iria de Azoia, São João da Talha e Bobadela
    União das freguesias de Santo Antão e São Julião do Tojal
    União das freguesias de Santo António dos Cavaleiros e Frielas
    União das freguesias de Camarate, Unhos e Apelação
    Moita dos Ferreiros
    Reguengo Grande
    Santa Bárbara
    Vimeiro – Lourinhã
    Ribamar
    União das freguesias de Lourinhã e Atalaia
    União das freguesias de Miragaia e Marteleira
    União das freguesias de São Bartolomeu dos Galegos e Moledo
    Carvoeira
    Encarnação
    Ericeira
    Mafra
    Milharado
    Santo Isidoro
    União das freguesias de Azueira e Sobral da Abelheira
    União das freguesias de Enxara do Bispo, Gradil e Vila Franca do Rosário
    União das freguesias de Igreja Nova e Cheleiros
    União das freguesias de Malveira e São Miguel de Alcainça
    União das freguesias de Venda do Pinheiro e Santo Estêvão das Galés
    Barcarena
    Porto Salvo
    União das freguesias de Algés, Linda-a-Velha e Cruz Quebrada-Dafundo
    União das freguesias de Carnaxide e Queijas
    União das freguesias de Oeiras e São Julião da Barra, Paço de Arcos e Caxias
    Algueirão-Mem Martins
    Colares
    Rio de Mouro
    Casal de Cambra
    União das freguesias de Agualva e Mira-Sintra
    União das freguesias de Almargem do Bispo, Pêro Pinheiro e Montelavar
    União das freguesias do Cacém e São Marcos
    União das freguesias de Massamá e Monte Abraão
    União das freguesias de Queluz e Belas
    União das freguesias de São João das Lampas e Terrugem
    União das freguesias de Sintra (Santa Maria e São Miguel, São Martinho e São Pedro de Penaferrim)
    Santo Quintino
    Sapataria
    Sobral de Monte Agraço
    Freiria
    Ponte do Rol
    Ramalhal
    São Pedro da Cadeira
    Silveira
    Turcifal
    Ventosa – Torres Vedras
    União das freguesias de A dos Cunhados e Maceira
    União das freguesias de Campelos e Outeiro da Cabeça
    União das freguesias de Carvoeira e Carmões
    União das freguesias de Dois Portos e Runa
    União das freguesias de Maxial e Monte Redondo
    Santa Maria, São Pedro e Matacães
    Vialonga
    Vila Franca de Xira
    União das freguesias de Alhandra, São João dos Montes e Calhandriz
    União das freguesias de Alverca do Ribatejo e Sobralinho
    União das freguesias de Castanheira do Ribatejo e Cachoeiras
    União das freguesias de Póvoa de Santa Iria e Forte da Casa
    Alfragide
    Águas Livres
    Encosta do Sol
    Falagueira-Venda Nova
    Mina de Água
    Venteira
    Odivelas – Odivelas
    União das freguesias de Pontinha e Famões
    União das freguesias de Póvoa de Santo Adrião e Olival de Basto
    União das freguesias de Ramada e Caneças
    Alter do Chão
    Chancelaria – Alter do Chão
    Seda
    Cunheira
    Assunção
    Esperança
    Mosteiros
    Aldeia Velha – Avis
    Avis
    Ervedal
    Figueira e Barros
    União das freguesias de Alcórrego e Maranhão
    União das freguesias de Benavila e Valongo
    Nossa Senhora da Expectação
    Nossa Senhora da Graça dos Degolados
    São João Baptista – Campo Maior
    Nossa Senhora da Graça de Póvoa e Meadas
    Santa Maria da Devesa
    Santiago Maior – Castelo de Vide
    São João Baptista – Castelo de Vide
    Aldeia da Mata
    Gáfete
    Monte da Pedra
    União das freguesias de Crato e Mártires, Flor da Rosa e Vale do Peso
    Santa Eulália – Elvas
    São Brás e São Lourenço
    São Vicente e Ventosa
    Assunção, Ajuda, Salvador e Santo Ildefonso
    Caia, São Pedro e Alcáçova
    União das freguesias de Barbacena e Vila Fernando
    União das freguesias de Terrugem e Vila Boim
    Cabeço de Vide
    Fronteira
    São Saturnino
    Belver
    Comenda
    Margem
    União das freguesias de Gavião e Atalaia
    Beirã
    Santa Maria de Marvão
    Santo António das Areias
    São Salvador da Aramenha
    Assumar
    Monforte
    Santo Aleixo
    Vaiamonte
    Alpalhão
    Montalvão
    Santana – Nisa
    São Matias – Nisa
    Tolosa
    União das freguesias de Arez e Amieira do Tejo
    União das freguesias de Espírito Santo, Nossa Senhora da Graça e São Simão
    Galveias
    Montargil
    Foros de Arrão
    Longomel
    União das freguesias de Ponte de Sor, Tramaga e Vale de Açor
    Alagoa
    Alegrete
    Fortios
    Urra
    União das freguesias da Sé e São Lourenço
    União das freguesias de Reguengo e São Julião
    União das freguesias de Ribeira de Nisa e Carreiras
    Cano
    Casa Branca
    Santo Amaro
    Sousel
    Ansiães
    Candemil
    Fregim
    Fridão
    Gondar – Amarante
    Jazente
    Lomba – Amarante
    Louredo – Amarante
    Lufrei
    Mancelos
    Padronelo
    Rebordelo – Amarante
    Salvador do Monte
    Gouveia (São Simão)
    Telões – Amarante
    Travanca – Amarante
    Vila Caiz
    Vila Chã do Marão
    União das freguesias de Aboadela, Sanche e Várzea
    União das freguesias de Amarante (São Gonçalo), Madalena, Cepelos e Gatão
    União das freguesias de Bustelo, Carneiro e Carvalho de Rei
    União das freguesias de Figueiró (Santiago e Santa Cristina)
    União das freguesias de Freixo de Cima e de Baixo
    União das freguesias de Olo e Canadelo
    Vila Meã
    União das freguesias de Vila Garcia, Aboim e Chapa
    Frende
    Gestaçô
    Gove
    Grilo
    Loivos do Monte
    Santa Marinha do Zêzere
    Valadares – Baião
    Viariz
    União das freguesias de Ancede e Ribadouro
    União das freguesias de Baião (Santa Leocádia) e Mesquinhata
    União das freguesias de Campelo e Ovil
    União das freguesias de Loivos da Ribeira e Tresouras
    União das freguesias de Santa Cruz do Douro e São Tomé de Covelas
    União das freguesias de Teixeira e Teixeiró
    Aião
    Airães
    Friande
    Idães
    Jugueiros
    Penacova – Felgueiras
    Pinheiro – Felgueiras
    Pombeiro de Ribavizela
    Refontoura
    Regilde
    Revinhade
    Sendim – Felgueiras
    União das freguesias de Macieira da Lixa e Caramos
    União das freguesias de Margaride (Santa Eulália), Várzea, Lagares, Varziela e Moure
    União das freguesias de Pedreira, Rande e Sernande
    União das freguesias de Torrados e Sousa
    União das freguesias de Unhão e Lordelo
    União das freguesias de Vila Cova da Lixa e Borba de Godim
    União das freguesias de Vila Fria e Vizela (São Jorge)
    União das freguesias de Vila Verde e Santão
    Lomba – Gondomar
    Rio Tinto
    Baguim do Monte (Rio Tinto)
    União das freguesias de Fânzeres e São Pedro da Cova
    União das freguesias de Foz do Sousa e Covelo
    União das freguesias de Gondomar (São Cosme), Valbom e Jovim
    União das freguesias de Melres e Medas
    Aveleda – Lousada
    Caíde de Rei
    Lodares
    Macieira
    Meinedo
    Nevogilde
    Sousela
    Torno
    Vilar do Torno e Alentém
    União das freguesias de Cernadelo e Lousada (São Miguel e Santa Margarida)
    União das freguesias de Cristelos, Boim e Ordem
    União das freguesias de Figueiras e Covas
    União das freguesias de Lustosa e Barrosas (Santo Estêvão)
    União das freguesias de Nespereira e Casais
    União das freguesias de Silvares, Pias, Nogueira e Alvarenga
    Águas Santas
    Folgosa – Maia
    Milheirós
    Moreira – Maia
    São Pedro Fins
    Vila Nova da Telha
    Pedrouços
    Castêlo da Maia
    Cidade da Maia
    Nogueira e Silva Escura
    Banho e Carvalhosa
    Constance
    Soalhães
    Sobretâmega
    Tabuado
    Vila Boa do Bispo
    Alpendorada, Várzea e Torrão
    Avessadas e Rosém
    Bem Viver
    Santo Isidoro e Livração
    Marco
    Paredes de Viadores e Manhuncelos
    Penha Longa e Paços de Gaiolo
    Sande e São Lourenço do Douro
    Várzea, Aliviada e Folhada
    Vila Boa de Quires e Maureles
    União das freguesias de Custóias, Leça do Balio e Guifões
    União das freguesias de Matosinhos e Leça da Palmeira
    União das freguesias de Perafita, Lavra e Santa Cruz do Bispo
    União das freguesias de São Mamede de Infesta e Senhora da Hora
    Carvalhosa
    Eiriz
    Ferreira – Paços de Ferreira
    Figueiró
    Freamunde
    Meixomil
    Penamaior
    Raimonda
    Seroa
    Frazão Arreigada
    Paços de Ferreira
    Sanfins Lamoso Codessos
    Aguiar de Sousa
    Astromil
    Baltar
    Beire
    Cete
    Cristelo – Paredes
    Duas Igrejas – Paredes
    Gandra – Paredes
    Lordelo – Paredes
    Louredo – Paredes
    Parada de Todeia
    Rebordosa
    Recarei
    Sobreira
    Sobrosa
    Vandoma
    Vilela – Paredes
    Paredes
    Abragão
    Boelhe
    Bustelo – Penafiel
    Cabeça Santa
    Canelas – Penafiel
    Capela
    Castelões – Penafiel
    Croca
    Duas Igrejas – Penafiel
    Eja
    Fonte Arcada
    Galegos – Penafiel
    Irivo
    Oldrões
    Paço de Sousa
    Perozelo
    Rans
    Rio de Moinhos – Penafiel
    Recezinhos (São Mamede)
    Recezinhos (São Martinho)
    Sebolido
    Valpedre
    Rio Mau
    Penafiel
    Luzim e Vila Cova
    Guilhufe e Urrô
    Lagares e Figueira
    Termas de São Vicente
    Bonfim
    Campanhã
    Paranhos – Porto
    Ramalde
    União das freguesias de Aldoar, Foz do Douro e Nevogilde
    União das freguesias de Cedofeita, Santo Ildefonso, Sé, Miragaia, São Nicolau e Vitória
    União das freguesias de Lordelo do Ouro e Massarelos
    Balazar
    Estela
    Laundos
    Rates
    União das freguesias de Aver-o-Mar, Amorim e Terroso
    União das freguesias de Aguçadoura e Navais
    União das freguesias da Póvoa de Varzim, Beiriz e Argivai
    Agrela
    Água Longa
    Aves
    Monte Córdova
    Rebordões
    Reguenga
    Roriz – Santo Tirso
    Negrelos (São Tomé)
    Vilarinho
    União das freguesias de Areias, Sequeiró, Lama e Palmeira
    Vila Nova do Campo
    União das freguesias de Carreira e Refojos de Riba de Ave
    União das freguesias de Lamelas e Guimarei
    União das freguesias de Santo Tirso, Couto (Santa Cristina e São Miguel) e Burgães
    Alfena
    Ermesinde
    Valongo
    União das freguesias de Campo e Sobrado
    Árvore
    Aveleda – Vila do Conde
    Azurara
    Fajozes
    Gião
    Guilhabreu
    Junqueira – Vila do Conde
    Labruge
    Macieira da Maia
    Mindelo
    Modivas
    Vila Chã – Vila do Conde
    Vila do Conde
    Vilar de Pinheiro
    União das freguesias de Bagunte, Ferreiró, Outeiro Maior e Parada
    União das freguesias de Fornelo e Vairão
    União das freguesias de Malta e Canidelo
    União das freguesias de Retorta e Tougues
    União das freguesias de Rio Mau e Arcos
    União das freguesias de Touguinha e Touguinhó
    União das freguesias de Vilar e Mosteiró
    Arcozelo – Vila Nova de Gaia
    Avintes
    Canelas – Vila Nova de Gaia
    Canidelo
    Madalena
    Oliveira do Douro – Vila Nova de Gaia
    São Félix da Marinha
    Vilar de Andorinho
    União das freguesias de Grijó e Sermonde
    União das freguesias de Gulpilhares e Valadares
    União das freguesias de Mafamude e Vilar do Paraíso
    União das freguesias de Pedroso e Seixezelo
    União das freguesias de Sandim, Olival, Lever e Crestuma
    União das freguesias de Santa Marinha e São Pedro da Afurada
    União das freguesias de Serzedo e Perosinho
    Covelas – Trofa
    Muro
    União das freguesias de Alvarelhos e Guidões
    União das freguesias de Bougado (São Martinho e Santiago)
    União das freguesias de Coronado (São Romão e São Mamede)
    Bemposta – Abrantes
    Martinchel
    Mouriscas
    Pego
    Rio de Moinhos – Abrantes
    Tramagal
    Fontes – Abrantes
    Carvalhal – Abrantes
    União das freguesias de Abrantes (São Vicente e São João) e Alferrarede
    União das freguesias de Aldeia do Mato e Souto
    União das freguesias de Alvega e Concavada
    União das freguesias de São Facundo e Vale das Mós
    União das freguesias de São Miguel do Rio Torto e Rossio ao Sul do Tejo
    Bugalhos
    Minde
    Moitas Venda
    Monsanto
    Serra de Santo António
    União das freguesias de Alcanena e Vila Moreira
    União das freguesias de Malhou, Louriceira e Espinheiro
    Almeirim
    Benfica do Ribatejo
    Fazendas de Almeirim
    Raposa
    Alpiarça
    Benavente
    Samora Correia
    Santo Estêvão – Benavente
    Barrosa
    Pontével
    Valada
    Vila Chã de Ourique
    Vale da Pedra
    União das freguesias do Cartaxo e Vale da Pinta
    União das freguesias de Ereira e Lapa
    Ulme
    Vale de Cavalos
    Carregueira
    União das freguesias da Chamusca e Pinheiro Grande
    União das freguesias de Parreira e Chouto
    Constância
    Montalvo
    Santa Margarida da Coutada
    Couço
    São José da Lamarosa
    Branca – Coruche
    Biscainho
    Santana do Mato
    União das freguesias de Coruche, Fajarda e Erra
    São João Baptista – Entroncamento
    Nossa Senhora de Fátima
    Águas Belas – Ferreira do Zêzere
    Beco
    Chãos
    Ferreira do Zêzere
    Igreja Nova do Sobral
    Nossa Senhora do Pranto
    União das freguesias de Areias e Pias
    Azinhaga
    Golegã
    Pombalinho
    Amêndoa
    Cardigos
    Carvoeiro
    Envendos
    Ortiga
    União das freguesias de Mação, Penhascoso e Aboboreira
    Alcobertas
    Arrouquelas
    Fráguas
    Rio Maior
    Asseiceira – Rio Maior
    São Sebastião
    União das freguesias de Azambujeira e Malaqueijo
    União das freguesias de Marmeleira e Assentiz
    União das freguesias de Outeiro da Cortiçada e Arruda dos Pisões
    União das freguesias de São João da Ribeira e Ribeira de São João
    Marinhais
    Muge
    União das freguesias de Glória do Ribatejo e Granho
    União das freguesias de Salvaterra de Magos e Foros de Salvaterra
    Abitureiras
    Abrã
    Alcanede
    Alcanhões
    Almoster – Santarém
    Amiais de Baixo
    Arneiro das Milhariças
    Moçarria
    Pernes
    Póvoa da Isenta
    Vale de Santarém
    Gançaria
    União das freguesias de Achete, Azoia de Baixo e Póvoa de Santarém
    União das freguesias de Azoia de Cima e Tremês
    União das freguesias de Casével e Vaqueiros
    União das freguesias de Romeira e Várzea
    União das freguesias da cidade de Santarém
    União das freguesias de São Vicente do Paul e Vale de Figueira
    Alcaravela
    Santiago de Montalegre
    Sardoal
    Valhascos
    Asseiceira – Tomar
    Carregueiros
    Olalhas
    Paialvo
    São Pedro de Tomar
    Sabacheira
    União das freguesias de Além da Ribeira e Pedreira
    União das freguesias de Casais e Alviobeira
    União das freguesias de Madalena e Beselga
    União das freguesias de Serra e Junceira
    União das freguesias de Tomar (São João Baptista) e Santa Maria dos Olivais
    Assentiz
    Chancelaria – Torres Novas
    Pedrógão – Torres Novas
    Riachos
    Zibreira
    Meia Via
    União das freguesias de Brogueira, Parceiros de Igreja e Alcorochel
    União das freguesias de Olaia e Paço
    União das freguesias de Torres Novas (Santa Maria, Salvador e Santiago)
    União das freguesias de Torres Novas (São Pedro), Lapas e Ribeira Branca
    Atalaia
    Praia do Ribatejo
    Tancos
    Vila Nova da Barquinha
    Alburitel
    Atouguia
    Caxarias
    Espite
    Fátima
    Nossa Senhora das Misericórdias
    Seiça
    Urqueira
    Nossa Senhora da Piedade
    União das freguesias de Freixianda, Ribeira do Fárrio e Formigais
    União das freguesias de Gondemaria e Olival
    União das freguesias de Matas e Cercal
    União das freguesias de Rio de Couros e Casal dos Bernardos
    Torrão
    São Martinho
    Comporta
    União das freguesias de Alcácer do Sal (Santa Maria do Castelo e Santiago) e Santa Susana
    Alcochete
    Samouco
    São Francisco
    Costa da Caparica
    União das freguesias de Almada, Cova da Piedade, Pragal e Cacilhas
    União das freguesias de Caparica e Trafaria
    União das freguesias de Charneca de Caparica e Sobreda
    União das freguesias de Laranjeiro e Feijó
    Santo António da Charneca
    União das freguesias de Alto do Seixalinho, Santo André e Verderena
    União das freguesias de Barreiro e Lavradio
    União das freguesias de Palhais e Coina
    Azinheira dos Barros e São Mamede do Sádão
    Melides
    Carvalhal – Grândola
    União das freguesias de Grândola e Santa Margarida da Serra
    Alhos Vedros
    Moita – Moita
    União das freguesias de Baixa da Banheira e Vale da Amoreira
    União das freguesias de Gaio-Rosário e Sarilhos Pequenos
    Canha
    Sarilhos Grandes
    União das freguesias de Atalaia e Alto Estanqueiro-Jardia
    União das freguesias de Montijo e Afonsoeiro
    União das freguesias de Pegões
    Palmela
    Pinhal Novo
    Quinta do Anjo
    União das freguesias de Poceirão e Marateca
    Abela
    Alvalade – Santiago do Cacém
    Cercal
    Ermidas-Sado
    Santo André – Santiago do Cacém
    São Francisco da Serra
    União das freguesias de Santiago do Cacém, Santa Cruz e São Bartolomeu da Serra
    União das freguesias de São Domingos e Vale de Água
    Amora
    Corroios
    Fernão Ferro
    União das freguesias do Seixal, Arrentela e Aldeia de Paio Pires
    Sesimbra (Castelo)
    Sesimbra (Santiago)
    Quinta do Conde
    Setúbal (São Sebastião)
    Gâmbia-Pontes-Alto da Guerra
    Sado
    União das freguesias de Azeitão (São Lourenço e São Simão)
    União das freguesias de Setúbal (São Julião, Nossa Senhora da Anunciada e Santa Maria da Graça)
    Sines
    Porto Covo
    Aboim das Choças
    Aguiã
    Ázere
    Cabana Maior
    Cabreiro
    Cendufe
    Couto
    Gavieira
    Gondoriz – Arcos de Valdevez
    Miranda
    Monte Redondo
    Oliveira – Arcos de Valdevez
    Paçô
    Padroso
    Prozelo
    Rio Frio
    Rio de Moinhos – Arcos de Valdevez
    Sabadim
    Jolda (São Paio)
    Senharei
    Sistelo
    Soajo
    Vale
    União das freguesias de Alvora e Loureda
    União das freguesias de Arcos de Valdevez (São Paio) e Giela
    União das freguesias de Arcos de Valdevez (São Salvador), Vila Fonche e Parada
    União das freguesias de Eiras e Mei
    União das freguesias de Grade e Carralcova
    União das freguesias de Guilhadeses e Santar
    União das freguesias de Jolda (Madalena) e Rio Cabrão
    União das freguesias de Padreiro (Salvador e Santa Cristina)
    União das freguesias de Portela e Extremo
    União das freguesias de São Jorge e Ermelo
    União das freguesias de Souto e Tabaçô
    União das freguesias de Távora (Santa Maria e São Vicente)
    União das freguesias de Vilela, São Cosme e São Damião e Sá
    Âncora
    Argela
    Dem
    Lanhelas
    Riba de Âncora
    Seixas – Caminha
    Vila Praia de Âncora
    Vilar de Mouros
    Vile
    União das freguesias de Arga (Baixo, Cima e São João)
    União das freguesias de Caminha (Matriz) e Vilarelho
    União das freguesias de Gondar e Orbacém
    União das freguesias de Moledo e Cristelo
    União das freguesias de Venade e Azevedo
    Alvaredo
    Cousso
    Cristoval
    Fiães – Melgaço
    Gave
    Paderne – Melgaço
    Penso
    São Paio – Melgaço
    União das freguesias de Castro Laboreiro e Lamas de Mouro
    União das freguesias de Chaviães e Paços
    União das freguesias de Parada do Monte e Cubalhão
    União das freguesias de Prado e Remoães
    União das freguesias de Vila e Roussas
    Abedim
    Barbeita
    Barroças e Taias
    Bela
    Cambeses – Monção
    Lara
    Longos Vales
    Merufe
    Moreira – Monção
    Pias – Monção
    Pinheiros
    Podame
    Portela
    Riba de Mouro
    Segude
    Tangil
    Trute
    União das freguesias de Anhões e Luzio
    União das freguesias de Ceivães e Badim
    União das freguesias de Mazedo e Cortes
    União das freguesias de Messegães, Valadares e Sá
    União das freguesias de Monção e Troviscoso
    União das freguesias de Sago, Lordelo e Parada
    União das freguesias de Troporiz e Lapela
    Agualonga
    Castanheira – Paredes de Coura
    Coura
    Cunha – Paredes de Coura
    Infesta
    Mozelos – Paredes de Coura
    Padornelo
    Parada – Paredes de Coura
    Romarigães
    Rubiães
    Vascões
    União das freguesias de Bico e Cristelo
    União das freguesias de Cossourado e Linhares
    União das freguesias de Formariz e Ferreira
    União das freguesias de Insalde e Porreiras
    União das freguesias de Paredes de Coura e Resende
    Azias
    Boivães
    Bravães
    Britelo
    Cuide de Vila Verde
    Lavradas
    Lindoso
    Nogueira – Ponte da Barca
    Oleiros – Ponte da Barca
    Sampriz
    Vade (São Pedro)
    Vade (São Tomé)
    União das freguesias de Crasto, Ruivos e Grovelas
    União das freguesias de Entre Ambos-os-Rios, Ermida e Germil
    União das freguesias de Ponte da Barca, Vila Nova de Muía e Paço Vedro de Magalhães
    União das freguesias de Touvedo (São Lourenço e Salvador)
    União das freguesias de Vila Chã (São João Baptista e Santiago)
    Anais
    São Pedro d'Arcos
    Arcozelo – Ponte de Lima
    Beiral do Lima
    Bertiandos
    Boalhosa
    Brandara
    Calheiros
    Calvelo
    Correlhã
    Estorãos – Ponte de Lima
    Facha
    Feitosa
    Fontão
    Friastelas
    Gandra – Ponte de Lima
    Gemieira
    Gondufe
    Labruja
    Poiares – Ponte de Lima
    Refóios do Lima
    Ribeira – Ponte de Lima
    Sá
    Santa Comba – Ponte de Lima
    Santa Cruz do Lima
    Rebordões (Santa Maria)
    Seara
    Serdedelo
    Rebordões (Souto)
    Vitorino das Donas
    Arca e Ponte de Lima
    Ardegão, Freixo e Mato
    Associação de freguesias do Vale do Neiva
    Bárrio e Cepões
    Cabaços e Fojo Lobal
    Cabração e Moreira do Lima
    Fornelos e Queijada
    Labrujó, Rendufe e Vilar do Monte
    Navió e Vitorino dos Piães
    Boivão
    Cerdal
    Fontoura
    Friestas
    Ganfei
    São Pedro da Torre
    Verdoejo
    União das freguesias de Gandra e Taião
    União das freguesias de Gondomil e Sanfins
    União das freguesias de São Julião e Silva
    União das freguesias de Valença, Cristelo Covo e Arão
    Afife
    Alvarães
    Amonde
    Anha
    Areosa
    Carreço
    Castelo do Neiva
    Darque
    Freixieiro de Soutelo
    Lanheses
    Montaria
    Mujães
    São Romão de Neiva
    Outeiro – Viana do Castelo
    Perre
    Santa Marta de Portuzelo
    Vila Franca
    Vila de Punhe
    Chafé
    União das freguesias de Barroselas e Carvoeiro
    União das freguesias de Cardielos e Serreleis
    União das freguesias de Geraz do Lima (Santa Maria, Santa Leocádia e Moreira) e Deão
    União das freguesias de Mazarefes e Vila Fria
    União das freguesias de Nogueira, Meixedo e Vilar de Murteda
    União das freguesias de Subportela, Deocriste e Portela Susã
    União das freguesias de Torre e Vila Mou
    União das freguesias de Viana do Castelo (Santa Maria Maior e Monserrate) e Meadela
    Cornes
    Covas
    Gondarém
    Loivo
    Mentrestido
    Sapardos
    Sopo
    União das freguesias de Campos e Vila Meã
    União das freguesias de Candemil e Gondar
    União das freguesias de Reboreda e Nogueira
    União das freguesias de Vila Nova de Cerveira e Lovelhe
    Alijó
    Favaios
    Pegarinhos
    Pinhão
    Sanfins do Douro
    Santa Eugénia
    São Mamede de Ribatua
    Vila Chã – Alijó
    Vila Verde – Alijó
    Vilar de Maçada
    União das freguesias de Carlão e Amieiro
    União das freguesias de Castedo e Cotas
    União das freguesias de Pópulo e Ribalonga
    União das freguesias de Vale de Mendiz, Casal de Loivos e Vilarinho de Cotas
    Beça
    Covas do Barroso
    Dornelas – Boticas
    Pinho – Boticas
    Sapiãos
    Alturas do Barroso e Cerdedo
    Ardãos e Bobadela
    Boticas e Granja
    Codessoso, Curros e Fiães do Tâmega
    Vilar e Viveiro
    Águas Frias
    Anelhe
    Bustelo – Chaves
    Cimo de Vila da Castanheira
    Curalha
    Ervededo
    Faiões
    Lama de Arcos
    Mairos
    Moreiras
    Nogueira da Montanha
    Oura
    Outeiro Seco
    Paradela – Chaves
    Redondelo
    Sanfins
    Santa Leocádia
    Santo António de Monforte
    Santo Estêvão – Chaves
    São Pedro de Agostém
    São Vicente – Chaves
    Tronco
    Vale de Anta
    Vila Verde da Raia
    Vilar de Nantes
    Vilarelho da Raia
    Vilas Boas
    Vilela Seca
    Vilela do Tâmega
    Santa Maria Maior – Chaves
    Planalto de Monforte (União das freguesias de Oucidres e Bobadela)
    União das freguesias da Madalena e Samaiões
    União das freguesias das Eiras, São Julião de Montenegro e Cela
    União das freguesias de Calvão e Soutelinho da Raia
    União das freguesias de Loivos e Póvoa de Agrações
    União das freguesias de Santa Cruz/Trindade e Sanjurge
    União das freguesias de Soutelo e Seara Velha
    União das freguesias de Travancas e Roriz
    Vidago (União das freguesias de Vidago, Arcossó, Selhariz e Vilarinho das Paranheiras)
    Barqueiros – Mesão Frio
    Cidadelhe
    Oliveira – Mesão Frio
    Vila Marim – Mesão Frio
    Mesão Frio (Santo André)
    Atei
    Bilhó
    São Cristóvão de Mondim de Basto
    Vilar de Ferreiros
    União das freguesias de Campanhó e Paradança
    União das freguesias de Ermelo e Pardelhas
    Cabril – Montalegre
    Cervos
    Chã
    Covelo do Gerês
    Ferral
    Gralhas
    Morgade
    Negrões
    Outeiro – Montalegre
    Pitões das Junias
    Reigoso
    Salto
    Santo André – Montalegre
    Sarraquinhos
    Solveira
    Tourém
    Vila da Ponte – Montalegre
    União das freguesias de Cambeses do Rio, Donões e Mourilhe
    União das freguesias de Meixedo e Padornelos
    União das freguesias de Montalegre e Padroso
    União das freguesias de Paradela, Contim e Fiães
    União das freguesias de Sezelhe e Covelães
    União das freguesias de Venda Nova e Pondras
    União das freguesias de Viade de Baixo e Fervidelas
    União das freguesias de Vilar de Perdizes e Meixide
    Candedo – Murça
    Fiolhoso
    Jou
    Murça
    Valongo de Milhais
    União das freguesias de Carva e Vilares
    União das freguesias de Noura e Palheiros
    Fontelas
    Loureiro – Peso da Régua
    Sedielos
    Vilarinho dos Freires
    União das freguesias de Galafura e Covelinhas
    União das freguesias de Moura Morta e Vinhós
    União das freguesias de Peso da Régua e Godim
    União das freguesias de Poiares e Canelas
    Alvadia
    Canedo
    Santa Marinha
    União das freguesias de Cerva e Limões
    União das freguesias de Ribeira de Pena (Salvador) e Santo Aleixo de Além-Tâmega
    Celeirós
    Covas do Douro
    Gouvinhas
    Parada de Pinhão
    Paços
    Sabrosa
    São Lourenço de Ribapinhão
    Souto Maior
    Torre do Pinhão
    Vilarinho de São Romão
    União das freguesias de Provesende, Gouvães do Douro e São Cristóvão do Douro
    União das freguesias de São Martinho de Antas e Paradela de Guiães
    Alvações do Corgo
    Cumieira
    Fontes – Santa Marta de Penaguião
    Medrões
    Sever – Santa Marta de Penaguião
    União das freguesias de Lobrigos (São Miguel e São João Baptista) e Sanhoane
    União das freguesias de Louredo e Fornelos
    Água Revés e Crasto
    Algeriz
    Bouçoães
    Canaveses
    Ervões
    Fornos do Pinhal
    Friões
    Padrela e Tazem
    Possacos
    Rio Torto
    Santa Maria de Emeres
    Santa Valha
    Santiago da Ribeira de Alhariz
    São João da Corveira
    São Pedro de Veiga de Lila
    Serapicos – Valpaços
    Vales
    Vassal
    Veiga de Lila
    Vilarandelo
    Carrazedo de Montenegro e Curros
    Lebução, Fiães e Nozelos
    Sonim e Barreiros
    Tinhela e Alvarelhos
    Valpaços e Sanfins
    Alfarela de Jales
    Bornes de Aguiar
    Bragado
    Capeludos
    Soutelo de Aguiar
    Telões – Vila Pouca de Aguiar
    Tresminas
    Valoura
    Vila Pouca de Aguiar
    Vreia de Bornes
    Vreia de Jales
    Sabroso de Aguiar
    Alvão
    União das freguesias de Pensalvos e Parada de Monteiros
    Abaças
    Andrães
    Arroios – Vila Real
    Campeã
    Folhadela
    Guiães
    Lordelo – Vila Real
    Mateus
    Mondrões
    Parada de Cunhos
    Torgueda
    Vila Marim – Vila Real
    União das freguesias de Adoufe e Vilarinho de Samardã
    União das freguesias de Borbela e Lamas de Olo
    União das freguesias de Constantim e Vale de Nogueiras
    União das freguesias de Mouçós e Lamares
    União das freguesias de Nogueira e Ermida
    União das freguesias de Pena, Quintã e Vila Cova
    União das freguesias de São Tomé do Castelo e Justes
    Vila Real
    Aldeias
    Cimbres
    Folgosa – Armamar
    Fontelo
    Queimada
    Queimadela
    Santa Cruz – Armamar
    São Cosmado
    São Martinho das Chãs
    Vacalar
    Armamar
    União das freguesias de Aricera e Goujoim
    União das freguesias de São Romão e Santiago
    União das freguesias de Vila Seca e Santo Adrião
    Beijós
    Cabanas de Viriato
    Oliveira do Conde
    Parada – Carregal do Sal
    Carregal do Sal
    Almofala
    Cabril – Castro Daire
    Castro Daire
    Cujó
    Gosende
    Mões
    Moledo
    Monteiras
    Pepim
    Pinheiro – Castro Daire
    São Joaninho – Castro Daire
    União das freguesias de Mamouros, Alva e Ribolhos
    União das freguesias de Mezio e Moura Morta
    União das freguesias de Parada de Ester e Ester
    União das freguesias de Picão e Ermida
    União das freguesias de Reriz e Gafanhão
    Cinfães
    Espadanedo
    Ferreiros de Tendais
    Fornelos – Cinfães
    Moimenta – Cinfães
    Nespereira – Cinfães
    Oliveira do Douro – Cinfães
    Santiago de Piães
    São Cristóvão de Nogueira
    Souselo
    Tarouquela
    Tendais
    Travanca – Cinfães
    União das freguesias de Alhões, Bustelo, Gralheira e Ramires
    Avões
    Britiande
    Cambres
    Ferreirim
    Ferreiros de Avões
    Figueira
    Lalim
    Lazarim
    Penajóia
    Penude
    Samodães
    Sande
    Várzea de Abrunhais
    Vila Nova de Souto d'El-Rei
    Lamego (Almacave e Sé)
    União das freguesias de Bigorne, Magueija e Pretarouca
    União das freguesias de Cepões, Meijinhos e Melcões
    União das freguesias de Parada do Bispo e Valdigem
    Abrunhosa-a-Velha
    Alcafache
    Cunha Baixa
    Espinho – Mangualde
    Fornos de Maceira Dão
    Freixiosa
    Quintela de Azurara
    São João da Fresta
    União das freguesias de Mangualde, Mesquitela e Cunha Alta
    União das freguesias de Moimenta de Maceira Dão e Lobelhe do Mato
    União das freguesias de Santiago de Cassurrães e Póvoa de Cervães
    União das freguesias de Tavares (Chãs, Várzea e Travanca)
    Alvite
    Arcozelos
    Baldos
    Cabaços
    Caria – Moimenta da Beira
    Castelo – Moimenta da Beira
    Leomil
    Moimenta da Beira
    Passô
    Vila da Rua
    Sarzedo – Moimenta da Beira
    Sever – Moimenta da Beira
    Vilar – Moimenta da Beira
    União das freguesias de Paradinha e Nagosa
    União das freguesias de Pêra Velha, Aldeia de Nacomba e Ariz
    União das freguesias de Peva e Segões
    Cercosa
    Espinho – Mortágua
    Marmeleira
    Pala – Mortágua
    Sobral – Mortágua
    Trezói
    União das freguesias de Mortágua, Vale de Remígio, Cortegaça e Almaça
    Canas de Senhorim
    Nelas
    Senhorim
    Vilar Seco – Nelas
    Lapa do Lobo
    União das freguesias de Carvalhal Redondo e Aguieira
    União das freguesias de Santar e Moreira
    Arcozelo das Maias
    Pinheiro – Oliveira de Frades
    Ribeiradio
    São João da Serra
    São Vicente de Lafões
    União das freguesias de Arca e Varzielas
    União das freguesias de Destriz e Reigoso
    União das freguesias de Oliveira de Frades, Souto de Lafões e Sejães
    Castelo de Penalva
    Esmolfe
    Germil
    Ínsua
    Lusinde
    Pindo
    Real – Penalva do Castelo
    Sezures
    Trancozelos
    União das freguesias de Antas e Matela
    União das freguesias de Vila Cova do Covelo e Mareco
    Beselga
    Castainço
    Penela da Beira
    Póvoa de Penela
    Souto – Penedono
    União das freguesias de Antas e Ourozinho
    União das freguesias de Penedono e Granja
    Barrô
    Cárquere
    Paus
    Resende
    São Cipriano
    São João de Fontoura
    São Martinho de Mouros
    União das freguesias de Anreade e São Romão de Aregos
    União das freguesias de Felgueiras e Feirão
    União das freguesias de Freigil e Miomães
    União das freguesias de Ovadas e Panchorra
    Pinheiro de Ázere
    São Joaninho – Santa Comba Dão
    São João de Areias
    União das freguesias de Ovoa e Vimieiro
    União das freguesias de Santa Comba Dão e Couto do Mosteiro
    União das freguesias de Treixedo e Nagozela
    Castanheiro do Sul
    Ervedosa do Douro
    Nagozelo do Douro
    Paredes da Beira
    Riodades
    Soutelo do Douro
    Vale de Figueira
    Valongo dos Azeites
    União das freguesias de São João da Pesqueira e Várzea de Trevões
    União das freguesias de Trevões e Espinhosa
    União das freguesias de Vilarouco e Pereiros
    Bordonhos
    Figueiredo de Alva
    Manhouce
    Pindelo dos Milagres
    Pinho – São Pedro do Sul
    São Félix
    Serrazes
    Sul
    Valadares – São Pedro do Sul
    Vila Maior
    União das freguesias de Carvalhais e Candal
    União das freguesias de Santa Cruz da Trapa e São Cristóvão de Lafões
    União das freguesias de São Martinho das Moitas e Covas do Rio
    União das freguesias de São Pedro do Sul, Várzea e Baiões
    Avelal
    Ferreira de Aves
    Mioma
    Rio de Moinhos – Sátão
    São Miguel de Vila Boa
    Sátão
    Silvã de Cima
    União das freguesias de Águas Boas e Forles
    União das freguesias de Romãs, Decermilo e Vila Longa
    Arnas
    Carregal
    Chosendo
    Cunha – Sernancelhe
    Faia – Sernancelhe
    Granjal
    Lamosa
    Quintela
    Vila da Ponte – Sernancelhe
    União das freguesias de Ferreirim e Macieira
    União das freguesias de Fonte Arcada e Escurquela
    União das freguesias de Penso e Freixinho
    União das freguesias de Sernancelhe e Sarzeda
    Adorigo
    Arcos – Tabuaço
    Chavães
    Desejosa
    Granja do Tedo
    Longa
    Sendim – Tabuaço
    Tabuaço
    Valença do Douro
    União das freguesias de Barcos e Santa Leocádia
    União das freguesias de Paradela e Granjinha
    União das freguesias de Pinheiros e Vale de Figueira
    União das freguesias de Távora e Pereiro
    Mondim da Beira
    Salzedas
    São João de Tarouca
    Várzea da Serra
    União das freguesias de Gouviães e Ucanha
    União das freguesias de Granja Nova e Vila Chã da Beira
    União das freguesias de Tarouca e Dálvares
    Campo de Besteiros
    Canas de Santa Maria
    Castelões – Tondela
    Dardavaz
    Ferreirós do Dão
    Guardão
    Lajeosa do Dão
    Lobão da Beira
    Molelos
    Parada de Gonta
    Santiago de Besteiros
    Tonda
    União das freguesias de Barreiro de Besteiros e Tourigo
    União das freguesias de Caparrosa e Silvares
    União das freguesias de Mouraz e Vila Nova da Rainha
    União das freguesias de São João do Monte e Mosteirinho
    União das freguesias de São Miguel do Outeiro e Sabugosa
    União das freguesias de Tondela e Nandufe
    União das freguesias de Vilar de Besteiros e Mosteiro de Fráguas
    Pendilhe
    Queiriga
    Touro
    Vila Cova à Coelheira – Vila Nova de Paiva
    União das freguesias de Vila Nova de Paiva, Alhais e Fráguas
    Abraveses
    Bodiosa
    Calde
    Campo
    Cavernães
    Cota
    Fragosela
    Lordosa
    Silgueiros
    Mundão
    Orgens
    Povolide
    Ranhados – Viseu
    Ribafeita
    Rio de Loba
    Santos Evos
    São João de Lourosa
    São Pedro de France
    União das freguesias de Barreiros e Cepões
    União das freguesias de Boa Aldeia, Farminhão e Torredeita
    Coutos de Viseu
    União das freguesias de Faíl e Vila Chã de Sá
    Repeses e São Salvador
    São Cipriano e Vil de Souto
    Viseu
    Alcofra
    Campia
    Fornelo do Monte
    Queirã
    São Miguel do Mato – Vouzela
    Ventosa – Vouzela
    União das freguesias de Cambra e Carvalhal de Vermilhas
    União das freguesias de Fataunços e Figueiredo das Donas
    União das freguesias de Vouzela e Paços de Vilharigues
    União das freguesias de Milhazes, Vilar de Figos e Faria
    União das freguesias de Negreiros e Chavão
    União das freguesias de Quintiães e Aguiar
    União das freguesias de Sequeade e Bastuço (São João e Santo Estevão)
    União das freguesias de Silveiros e Rio Covo (Santa Eulália)
    União das freguesias de Tamel (Santa Leocádia) e Vilar do Monte
    União das freguesias de Viatodos, Grimancelos, Minhotães e Monte de Fralães
    União das freguesias de Vila Cova e Feitos
).strip.split(/\n+/).map { |e| e.strip }

@col_sep = '|'

puts ['MAI'.ljust(50), 'DW'].join    # print a nice table header
matcher = FuzzyMatch.new(dw_records) # set up a matcher object
mai_records.each do |mai|
  dw = matcher.find(mai)
  CSV.open('fuzzy.csv', 'a+', col_sep: @col_sep,
                              headers: %w[MAI DataWrapper]) do |csv|
    csv << [mai, dw]
  end
end
