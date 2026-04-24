package com.svalero.videoclub.dao;

import com.svalero.videoclub.domain.Cliente;
import com.svalero.videoclub.util.DatabaseConnection;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;
import java.util.List;

public class ClienteDao {

    private Jdbi jdbi;

    public ClienteDao() throws SQLException {
        this.jdbi = Jdbi.create(DatabaseConnection.getDataSource());
    }

    public List<Cliente> findAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM cliente WHERE activo = 1")
                        .mapToBean(Cliente.class)
                        .list()
        );
    }

    public Cliente findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM cliente WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Cliente.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public void save(Cliente cliente) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO cliente (nombre, apellidos, email, telefono, activo) " +
                                "VALUES (:nombre, :apellidos, :email, :telefono, :activo)")
                        .bindBean(cliente)
                        .execute()
        );
    }

    public void update(Cliente cliente) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE cliente SET nombre=:nombre, apellidos=:apellidos, " +
                                "email=:email, telefono=:telefono WHERE id=:id")
                        .bindBean(cliente)
                        .execute()
        );
    }

    public void delete(int id) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE cliente SET activo=0 WHERE id=:id")
                        .bind("id", id)
                        .execute()
        );
    }

    public List<Cliente> search(String nombre, String apellidos) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM cliente WHERE nombre LIKE :nombre AND apellidos LIKE :apellidos")
                        .bind("nombre", "%" + nombre + "%")
                        .bind("apellidos", "%" + apellidos + "%")
                        .mapToBean(Cliente.class)
                        .list()
        );
    }
}