/* Compiler:                                                  DA, 2026-04-29 */
/* -----------                                                               */
/* Parser for MiniJava with semantic expressions to generate bytecode.       */
/*                                                                           */
/* ========================================================================= */

public class Compiler {

    private final Scanner scanner;
    private final SymbolTable symbolTable;
    private final CodeGenerator codeGenerator;

    private void semanticError(String msg) {
        System.err.println("semantic error: " + msg + " in " +
                           scanner.syLnr + ", column " + scanner.syCnr);
    } // semanticError    

    private void expect(Symbol expectedSy) {
        if (scanner.sy != expectedSy) {
            throw new SyntaxError(expectedSy.toString().toLowerCase() + "expected");
        }
    } // expect

    public Compiler(Scanner scanner, CodeGenerator codeGenerator) {
        this.scanner = scanner;
        this.symbolTable = new SymbolTable();
        this.codeGenerator = codeGenerator;
    }

    public void compile() {
        IO.println("compiling started ...");
        MiniJava();
        IO.println("... compiling finished.");
    } // parse

    public void MiniJava() {
        expect(Symbol.VOID); 
        scanner.nextSy();
        expect(Symbol.MAIN); 
        scanner.nextSy();
        expect(Symbol.OPEN_PAR); 
        scanner.nextSy();
        expect(Symbol.CLOSE_PAR); 
        scanner.nextSy();
        expect(Symbol.OPEN_BRACE); 
        scanner.nextSy();
        if (scanner.sy == Symbol.INT) {
            VarDecl();
        }
        StatSeq();
        expect(Symbol.CLOSE_BRACE); 
        scanner.nextSy();
        expect(Symbol.EOF);
        /* SEM */
        codeGenerator.emit(OpCode.END); 
        /* ENDSEM */
    } // MiniJava

    private void VarDecl() {
        expect(Symbol.INT); 
        scanner.nextSy();
        expect(Symbol.IDENT);
        /* SEM */ 
        symbolTable.declVar(scanner.identStr);
        /* ENDSEM */
        scanner.nextSy();
        while (scanner.sy == Symbol.COMMA) {
            scanner.nextSy();
            expect(Symbol.IDENT); 
            /* SEM */
            if (!symbolTable.declVar(scanner.identStr)) {
                semanticError("multiple declaration");
            } 
            /* ENDSEM */
            scanner.nextSy();
        }
        expect(Symbol.SEMICOLON); 
        scanner.nextSy();
    } // VarDecl

    private void StatSeq() {
        Stat();
        while (scanner.sy == Symbol.IDENT || 
               scanner.sy == Symbol.PRINT ||
               scanner.sy == Symbol.SEMICOLON) {
            Stat();
        }
    } // StatSeq

    private void Stat() {
        if (scanner.sy == Symbol.IDENT) {
            /* SEM */
            boolean isDecl = symbolTable.isDecl(scanner.identStr);
            if (!isDecl) {
                semanticError("variable not declared");
            } else {
                codeGenerator.emit(OpCode.LOAD_ADDR, 
                    symbolTable.addrOf(scanner.identStr));
            }
            /* ENDSEM */
            scanner.nextSy();
            expect(Symbol.ASSIGN); 
            scanner.nextSy();
            Expr();
            /* SEM */
            if (isDecl) codeGenerator.emit(OpCode.STORE);
            /* ENDSEM */
        } else if (scanner.sy == Symbol.PRINT) {
            scanner.nextSy();
            expect(Symbol.OPEN_PAR); 
            scanner.nextSy();
            Expr();
            /* SEM */
            codeGenerator.emit(OpCode.PRINT);
            /* ENDSEM */
            expect(Symbol.CLOSE_PAR); 
            scanner.nextSy();            
        }
        expect(Symbol.SEMICOLON); 
        scanner.nextSy();        
    } // Stat
    
    private void Expr() {
        Term();
        while (scanner.sy == Symbol.PLUS ||
               scanner.sy == Symbol.MINUS) {
            if (scanner.sy == Symbol.PLUS) {
                scanner.nextSy();
                Term();
                /* SEM */ codeGenerator.emit(OpCode.ADD); /* ENDSEM */
            } else { // scanner.sy == Symbol.MINUS
                scanner.nextSy();
                Term();
                /* SEM */ codeGenerator.emit(OpCode.SUB); /* ENDSEM */
            }
        } // while
    } // Expr

    private void Term() {
        Fact();
        while (scanner.sy == Symbol.TIMES ||
               scanner.sy == Symbol.DIV) {
            if (scanner.sy == Symbol.TIMES) {
                scanner.nextSy();
                Fact();
                /* SEM */ codeGenerator.emit(OpCode.MUL); /* ENDSEM */
            } else { // scanner.sy == Symbol.DIV
                scanner.nextSy();
                Fact();
                /* SEM */ codeGenerator.emit(OpCode.DIV); /* ENDSEM */
            }            
        } // while
    } // Term

    private void Fact() {
        switch (scanner.sy) {
            case Symbol.NUMBER:
                /* SEM */ 
                codeGenerator.emit(OpCode.LOAD_CONST, scanner.numberVal); 
                /* ENDSEM */
                scanner.nextSy();
                break;
            case Symbol.IDENT: 
                /* SEM */
                if (!symbolTable.isDecl(scanner.identStr))
                    semanticError("variable not declared");
                else
                    codeGenerator.emit(OpCode.LOAD_VAL, 
                        symbolTable.addrOf(scanner.identStr));
                /* ENDSEM */
                scanner.nextSy();
                break;
            case Symbol.READ: 
                scanner.nextSy();
                expect(Symbol.OPEN_PAR); 
                /* SEM */
                codeGenerator.emit(OpCode.READ);
                /* ENDSEM */
                scanner.nextSy();
                expect(Symbol.CLOSE_PAR); 
                scanner.nextSy();
                break;
            case Symbol.OPEN_PAR:
                scanner.nextSy();
                Expr();
                expect(Symbol.CLOSE_PAR);
                scanner.nextSy();
                break;
            default:
                throw new SyntaxError("number, ident, read or ( expected");
        }
    } // Fact
}