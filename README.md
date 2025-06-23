# ESTRUTURA-DE-DATOS1DF

#include <iostream>
#include <string>
using namespace std;



// Nodo que representa una persona en el árbol genealógico
struct Nodo {
    int id;
    string nombre;
    Nodo* izq;
    Nodo* der;
    Nodo* padre;
};

// Crear un nuevo nodo
Nodo* crearNodo(int id, string nombre) {
    Nodo* nuevo = new Nodo();
    nuevo->id = id;
    nuevo->nombre = nombre;
    nuevo->izq = NULL;
    nuevo->der = NULL;
    nuevo->padre = NULL;
    return nuevo;
}

// Insertar nodo en árbol binario de búsqueda
Nodo* insertarABB(Nodo* raiz, int id, string nombre) {
    if (raiz == NULL) return crearNodo(id, nombre);

    if (id < raiz->id) {
        Nodo* hijoIzq = insertarABB(raiz->izq, id, nombre);
        raiz->izq = hijoIzq;
        hijoIzq->padre = raiz;
    } else if (id > raiz->id) {
        Nodo* hijoDer = insertarABB(raiz->der, id, nombre);
        raiz->der = hijoDer;
        hijoDer->padre = raiz;
    } else {
        cout << "ID duplicado. No se puede insertar.\n";
    }

    return raiz;
}

Nodo* buscarPorID(Nodo* raiz, int id) {
    if (raiz == NULL) return NULL;
    if (raiz->id == id) return raiz;
    return (id < raiz->id) ? buscarPorID(raiz->izq, id) : buscarPorID(raiz->der, id);
}

void menuGenealogia() {
    Nodo* raiz = NULL;
    int opcion, id, idPadre;
    string nombre;

    do {
        cout << "\n--- MENU GENEALOGICO CON ID ---\n";
        cout << "1. Ingresar ancestro principal\n";
        cout << "2. Insertar descendiente\n";
        cout << "3. Mostrar arbol\n";
        cout << "4. Mostrar ancestros por ID\n";
        cout << "10. Salir\n";
        cout << "Seleccione una opción: ";
        cin >> opcion;
        
        
        
        switch(opcion) {
            case 1:
                if (raiz != NULL) {
                    cout << "Ya hay un ancestro registrado.\n";
                    break;
                }
                cout << "ID del ancestro: "; cin >> id;
                cout << "Nombre: "; cin.ignore(); getline(cin, nombre);
                raiz = crearNodo(id, nombre);
                cout << "Ancestro registrado.\n";
                break;

            case 2:
                cout << "ID del padre existente: "; cin >> idPadre;
                cout << "ID del nuevo descendiente: "; cin >> id;
                cout << "Nombre del descendiente: "; cin.ignore(); getline(cin, nombre);
                {
                    Nodo* padreNodo = buscarPorID(raiz, idPadre);
                    if (padreNodo != NULL)
                        raiz = insertarABB(raiz, id, nombre);
                    else
                        cout << "No se encontró ese ID en el árbol.\n";
                }
                break;
            
            case 3:
                mostrarArbol(raiz);
                break;

            case 4:
                cout << "Ingrese ID de la persona: "; cin >> id;
                {
                    Nodo* p = buscarPorID(raiz, id);
                    if (p != NULL) {
                        cout << "Ancestros de (" << id << ") " << p->nombre << ":";
                        mostrarAncestros(p);
                    } else {
                        cout << "Persona no encontrada.\n";
                    }
                }
                break;

                
                
            case 10:
                cout << "Saliendo...\n";
                break;

            default:
                cout << "Opción inválida.\n";
        }
    } while (opcion != 10);
}

// Función principal
int main() {
    menuGenealogia();
    return 0;
}   
