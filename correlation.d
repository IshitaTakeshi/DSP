import std.string;
import std.stdio;
import std.math;
import std.numeric;
import std.file;
import std.algorithm;
import std.complex;
import std.range;
import std.array;
import std.conv;

import util : distance, append_zeros;
import io : load, save;


double cross_correlation_nonrecursive(double[] xs, double[] ys, ulong m)
in {
    assert(xs.length == ys.length);
    assert(m < xs.length);
}
body {
    ulong N = xs.length;
    double c = 0;
    for(ulong i = 0; i < xs.length; i++) {
        if(0 <= i+m && i+m < N) {
            c += xs[i] * ys[i+m];
        }
    }
    return c / N;
}


double cross_correlation_recursive(double[] xs, double[] ys, ulong m)
in {
    assert(xs.length == ys.length);
    assert(m < xs.length);
}
body {
    ulong N = xs.length;
    double c = 0;
    for(ulong i = 0; i < xs.length; i++) {
        c += xs[i] * ys[(i+m) % N];
    }
    return c / N;
}


double[] cross_correlation(double[] xs, double[] ys, bool recursive = true)
in {
    assert(xs.length == ys.length);
}
body {
    ulong N = xs.length;
    double[] c = new double[N];
    for(ulong m = 0; m < N; m++) {
        if(recursive) {
            c[m] = cross_correlation_recursive(xs, ys, m);
        } else {
            c[m] = cross_correlation_nonrecursive(xs, ys, m);
        }
    }
    return c;
}
unittest {
    double[] xs, ys, r, expected;

    xs = ys = [2, 1, 0, 1];

    r = cross_correlation(xs, ys, true);
    assert(equal(r, [1.5, 1, 0.5, 1]));

    r = cross_correlation(xs, ys, false);
    assert(equal(r, [1.5, 0.5, 0.25, 0.5]));

    xs = ys = [1, 2, 2];

    r = cross_correlation(xs, ys, true).map!(a => a.re).array;
    expected = array([9., 8., 8.].map!(a => a/3));
    assert(equal(r, expected));

    r = cross_correlation(xs, ys, false).map!(a => a.re).array;
    expected = array([9., 6., 2.].map!(a => a/3));
    assert(equal(r, expected));

    xs = [2, 1, 1];
    ys = [1, 3, 1];
    r = cross_correlation(xs, ys, false).map!(a => a.re).array;
    expected = array([6., 7., 2.].map!(a => a/3));
    assert(equal(r, expected));
}


// non recursive as default
double[] cross_correlation_fft(double[] xs, double[] ys)
in {
    assert(xs.length == ys.length);
}
body {
    const ulong N = xs.length;  //keep the size

    int length = 1;
    while(length < N) {
        length *= 2;
    }

    xs = append_zeros(xs, length*2);
    ys = append_zeros(ys, length*2);

    auto X = xs.fft();
    auto Y = ys.fft();
    auto r = zip(Y, X).map!(a => a[0] * a[1].conj);
    auto c = r.inverseFft.map!(a => a.re / N);
    return array(c[0..N]);
}
unittest {
    double[] xs, ys, r, expected;

    xs = ys = [2, 1, 0, 1];

    r = cross_correlation_fft(xs, ys).map!(a => a.re).array;
    assert(distance(r, [1.5, 0.5, 0.25, 0.5]) < 0.001);

    r = cross_correlation_fft(xs, ys).map!(a => a.re).array;
    assert(distance(r, [1.5, 0.5, 0.25, 0.5]) < 0.001);

    xs = ys = [1, 2, 2];

    r = cross_correlation_fft(xs, ys).map!(a => a.re).array;
    expected = array([9., 6., 2.].map!(a => a/3));
    assert(distance(r, expected) < 0.001);

    xs = [2, 1, 1];
    ys = [1, 3, 1];
    r = cross_correlation_fft(xs, ys).map!(a => a.re).array;
    expected = array([6., 7., 2.].map!(a => a/3));
    assert(distance(r, expected) < 0.001);
}


