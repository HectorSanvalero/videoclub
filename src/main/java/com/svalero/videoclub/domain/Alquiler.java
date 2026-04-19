package com.svalero.videoclub.domain;

import lombok.Data;
import java.time.LocalDate;

@Data
public class Alquiler {
    private int id;
    private int idPelicula;
    private int idCliente;
    private int idEmpleado;
    private LocalDate fechaInicio;
    private LocalDate fechaDevolucion;
    private String estado;
}
