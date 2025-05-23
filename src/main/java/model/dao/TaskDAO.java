package model.dao;

import java.util.List;
import model.ModelException;
import model.Task;

public interface TaskDAO {
    boolean save(Task task) throws ModelException;
    boolean update(Task task) throws ModelException;
    boolean delete(Task task) throws ModelException;
    List<Task> listAll() throws ModelException;
    Task findById(int id) throws ModelException;
}
