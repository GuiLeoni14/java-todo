package controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelException;
import model.Task;
import model.User;
import model.dao.DAOFactory;
import model.dao.TaskDAO;
import model.dao.UserDAO;

@WebServlet(urlPatterns = {
    "/tasks", 
    "/task/form", 
    "/task/insert", 
    "/task/update", 
    "/task/delete"
})
public class TasksController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getRequestURI();

        switch (action) {
            case "/crud-manager/task/form": {
                Task task = loadTask(req);
                req.setAttribute("task", task);
                req.setAttribute("action", task != null ? "update" : "insert");
                listTasks(req);
                ControllerUtil.forward(req, resp, "/form-task.jsp");
                break;
            }
            default: {
                listTasks(req);
                ControllerUtil.transferSessionMessagesToRequest(req);
                ControllerUtil.forward(req, resp, "/tasks.jsp");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getRequestURI();

        if (action == null || action.isEmpty()) {
            ControllerUtil.forward(req, resp, "/index.jsp");
            return;
        }

        switch (action) {
            case "/crud-manager/task/insert":
                insertTask(req);
                break;
            case "/crud-manager/task/update":
                updateTask(req);
                break;
            case "/crud-manager/task/delete":
                deleteTask(req);
                break;
            default:
                System.out.println("URL inválida " + action);
        }

        ControllerUtil.redirect(resp, req.getContextPath() + "/tasks");
    }

    private void listTasks(HttpServletRequest req) {
        TaskDAO dao = DAOFactory.createDAO(TaskDAO.class);
        try {
        	UserDAO userDao = DAOFactory.createDAO(UserDAO.class);
        	List<User> users = userDao.listAll();
        	req.setAttribute("users", users);
            List<Task> tasks = dao.listAll();
            req.setAttribute("tasks", tasks);
        } catch (ModelException e) {
            e.printStackTrace();
        }
    }

    private Task loadTask(HttpServletRequest req) {
        String idStr = req.getParameter("taskId");
        if (idStr == null || idStr.isEmpty()) return null;

        try {
            int id = Integer.parseInt(idStr);
            TaskDAO dao = DAOFactory.createDAO(TaskDAO.class);
            Task task = dao.findById(id);
            if (task == null) throw new ModelException("Tarefa não encontrada.");
            return task;
        } catch (Exception e) {
            e.printStackTrace();
            ControllerUtil.errorMessage(req, e.getMessage());
        }

        return null;
    }

    private void insertTask(HttpServletRequest req) {
        Task task = buildTaskFromRequest(req);

        TaskDAO dao = DAOFactory.createDAO(TaskDAO.class);
        try {
            if (dao.save(task)) {
                ControllerUtil.sucessMessage(req, "Tarefa inserida com sucesso.");
            } else {
                ControllerUtil.errorMessage(req, "Erro ao inserir tarefa.");
            }
        } catch (ModelException e) {
            e.printStackTrace();
            ControllerUtil.errorMessage(req, e.getMessage());
        }
    }

    private void updateTask(HttpServletRequest req) {
        Task task = loadTask(req);
        if (task == null) return;

        Task updated = buildTaskFromRequest(req);
        task.setDescription(updated.getDescription());
        task.setStatus(updated.getStatus());
        task.setDueDate(updated.getDueDate());
        task.setUserId(updated.getUserId());

        TaskDAO dao = DAOFactory.createDAO(TaskDAO.class);
        try {
            if (dao.update(task)) {
                ControllerUtil.sucessMessage(req, "Tarefa atualizada com sucesso.");
            } else {
                ControllerUtil.errorMessage(req, "Erro ao atualizar tarefa.");
            }
        } catch (ModelException e) {
            e.printStackTrace();
            ControllerUtil.errorMessage(req, e.getMessage());
        }
    }

    private void deleteTask(HttpServletRequest req) {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) return;

        try {
            int id = Integer.parseInt(idStr);
            TaskDAO dao = DAOFactory.createDAO(TaskDAO.class);
            Task task = dao.findById(id);
            if (task == null) throw new ModelException("Tarefa não encontrada.");

            if (dao.delete(task)) {
                ControllerUtil.sucessMessage(req, "Tarefa deletada com sucesso.");
            } else {
                ControllerUtil.errorMessage(req, "Erro ao deletar tarefa.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ControllerUtil.errorMessage(req, e.getMessage());
        }
    }

    private Task buildTaskFromRequest(HttpServletRequest req) {
        Task task = new Task();
        task.setDescription(req.getParameter("description"));
        task.setStatus(req.getParameter("status"));

        String dueDateStr = req.getParameter("dueDate");
        if (dueDateStr != null && !dueDateStr.isEmpty()) {
            task.setDueDate(Date.valueOf(dueDateStr)); // Converte yyyy-MM-dd para java.sql.Date
        }

        String userIdStr = req.getParameter("userId");
        if (userIdStr != null && !userIdStr.isEmpty()) {
            task.setUserId(Integer.parseInt(userIdStr));
        }

        return task;
    }
}
