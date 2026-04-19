package com.svalero.videoclub.dao;

import com.svalero.videoclub.domain.Pelicula;
import com.svalero.videoclub.util.DatabaseConnection;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;
import java.util.List;

public class PeliculaDao {

    private Jdbi jdbi;

    public PeliculaDao() throws SQLException {
        this.jdbi = Jdbi.create(DatabaseConnection.getDataSource());
    }

    public List<Pelicula> findAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM pelicula")
                        .mapToBean(Pelicula.class)
                        .list()
        );
    }

    public Pelicula findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM pelicula WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Pelicula.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public void save(Pelicula pelicula) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO pelicula (titulo, genero, anyo, director, imagen, disponible) " +
                                "VALUES (:titulo, :genero, :anyo, :director, :imagen, :disponible)")
                        .bindBean(pelicula)
                        .execute()
        );
    }

    public void update(Pelicula pelicula) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE pelicula SET titulo=:titulo, genero=:genero, anyo=:anyo, " +
                                "director=:director, imagen=:imagen, disponible=:disponible WHERE id=:id")
                        .bindBean(pelicula)
                        .execute()
        );
    }

    public void delete(int id) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE pelicula SET disponible=0 WHERE id=:id")
                        .bind("id", id)
                        .execute()
        );
    }

    public List<Pelicula> search(String titulo, String genero) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM pelicula WHERE titulo LIKE :titulo AND (genero = :genero OR :genero IS NULL)")
                        .bind("titulo", "%" + titulo + "%")
                        .bind("genero", genero.isEmpty() ? null : genero)
                        .mapToBean(Pelicula.class)
                        .list()
        );
    }
}