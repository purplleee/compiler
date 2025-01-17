#include <ctype.h>
//Structure de la table des symboles
typedef struct {
char NomEntite[20];
char CodeEntite[20];
char TypeEntite[20];
char Constante[20];
char Valeur[20];
} TypeTS;

//Initialisation du tableau contenant les elements de la table des symboles
TypeTS ts[300];

//Compteur pour le parcours de la TS
int CpTabSym=0;

//Definition d'une fonction recherche
//La position i si symbole existe -1 sinon
int recherche(char entite[]) {
    int i = 0;
    while (i < CpTabSym) {
        if (strcmp(entite, ts[i].NomEntite) == 0) {
            return i;
        }
        i++;
    }
    return -1;
}


//Definition d'une fonction pour inserer les symboles dans la TS
void inserer(char entite[], char code[]) {
    if (recherche(entite) == -1) {
        strcpy(ts[CpTabSym].NomEntite, entite);
        strcpy(ts[CpTabSym].CodeEntite, code);
        strcpy(ts[CpTabSym].Constante, "non");
        CpTabSym++;
    }
}



//Definition d'une fonction pour inserer le types des symboles dans la TS
void insererType(char entite[], char type[]) {
    int pos;
    pos = recherche(entite);
    if (pos != -1)
    strcpy(ts[pos].TypeEntite, type);
}

//Definition d'une fonction pour inserer la valeur des idf dans la TS
void insererVal(char entite[], char val[]) {
    int pos;
    pos = recherche(entite);
    strcpy(ts[pos].Valeur, val);

}


// Definition d'une fonction pour afficher la TS
void afficher() {
    printf("_____________________________________________________________________________________\n");
    printf("\n                              Table des symboles                                   \n");
    printf("_____________________________________________________________________________________\n");
    printf("\t|     Nom     |     Code    |     Type    |  Constante  |    Valeur   |\n");
    printf("_____________________________________________________________________________________\n");

    int index = 0;
    while (index < CpTabSym) {
        printf("\t|%12s |%12s |%12s |%12s |%12s |\n", ts[index].NomEntite, ts[index].CodeEntite, ts[index].TypeEntite, ts[index].Constante, ts[index].Valeur);
        index++;
    }
}

// Definition d'une fonction pour detecter les declarations
int declaration(char entite[]) {
    int pos;
    pos = recherche(entite);
    if (strcmp(ts[pos].TypeEntite,"") == 0) return 0;
     else return -1;
}

// Definition d'une fonction pour detecter les types
int dectype(char entite[]) {
    int pos;
    pos = recherche(entite);
    if (strcmp(ts[pos].TypeEntite,"Int") == 0) return 1;
    if (strcmp(ts[pos].TypeEntite,"Float") == 0) return 2;
    if (strcmp(ts[pos].TypeEntite,"Bool") == 0) return 3;
     else return -1;
}

// Definition d'une fonction pour tester si la valeur est booleenne 
int Booltest(char val[]) {
    if (strcmp(val,"true") == 0) return 0;
    else if (strcmp(val,"false") == 0) return 0;
     else return -1;
}

// Definition d'une fonction pour tester si la valeur est un entier
int INTtest(char val[]) {
    int i = 0;
    while (val[i] != '\0') {
        if (!isdigit(val[i])) {
            // Le caractère à la position i n'est pas un chiffre
            return -1;
        }
        i++;
    }
    // Tous les caractères sont des chiffres, donc c'est un entier
    return 0;
}

// Definition d'une fonction pour determiner si constante ou non et sa valeur
void insererConst(char entite[], char valeur[]) {
    int pos;
    float number = atof(valeur);
    sprintf(valeur, "%.2f", number);
    pos = recherche(entite);
    strcpy(ts[pos].Constante, "oui");
    strcpy(ts[pos].Valeur,valeur);
}

// Definition d'une fonction pour detecter le changement de la val constante
int constVal(char entite[]) {
    int pos;
    pos = recherche(entite);
    if (strcmp(ts[pos].Constante,"non") == 0) return -1;
    else {
        if (strcmp(ts[pos].Valeur,"") == 0) return -1;
        else return 1;
    }
}