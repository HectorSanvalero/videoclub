package com.svalero.videoclub.domain;

import lombok.Data;

@Data
public class Pelicula {
    private int id;
    private String titulo;
    private String genero;
    private int anyo;
    private String director;
    private String imagen;
    private boolean disponible;
}