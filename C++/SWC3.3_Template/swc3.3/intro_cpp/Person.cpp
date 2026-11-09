#include "Person.h"

#include <string>
#include <print>
#include <iostream>

namespace swc3 {
    Person::Person(const std::string &name) : m_name(name) {
        std::println("Person::({}) constructed", this->m_name);
    }

    Person::~Person() {
        std::println("Person::({}) destroyed", this->m_name);
    }

    void Person::set_name(const std::string &name) {
        this->m_name = name; // NOTE: automatically copied std::string::operator = ()
    }

    const std::string &Person::get_name() const {
        return m_name;
    }

    void Person::print() const {
        std::print("Person({})", m_name);
    }
    using std::cout;
    using std::endl;
    using std::cin;

    static void test_iostream() {
        cout << "hello, world!" << endl;

        int i = 0;
        char s[10];

        cout << "Enter your name";
        cin >> s;

        cout << "Number is " << i << "and the string is " << s << endl;

    }


}
