package com.svalero.videoclub.domain;

import lombok.Data;

@Data
public class Empleado {
    private int id;
    private String nombre;
    private String apellidos;
    private String email;
    private String password;
    private String rol;
}
