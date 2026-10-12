/* CodeGenerator:                                             HDO, 2025-03-11
   ------------
  Code generator for the MiniJava compiler to collect bytecode.
============================================================================*/

import java.io.*;
import java.util.*;

public class CodeGenerator {

  private static final int MAX_CODE_LEN = 1000;

  private final byte[] ca = new byte[MAX_CODE_LEN]; // code array
  private int n = 0; // number of bytes in code array

  public CodeGenerator() {
    // nothing to do
  } // CodeGenerator

  public void emit(byte b) {
    ca[n++] = b;
  } // emit

  public void emit(int w) { // emit w >= 0 as four bytes
    for (int i = 0; i < 4; i++) { // format: little endian
      emit((byte) (w % 256));
      w = w / 256;
    } // for
  } // emit

  public void emit(OpCode opc) {
    emit((byte)opc.ordinal()); // one byte
  } // emit

  public void emit(OpCode opc, int opd) {
    emit(opc); // one byte
    emit(opd); // four bytes
  } // emit

  public byte[] getCode() {
    return Arrays.copyOf(ca, n);
  } // getCode

  public void writeCode(String codeFileName) {
    try {
      FileOutputStream   fos = new FileOutputStream(codeFileName);
      ObjectOutputStream oos = new ObjectOutputStream(fos);
      oos.writeObject(Arrays.copyOf(ca, n));
      oos.close();
      fos.close();
    } catch (IOException e) {
      throw new RuntimeException(e.getCause());
    } // catch
  } // writeCode

} // CodeGenerator
