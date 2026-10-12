/* Job:                                                 DA, 2026-05-27 */
/* ------                                                                    */
/*                                                                */
/* ========================================================================= */

public class Job {
    private String descreption;
    private int duration;
    private int dueDate;

    public Job(String descreption, int duration, int dueDate) {
        this.descreption = descreption;
        this.duration = duration;
        this.dueDate = dueDate;
    }


    public int getDuration() {
        return duration;
    }

    public int getDueDate() {
        return dueDate;
    }

    public int getPriority() {
        //return earliestDueDate();
        return shortestProcessingTime();
    }

    @Override
    public String toString() {
        return String.format("%s (duration %3ds due %4d)", descreption, duration, dueDate);
    }

    private int earliestDueDate() {
        return dueDate * -1;
    }

    private int shortestProcessingTime() {
        return duration * -1;
    }
}