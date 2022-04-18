use io;

/* Reads instance data. */
function input() {
    local usage = "Usage: localsolver tsp.lsp "
        + "inFileName=inputFile [lsTimeLimit=timeLimit]";

    if (inFileName == nil) throw usage;
    local inFile = io.openRead(inFileName);

    nbGenes = inFile.readInt();

    // Distance from i to j
    w[0..nbGenes - 1][0..nbGenes - 1] = inFile.readInt();
}

/* Déclaration Modele. */
function model() {
    // genes est une liste: genes[i] est l'indice du ième élément
    genes <- list(nbGenes); 

    // Tous les genes doivent être parcourus (toutes les cases de genes)
    constraint count(genes) == nbGenes;

    // Fonction a maximiser
    obj <- sum[i in 0..nbGenes-2][j in i+1..nbGenes-1](w[genes[i]][genes[j]]);

    maximize obj;
}

/* Parametre du solver. */
function param() {
    if (lsTimeLimit == nil) lsTimeLimit = 30;  
}


/* Ecriture de la solution dans un fichier */
function output() {
    if (solFileName == nil) return;
    local solFile = io.openWrite(solFileName);
    solFile.println(obj.value);
    for [c in cities.value] 
        solFile.print(c, " ");
    solFile.println();
}










