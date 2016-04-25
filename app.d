import std.stdio;
import std.file;

import correlation;


void main() {
    writeln("Store data files to the same location as the binary, "
            "then run $./app.\n"
            "The results will be saved as correlation*.txt");

    auto data3 = slurp!double("data3.txt", "%s ");
    auto wdata1 = slurp!double("wdata1.txt", "%s ");
    auto wdata2 = slurp!double("wdata2.txt", "%s ");

    auto normal12 = cross_correlation(wdata1, wdata2, false);
    auto fft12 = cross_correlation_fft(wdata1, wdata2);
    save("correlation12_normal.txt", normal12);
    save("correlation12_fft.txt", fft12);

    auto normal3 = cross_correlation(data3, data3, false);
    auto fft3 = cross_correlation_fft(data3, data3);
    save("correlation3_normal.txt", normal3);
    save("correlation3_fft.txt", fft3);
}
