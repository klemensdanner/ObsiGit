public class Job {
    private String description;
    private int duration; // in seconds
    private int dueDate;  // time in seconds since start time

    public Job(String description, int duration, int dueDate) {
        assert description != null;
        this.description = description;
        this.duration = duration;
        this.dueDate = dueDate;
    }

    @Override
    public String toString() {
        return String.format("%s duration: %3ds due: %4d", 
                description, duration, dueDate);
    }

    public int getDuration() { return duration; }
    public int getDueDate() { return dueDate; }

    public int priority() {
        return earliestDueDate();
    }

    private int earliestDueDate() {
        return -dueDate;
    }

}
