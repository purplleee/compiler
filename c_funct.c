
//Structure de la table des symboles
typedef struct {
char NomEntite[20];
char CodeEntite[20];
char TypeEntite[20];
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
        CpTabSym++;
    }
}


//Definition d'une fonction pour inserer le types des symboles dans la TS
void insererType(char entite[], type code[]) {
    int pos;
    pos = recherche(entite);
    if (pos != -1)
    strcpy(ts[pos].TypeEntite, type);
}


// Definition d'une fonction pour afficher la TS
void afficher() {
    printf("\n/***************Table des symboles ******************/\n");
    printf("_____________________________________________\n");
    printf("\t| Nom | Code | Type \n");
    printf("_____________________________________________\n");
    int i = 0;
    while (i < CpTabSym) {
        printf("\t|%10s |%12s |%12s \n", ts[i].NomEntite, ts[i].CodeEntite, ts[i].TypeEntite);
        i++;
    }
}


