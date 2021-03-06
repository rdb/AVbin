LIBNAME=$(OUTDIR)/libavbin.$(AVBIN_VERSION).dylib

CFLAGS += -O3 -arch i386
LDFLAGS += -dylib \
           -arch i386 \
           -install_name @rpath/libavbin.dylib \
           -macosx_version_min 10.6 \
           -framework CoreFoundation \
           -framework CoreVideo \
           -framework VideoDecodeAcceleration \
           -read_only_relocs suppress  # only needed on 32-bit, for some reason.


STATIC_LIBS = $(BACKEND_DIR)/libavformat/libavformat.a \
              $(BACKEND_DIR)/libavcodec/libavcodec.a \
              $(BACKEND_DIR)/libavutil/libavutil.a \
              $(BACKEND_DIR)/libswscale/libswscale.a


LIBS = -lSystem \
       -lz \
       -lbz2


$(LIBNAME) : $(OBJNAME) $(OUTDIR)
	$(LD) $(LDFLAGS) -o $@ $< $(STATIC_LIBS) $(LIBS)
