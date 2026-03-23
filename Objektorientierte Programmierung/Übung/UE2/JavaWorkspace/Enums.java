/* Enums:                                                      DA, 2026-03-19 */
/* ------                                                                     */
/* enumerations                                                               */
/* ========================================================================== */

enum CharacterType {
    DIGIT, LETTER, PUNCTUATION, OTHER;
}

CharacterType characterTypeOf(char ch) {
    if (ch >= '0' && ch <= '9') return CharacterType.DIGIT;
    else if ((ch >= 'a' && ch <= 'z') || 
            (ch >= 'A' && ch <= 'Z')) return CharacterType.LETTER;
    else if ((ch == '.') || (ch == ':') || (ch == '!') || (ch == '?') || 
            (ch == '-')) return CharacterType.PUNCTUATION;
    else return CharacterType.OTHER;

}

void main() {
    IO.println("characterTypeOf('3' = " + characterTypeOf('3'));
    IO.println("characterTypeOf('k' = " + characterTypeOf('k'));
    IO.println("characterTypeOf('-' = " + characterTypeOf('-'));
    IO.println("characterTypeOf('C' = " + characterTypeOf('C'));


    CharacterType[] characterTypeValues = CharacterType.values();
    for (int i = 0; i < characterTypeValues.length; i++) {
        IO.println(characterTypeValues[i]);
    }
    //oder

    for (CharacterType value : CharacterType.values()) {
        IO.println(value);
    }

}