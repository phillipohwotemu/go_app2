package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, Web World!")
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Starting server on :8080")
    err := http.ListenAndServe(":8080", nil)
    if err != nil {
        fmt.Printf("Error starting server: %s\n", err)
    }
}

