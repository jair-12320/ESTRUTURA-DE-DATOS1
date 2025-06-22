# ESTRUTURA-DE-DATOS1DF

#include <iostream>     // Para entrada y salida estándar
#include <string>       // Para poder usar strings
using namespace std;

// Estructura que representa un nodo en el árbol genealógico
struct Nodo {
    int id;              // Identificador único para la persona
    string nombre;       // Nombre de la persona
    Nodo* izq;           // Puntero al hijo izquierdo
    Nodo* der;           // Puntero al hijo derecho
    Nodo* padre;         // Puntero al nodo padre
};

// Función que crea y retorna un nuevo nodo con los datos entregados
Nodo* crearNodo(int id, string nombre) {
    Nodo* nuevo = new Nodo();
    nuevo->id = id;
    nuevo->nombre = nombre;
    nuevo->izq = NULL;
    nuevo->der = NULL;
    nuevo->padre = NULL;
    return nuevo;
}

// Función para buscar una persona por su ID en todo el árbol
Nodo* buscarPorID(Nodo* raiz, int id) {
    if (raiz == NULL) return NULL;            // Caso base: árbol vacío
    if (raiz->id == id) return raiz;          // Se encontró el nodo

    Nodo* encontrado = buscarPorID(raiz->izq, id); // Buscar por la izquierda
    if (encontrado != NULL) return encontrado;     // Si lo encontró, lo retorna

    return buscarPorID(raiz->der, id);             // Buscar por la derecha
}

// Función para insertar un hijo (si hay espacio)
void insertarHijo(Nodo* padre, int id, string nombre) {
    Nodo* hijo = crearNodo(id, nombre);
    hijo->padre = padre;

    if (padre->izq == NULL)
        padre->izq = hijo;
    else if (padre->der == NULL)
        padre->der = hijo;
    else
        cout << "Esta persona ya tiene dos descendientes.\n";
}

// Función que muestra el menú principal
void menuGenealogia() {
    Nodo* raiz = NULL;  // El árbol parte vacío
    int opcion, id, idPadre;
    string nombre;

    do {
        cout << "\n--- MENU GENEALOGICO CON ID ---\n";
        cout << "1. Ingresar ancestro principal\n";
        cout << "2. Insertar descendiente\n";
        cout << "3. Salir\n";
        cout << "Ingrese una opción: ";
        cin >> opcion;

        switch(opcion) {
            case 1:
                if (raiz != NULL) {
                    cout << "Ya hay un ancestro registrado.\n";
                    break;
                }
                cout << "ID del ancestro: ";
                cin >> id;
                cout << "Nombre: ";
                cin >> nombre;
                raiz = crearNodo(id, nombre);
                cout << "Ancestro registrado.\n";
                break;

            case 2:
                cout << "ID del padre existente: ";
                cin >> idPadre;
                cout << "ID del nuevo descendiente: ";
                cin >> id;
                cout << "Nombre del descendiente: ";
                cin >> nombre;
                {
                    Nodo* padreNodo = buscarPorID(raiz, idPadre);
                    if (padreNodo != NULL)
                        insertarHijo(padreNodo, id, nombre);
                    else
                        cout << "No se encontró ese ID en el árbol.\n";
                }
                break;

            case 3:
                cout << "Saliendo...\n";
                break;

            default:
                cout << "Opcion invalida.\n";
        }

    } while (opcion != 3);
}

int main() {
    menuGenealogia();
    return 0;
}
