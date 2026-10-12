/* MiniJava:                                                  HDO, 2025-03-11
   --------

 Main program, provides parser, interpreter and compiler for MiniJava, grammar:

  MiniJava = "void" "main" "(" ")" "{"
                [ VarDecl ]
                StatSeq
              "}" eof .

  VarDecl =  "int" ident { "," ident } ";" .

  StatSeq =  Stat { Stat } .

  Stat =     [ ident "=" Expr
             | "print" "(" Expr  ")"
             ] ";" .

  Expr =	   Term { "+" Term | "-" Term } .
  Term =	   Fact { "*" Fact | "/" Fact } .
  Fact =	   number | ident |
             "read" "(" ")" |
             "(" Expr ")" .

============================================================================*/

import java.io.*;

public class MiniJava {

  public static void main(String[] args) {

    String         sourceFileName   = null;
    BufferedReader sourceFileReader = null;

    IO.println("MiniJava V. 0 (2025)\n");
    do {
      IO.print("source file name > ");
      sourceFileName = IO.readln();
      try {
         sourceFileReader = new BufferedReader(new FileReader(sourceFileName));
      } catch(IOException e) {
        IO.println("error: source file not found\n");
      } // catch
    } while (sourceFileReader == null);

    Scanner scanner = new Scanner(sourceFileReader); // the one and only


    try {
      CodeGenerator codeGenerator = new CodeGenerator();
      Compiler compiler = new Compiler(scanner, codeGenerator);
      compiler.compile(); // and generate code

      byte[] codeArray = codeGenerator.getCode();
      IO.println(codeArray.length + " bytes of code generated");
      Decoder decoder = new Decoder(codeArray);
      decoder.decode();

      // direct execution of code array
      VirtualMachine virtualMachine1 = new VirtualMachine(codeArray);
      virtualMachine1.run();

      // store code array in a file, then read this file and execute it
      int    dotPos       = sourceFileName.indexOf('.');
      String codeFileName = sourceFileName.substring(0, dotPos) + ".mjc";
      IO.println("storing code in   file " + codeFileName);
      codeGenerator.writeCode(codeFileName);
      IO.println("reading code from file " + codeFileName);
      VirtualMachine virtualMachine2 = new VirtualMachine(codeFileName);
      virtualMachine2.run();
      break;

    } catch (SyntaxError se) {
      IO.println("syntax error in line " + scanner.syLnr +
           ", column " + scanner.syCnr + ": " + se.getMessage());
      System.exit(1);
    } // catch
    IO.println("\nsource file processed successfully");

  } // main

} // MiniJava
