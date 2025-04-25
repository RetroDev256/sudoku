/* This is a linker script to make tiny, but possibly INCORRECT programs */
ENTRY(_start)
 
PHDRS {
  text PT_LOAD; /* RWX */
}

SECTIONS {
	.text SIZEOF_HEADERS : {
		*(.text*)
		*(.rodata*)
		*(.data*)
		*(.bss*)
		*(COMMON*)
	}

	/DISCARD/ : {
		*(.comment*)
		*(.eh_frame*)
		*(.eh_frame_hdr*)
	}
}
