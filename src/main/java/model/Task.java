package model;

import java.util.Calendar;
import java.util.Date;

public class Task {
    private int id;
    private String description;
    private String status;
    private Date dueDate;
    private int userId;

    public Task() {}
    public Task(int id) {
        this.id = id;
    }

    // Getters e Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
