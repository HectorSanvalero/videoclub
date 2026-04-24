package com.svalero.videoclub.dao;

import com.svalero.videoclub.domain.Empleado;
import com.svalero.videoclub.util.DatabaseConnection;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;
import java.util.List;

public class EmpleadoDao {

    private Jdbi jdbi;

    public EmpleadoDao() throws SQLException {
        this.jdbi = Jdbi.create(DatabaseConnection.getDataSource());
    }

    public List<Empleado> findAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM empleado")
                        .mapToBean(Empleado.class)
                        .list()
        );
    }

    public Empleado findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM empleado WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Empleado.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public Empleado findByEmailAndPassword(String email, String password) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM empleado WHERE email = :email AND password = :password")
                        .bind("email", email)
                        .bind("password", password)
                        .mapToBean(Empleado.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public void save(Empleado empleado) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO empleado (nombre, apellidos, email, password, rol) " +
                                "VALUES (:nombre, :apellidos, :email, :password, :rol)")
                        .bindBean(empleado)
                        .execute()
        );
    }

    public void update(Empleado empleado) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE empleado SET nombre=:nombre, apellidos=:apellidos, " +
                                "email=:email, rol=:rol WHERE id=:id")
                        .bindBean(empleado)
                        .execute()
        );
    }

    public boolean eliminar(int id) {
        try {
            jdbi.useHandle(handle ->
                    handle.createUpdate("DELETE FROM empleado WHERE id = :id")
                            .bind("id", id)
                            .execute()
            );
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
