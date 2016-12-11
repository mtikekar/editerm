# usage: python convert_png.py png1 png2 ...
# an icon.h file will be created that is suitable for st and tabbed
from scipy import misc
import numpy as np
import sys

h_f = open("icon.h", "w")
n = 0
h_f.write('static unsigned long icon_buffer[] = {\n')

for img in sys.argv[1:]:
    print("%s added to icon.h" % img)
    i = misc.imread(img)
    h, w, comp = i.shape
    assert(comp == 4)

    c = i[:,:,[2,1,0,3]].copy()
    c = c.view(dtype=np.uint32).reshape(h, w)

    h_f.write('{}, {},\n'.format(w, h))
    np.savetxt(h_f, c, fmt='0x%08x', delimiter=', ', newline=',\n')
    n += 2 + h*w

h_f.write('};\n')
h_f.write('static unsigned int icon_buffer_length = {};\n'.format(n))
h_f.close()
