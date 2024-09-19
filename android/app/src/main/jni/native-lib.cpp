#include <string>

extern "C" {
// Define a native function that returns a string
std::string nativeGetString() {
    return "Hello from native code!";
}
}