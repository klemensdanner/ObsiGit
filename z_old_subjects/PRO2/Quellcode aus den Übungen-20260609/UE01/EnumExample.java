enum CharacterType {
    DIGIT, LETTER, PUNCTUATION, OTHER;
}

CharacterType characterType(char ch) {
    if (ch >= '0' && ch <= '9') { return CharacterType.DIGIT; } 
    else if ((ch >= 'a' && ch <= 'z') || 
             (ch >= 'A' && ch <= 'Z')) { return CharacterType.LETTER; }
    else if (ch == '.' || ch == ',' || 
             ch == '?' || ch == '!' ||
             ch == ';') { return CharacterType.PUNCTUATION; }
    else return CharacterType.OTHER;
}

void main()  {
    IO.println(characterType('n'));
    IO.println(characterType('P'));
    IO.println(characterType('3'));
    IO.println(characterType('!'));
    IO.println(characterType('%'));
}