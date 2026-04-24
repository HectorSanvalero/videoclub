package com.svalero.videoclub.dao;

import com.svalero.videoclub.domain.Alquiler;
import com.svalero.videoclub.util.DatabaseConnection;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;
import java.util.List;

public class AlquilerDao {

    private Jdbi jdbi;

    public AlquilerDao() throws SQLException {
        this.jdbi = Jdbi.create(DatabaseConnection.getDataSource());
    }

    public List<Alquiler> findAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM alquiler")
                        .mapToBean(Alquiler.class)
                        .list()
        );
    }

    public Alquiler findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM alquiler WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Alquiler.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public List<Alquiler> findByCliente(int idCliente) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM alquiler WHERE id_cliente = :idCliente")
                        .bind("idCliente", idCliente)
                        .mapToBean(Alquiler.class)
                        .list()
        );
    }

    public void save(Alquiler alquiler) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO alquiler (id_pelicula, id_cliente, id_empleado, fecha_inicio, fecha_devolucion, estado, precio) " +
                                "VALUES (:idPelicula, :idCliente, :idEmpleado, :fechaInicio, :fechaDevolucion, :estado, :precio)")
                        .bindBean(alquiler)
                        .execute()
        );
    }

    public void update(Alquiler alquiler) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE alquiler SET estado=:estado, fecha_devolucion=:fechaDevolucion WHERE id=:id")
                        .bindBean(alquiler)
                        .execute()
        );
    }

    public boolean eliminar(int id) {
        try {
            jdbi.useHandle(handle ->
                    handle.createUpdate("DELETE FROM alquiler WHERE id = :id")
                            .bind("id", id)
                            .execute()
            );
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Alquiler> search(String estado) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM alquiler WHERE estado LIKE :estado")
                        .bind("estado", "%" + estado + "%")
                        .mapToBean(Alquiler.class)
                        .list()
        );
    }
}
