package model.dao;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import model.ModelException;
import model.Task;

public class MySQLTaskDAO implements TaskDAO {

    @Override
    public boolean save(Task task) throws ModelException {
        DBHandler db = new DBHandler();

        String sqlInsert = "INSERT INTO tasks (description, status, due_date, user_id) "
                         + "VALUES (?, ?, ?, ?)";

        db.prepareStatement(sqlInsert);
        db.setString(1, task.getDescription());
        db.setString(2, task.getStatus());
        db.setDate(3, task.getDueDate()); // Assumindo java.sql.Date
        db.setInt(4, task.getUserId());

        return db.executeUpdate() > 0;
    }

    @Override
    public boolean update(Task task) throws ModelException {
        DBHandler db = new DBHandler();

        String sqlUpdate = "UPDATE tasks SET "
                         + "description = ?, "
                         + "status = ?, "
                         + "due_date = ?, "
                         + "user_id = ? "
                         + "WHERE id = ?";

        db.prepareStatement(sqlUpdate);
        db.setString(1, task.getDescription());
        db.setString(2, task.getStatus());
        db.setDate(3, task.getDueDate());
        db.setInt(4, task.getUserId());
        db.setInt(5, task.getId());

        return db.executeUpdate() > 0;
    }

    @Override
    public boolean delete(Task task) throws ModelException {
        DBHandler db = new DBHandler();

        String sqlDelete = "DELETE FROM tasks WHERE id = ?";

        db.prepareStatement(sqlDelete);
        db.setInt(1, task.getId());

        try {
            return db.executeUpdate() > 0;
        } catch (ModelException e) {
            if (e.getCause() instanceof SQLIntegrityConstraintViolationException) {
                return false;
            }
            throw e;
        }
    }

    @Override
    public List<Task> listAll() throws ModelException {
        DBHandler db = new DBHandler();
        List<Task> tasks = new ArrayList<>();

        String sql = "SELECT * FROM tasks";
        db.createStatement();
        db.executeQuery(sql);

        while (db.next()) {
            tasks.add(createTask(db));
        }

        return tasks;
    }

    @Override
    public Task findById(int id) throws ModelException {
        DBHandler db = new DBHandler();

        String sql = "SELECT * FROM tasks WHERE id = ?";
        db.prepareStatement(sql);
        db.setInt(1, id);
        db.executeQuery();

        Task task = null;
        if (db.next()) {
            task = createTask(db);
        }

        return task;
    }

    private Task createTask(DBHandler db) throws ModelException {
        Task t = new Task(db.getInt("id"));
        t.setDescription(db.getString("description"));
        t.setStatus(db.getString("status"));
        t.setDueDate(db.getDate("due_date"));
        t.setUserId(db.getInt("user_id"));
        return t;
    }
}
