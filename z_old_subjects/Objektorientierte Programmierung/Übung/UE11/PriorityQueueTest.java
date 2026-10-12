import java.util.Random;

void main() {
    Random rand = new Random(1234);
    int n = 100;

    PriorityQueue queue = new PriorityQueue(n);


    for (int i = 0; i < n; i++) {
        int duration = rand.nextInt(10, 31);
        int dueDate = rand.nextInt(100, n * 20);
        Job job = new Job(String.format("Job %3d", i), duration, dueDate);
        queue.insert(job.getPriority(), job);
    }

    int curTime = 0;
    int jobsInTime = 0;
    int jobsDelayed = 0;
    int totalTardiness = 0;

    while (!queue.isEmpty()) {
        Job j = (Job)queue.removeMax();
        curTime += j.getDuration();
        if (curTime <= j.getDueDate()) {
            IO.println(curTime + ": " + j);
            jobsInTime++;
        } else {
            IO.println(curTime + ": " + j + " too late!");
            jobsDelayed++;
            totalTardiness += curTime - j.getDueDate();
        }
    }

    IO.println("Jobs in Time:    " + jobsInTime);
    IO.println("Jobs delayed:    " + jobsDelayed);
    IO.println("Total tardiness: " + totalTardiness);

}