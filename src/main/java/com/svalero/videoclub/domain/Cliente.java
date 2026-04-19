package com.svalero.videoclub.domain;

import lombok.Data;

@Data
public class Cliente {
    private int id;
    private String nombre;
    private String apellidos;
    private String email;
    private String telefono;
    private boolean activo;
}