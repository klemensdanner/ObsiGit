public class KnightsTour {
    //private int[][] board;

    public KnightsTour(int n, int m)  {
        //board = new int[n][m];

    }


    public static void clacKnightsTour(int n) {
        int[][] board =  new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                board[i][j] = -1;
            }
        }

        board[0][0] = 0; // start position

        nextMove(0, 0, 1, board);
    }

    public static void nextMove(int x, int y, int tourLength, int[][] board) {
        // non recursive branch
        if (tourLength == board.length * board.length) {
            // done
            // printBoard(board)
            System.exit(0);
        } else {
            // ausgehend von Position (x,y) alle Positionen checken
            int[] dx = {2, 1, -1, -2, -2, -1, 1, 2};
            int[] dy = {1, 2, 2, 1, -1, -2, -2, -1};

            for (int i = 0; i < dx.length; i++) {
                int nx = x + dx[i];
                int ny = y + dy[i];
            }

            if (moveAllowed(nx, ny, board)) {
                board[nx][ny] = tourLength;
                nextMove(nx, ny, tourLength + 1, board);
            }

        }

        public static boolean moveAllowed(int nx, int ny, int[][] board) {
            return true;
        }




    }




}