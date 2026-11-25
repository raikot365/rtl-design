#include <string>
int main() {
    std::string a = "hello";
    std::string b = std::move(a);
    return 0;
}
