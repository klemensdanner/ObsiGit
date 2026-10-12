void main() {

    ObjPriorityQueue queue = new ObjPriorityQueue();

    int n = 100;
    java.util.Random rand = new java.util.Random(3141);
    for (int i = 0; i < n; i++) {
        int duration = rand.nextInt(10, 31);
        int dueDate = rand.nextInt(100, n * 20);
        Job j = new Job(String.format("Job %3d", i), duration, dueDate);
        queue.insert(j.priority(), j);
    }

    // simulate processing
    int currTime = 0;
    int numInTimeJobs = 0;
    int numDelayedJobs = 0;
    int totalTardiness = 0;
    while (!queue.isEmpty()) {
        Job j = (Job)queue.removeMax();
        currTime += j.getDuration();
        if (currTime <= j.getDueDate()) {
            IO.println(currTime + ": " + j + " on time.");
            numInTimeJobs++;
        } else {
            IO.println(currTime + ": " + j + " too late.");
            numDelayedJobs++;        
            totalTardiness += currTime - j.getDueDate();    
        }
    }
    IO.println("jobs on time: " + numInTimeJobs);
    IO.println("jobs delayed: " + numDelayedJobs);
    IO.println("total tardiness: " + totalTardiness);

}