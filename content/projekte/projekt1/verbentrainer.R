## verben <- c("abrir", "acabar", "acercar", "aconsejar", "acordar", "amar", "andar", "apoyar", "aprender", "armar", "asesinar", "atacar", "ayudar", "bailar", "bajar", "bastar", "bañar", "beber", "buscar", "caer", "callar", "calmar", "cambiar", "caminar", "campar", "cantar", "cazar", "cenar", "centrar", "cercar", "cerrar", "citar", "cocinar", "coger", "comenzar", "comer", "comparar", "comprar", "conducir", "conocer", "conseguir", "contar", "continuar", "correr", "cortar", "coser", "costar", "crear", "creer", "cuidar", "culpar", "dar", "dañar", "deber", "decidir", "decir", "dejar", "descansar", "describir", "desear", "destruir", "disculpar", "divertir", "doler", "dormir", "durar", "elegir", "empezar", "empujar", "encantar", "encontrar", "enseñar", "entender", "entrar", "equipar", "esconder", "escribir", "escuchar", "esperar", "esposar", "estar", "estudiar", "existir", "explicar", "extrañar", "faltar", "forzar", "funcionar", "ganar", "gritar", "gustar", "haber", "hablar", "hacer", "importar", "intentar", "ir", "jugar", "jurar", "lamentar", "lanzar", "largar", "lavar", "leer", "limpiar", "llamar", "llegar", "llenar", "llevar", "llorar", "luchar", "mandar", "matar", "mejor", "mejorar", "mentir", "mirar", "morir", "mostrar", "mover", "necesitar", "negociar", "nombrar", "ocurrir", "odiar", "ofrecer", "olvidar", "orar", "oír", "pagar", "parar", "parecer", "partir", "pasar", "pelar", "pelear", "peligrar", "penar", "pensar", "perder", "perdonar", "permitir", "pisar", "poder", "poner", "preferir", "preguntar", "preocupar", "preparar", "probar", "prometer", "pulsar", "quedar", "quemar", "querer", "recibir", "reconocer", "recordar", "regalar", "regresar", "repetir", "responder", "reír", "saber", "sacar", "salir", "saltar", "salvar", "seguir", "sentar", "sentir", "ser", "significar", "sonar", "sonreír", "soñar", "suceder", "suponer", "tardar", "temer", "tener", "terminar", "tirar", "tocar", "tomar", "trabajar", "traer", "tratar", "usar", "valer", "vender", "venir", "ver", "viajar", "visitar", "vivir", "volver")

verben <- c("abrir", "acabar", "acercar", "aconsejar", "acordar", "amar", "andar", "apoyar", "aprender", "armar", "asesinar", "atacar", "ayudar", "bailar", "bajar", "bastar", "bañar", "beber", "buscar", "caer", "callar", "calmar", "cambiar", "caminar", "campar", "cantar", "cazar", "cenar", "centrar", "cercar", "cerrar", "citar", "cocinar", "coger", "comenzar", "comer", "comparar", "comprar", "conducir", "conocer", "conseguir", "contar", "continuar", "correr", "cortar", "coser", "costar", "crear", "creer", "cuidar", "culpar", "dar", "dañar", "deber", "decidir", "decir", "dejar", "descansar", "describir", "desear", "destruir", "disculpar", "divertir", "doler", "dormir", "durar", "elegir", "empezar", "empujar", "encantar", "encontrar", "enseñar", "entender", "entrar", "equipar", "esconder", "escribir", "escuchar", "esperar", "esposar", "estar", "estudiar", "existir", "explicar", "extrañar", "faltar", "forzar", "funcionar", "ganar", "gritar", "gustar", "haber", "hablar", "hacer", "importar", "intentar", "ir", "jugar", "jurar", "lamentar", "lanzar", "largar", "lavar", "leer", "limpiar", "llamar", "llegar", "llenar", "llevar", "llorar", "luchar", "mandar", "matar", "mejor", "mejorar", "mentir", "mirar", "morir", "mostrar", "mover", "necesitar", "negociar", "nombrar", "ocurrir", "odiar", "ofrecer", "olvidar", "orar", "oír", "pagar", "parar", "parecer", "partir", "pasar", "pelar", "pelear", "peligrar", "penar", "pensar", "perder", "perdonar", "permitir", "pisar", "poder", "poner", "preferir", "preguntar", "preocupar", "preparar", "probar", "prometer", "pulsar", "quedar", "quemar", "querer", "recibir", "reconocer", "recordar", "regalar", "regresar", "repetir", "responder", "reír", "saber", "sacar", "salir", "saltar", "salvar", "seguir", "sentar", "sentir", "ser", "significar", "sonar", "sonreír", "soñar", "suceder", "suponer", "tardar", "temer", "tener", "terminar", "tirar", "tocar", "tomar", "trabajar", "traer", "tratar", "usar", "valer", "vender", "venir", "ver", "viajar", "visitar", "vivir", "volver")

person <- c("yo", "tú", "él/ella", "nosotres", "vosotres", "elles")

## Tabelle <- data.frame(verben, person)



Tabelle <- data.frame(verben)

## Tabelle$person <- print(sample(person, 197, replace = T))



head(Tabelle)

tempus <- c("Presente (I)", "Pretérito indefinido (I)", "Pretérito imperfecto (I)", "Futuro simple", "Condicional simple", "Presente (S)", "Pretérito imperfecto (S)", "Imperativo")

## Tabelle$tempus <- print(sample(tempus, 197, replace = T))





## Tabelle$person <- print(sample(person, 197, replace = T))
## Tabelle$tempus <- print(sample(zeit, 197, replace = T))

head(Tabelle)
