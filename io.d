import std.stdio;
import std.string;
import std.algorithm;
import std.conv;


double[] load(string filename) {
    auto file = File(filename);

    double[] array = [];
    foreach(line; file.byLine) {
        line = line.strip;
        array ~= line.to!double;
    }
    return array;
}


void save(T)(string filename, T[] array) {
    auto f = File(filename, "w");
    f.write(map!(to!string)(array).join("\n"));
}

