#pragma once

#include <string>
// NOTE: not using namespace std;

namespace swc3 {
    // struct: defaults to public
    // class: defaults to private
    class Person { // maybe final if no OOP
    public:
        explicit Person(const std::string &name = "");

        virtual ~Person(); // why virtual? -> destruct also derived parts
        void set_name(const std::string &name);

        [[nodiscard]] const std::string &get_name() const;

        void print() const;

    private:
        std::string m_name;
    };
}
