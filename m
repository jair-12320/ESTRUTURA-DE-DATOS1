
#include <iostream>
#include <cstring>  // Para manejo de cadenas estilo C
using namespace std;

// -------------------------------------
// ESTRUCTURA DEL NODO
// -------------------------------------
struct Nodo {
    int id;                   // Identificador único
    char nombre[50];          // Nombre de la persona
    char tipo[20];            // Tipo: ancestro, hijo, nieto, etc.
    Nodo* izquierda;          // Hijo izquierdo
    Nodo* derecha;            // Hijo derecho
};

// -------------------------------------
// FUNCIONES PRINCIPALES
// -------------------------------------

// Crear un nuevo nodo
Nodo* crearNodo(int id, const char* nombre, const char* tipo) {
    Nodo* nuevo = new Nodo();
    nuevo->id = id;
    strcpy(nuevo->nombre, nombre);
    strcpy(nuevo->tipo, tipo);
    nuevo->izquierda = NULL;
    nuevo->derecha = NULL;
    return nuevo;
}

// Insertar nodo en el árbol binario (ordenado por ID)
Nodo* insertar(Nodo* raiz, Nodo* nuevo) {
    if (raiz == NULL) {
        return nuevo;
    }
    if (nuevo->id < raiz->id) {
        raiz->izquierda = insertar(raiz->izquierda, nuevo);
    } else {
        raiz->derecha = insertar(raiz->derecha, nuevo);
    }
    return raiz;
}

// Buscar un nodo por su ID
Nodo* buscar(Nodo* raiz, int id) {
    if (raiz == NULL || raiz->id == id) {
        return raiz;
    }
    if (id < raiz->id) {
        return buscar(raiz->izquierda, id);
    } else {
        return buscar(raiz->derecha, id);
    }
}

// Recorrido Inorden del árbol (izquierda - raíz - derecha)
void mostrarInorden(Nodo* raiz) {
    if (raiz != NULL) {
        mostrarInorden(raiz->izquierda);
        cout << "ID: " << raiz->id << ", Nombre: " << raiz->nombre << ", Tipo: " << raiz->tipo << endl;
        mostrarInorden(raiz->derecha);
    }
}

// -------------------------------------
// FUNCIÓN PRINCIPAL
// -------------------------------------
int main() {
    Nodo* arbol = NULL;

    // Inserción de personas
    arbol = insertar(arbol, crearNodo(10, "Atahualpa", "ancestro"));
    arbol = insertar(arbol, crearNodo(5, "Huáscar", "hijo"));
    arbol = insertar(arbol, crearNodo(15, "Túpac", "nieto"));

    // Mostrar recorrido inorden
    cout << "\nRecorrido Inorden del Árbol Genealógico:\n";
    mostrarInorden(arbol);

    // Buscar persona por ID
    int idBuscado;
    cout << "\nIngrese un ID a buscar: ";
    cin >> idBuscado;

    Nodo* encontrado = buscar(arbol, idBuscado);
    if (encontrado != NULL) {
        cout << "Persona encontrada: " << encontrado->nombre << " (" << encontrado->tipo << ")\n";
    } else {
        cout << "Persona con ID " << idBuscado << " no encontrada.\n";
    }

    return 0;
}
