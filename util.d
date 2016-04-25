import std.math;


double distance(double[] x, double[] y) {
    assert(x.length == y.length);

    double s = 0;
    for(ulong i = 0; i < x.length; i++) {
        s += pow(x[i]-y[i], 2);
    }
    return sqrt(s);
}


//append zeros so that the length be N
double[] append_zeros(double[] x, ulong N)
out(result) {
    assert(result.length == N);
}
body {
    double[] zeros = new double[N-x.length];
    zeros[0..$] = 0;
    return x ~ zeros;
}

