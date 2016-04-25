from matplotlib import pyplot as plt
import numpy as np

normal = np.loadtxt("./correlation12_normal.txt")
fft = np.loadtxt("./correlation12_fft.txt")
assert(normal.shape == fft.shape)

N = len(normal)
f, (ax1, ax2) = plt.subplots(2)
ax1.plot(np.arange(N), normal)
ax2.plot(np.arange(N), fft)
plt.show()


normal = np.loadtxt("./correlation3_normal.txt")
fft = np.loadtxt("./correlation3_fft.txt")
assert(normal.shape == fft.shape)

N = len(normal)
f, (ax1, ax2) = plt.subplots(2)
ax1.plot(np.arange(N), normal)
ax2.plot(np.arange(N), fft)
plt.show()


wdata1 = np.loadtxt("./wdata1.txt")
wdata2 = np.loadtxt("./wdata2.txt")
assert(wdata1.shape == wdata2.shape)

N = len(wdata1)
f, (ax1, ax2) = plt.subplots(2)
ax1.plot(np.arange(N), wdata1)
ax2.plot(np.arange(N), wdata2)
plt.show()
