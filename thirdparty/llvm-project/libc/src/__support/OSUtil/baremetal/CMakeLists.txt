add_header_library(
  baremetal_util
  HDRS
    io.h
    quick_exit.h
  DEPENDS
    libc.src.__support.common
    libc.src.__support.CPP.string_view
)
