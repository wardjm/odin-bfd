package bfd

import "core:c"
import "core:c/libc"

foreign import lib {
    "system:bfd"
}

bfd_format :: enum {
    bfd_unknown = 0,	/* file format is unknown */
    bfd_object,	/* linker/assember/compiler output */
    bfd_archive,	/* object archive file */
    bfd_core,		/* core dump */
    bfd_type_end	/* marks the end; don't use it! */
}

bfdt :: struct {
    filename : cstring,
    xvec : ^bfd_target,
    garbarge: [124]u8, // TODO: Add stuff in as we need it
    sections: ^asection,
    sections_last: ^asection,
    section_count: u32,
    archive_plugin_fd: i32,
    archive_plugin_fd_open_count: u32,
    archive_pass: i32,
    alloc_size: u32,
    start_address: u64
}

bfd_target :: struct {
    name : cstring,
    flavour : u8
}

reloc_howto :: struct {}
relax_table :: struct {}

reloc_cache_entry :: struct {

    /* A pointer into the canonical table of pointers  */
    sym_ptr_ptr : ^^reloc_cache_entry,
    
    /* offset in section */
    address : u64,
    
    /* addend for relocation value */
    addend : u64,
    
    /* Pointer to how to perform the required relocation */
    howto : ^reloc_howto
    
}



SEC_NO_FLAGS  ::                    0x0

  /* Tells the OS to allocate space for this section when loading.
     This is clear for a section containing debug information only.  */
SEC_ALLOC      ::                   0x1

  /* Tells the OS to load the section from the file when loading.
     This is clear for a .bss section.  */
SEC_LOAD        ::                  0x2

  /* The section contains data still to be relocated, so there is
     some relocation information too.  */
SEC_RELOC        ::                 0x4

  /* A signal to the OS that the section contains read only data.  */
SEC_READONLY      ::                0x8

  /* The section contains code only.  */
SEC_CODE           ::              0x10

  /* The section contains data only.  */
SEC_DATA            ::             0x20

  /* The section will reside in ROM.  */
SEC_ROM              ::            0x40


asection :: struct {
    
    /* The name of the section; the name isn't a copy, the pointer is
     the same as that passed to bfd_make_section.  */
    
    name: cstring,
    
    /* A unique sequence number.  */
    
    id : u32,

    section_id : u32,
    
    /* Which section is it; 0..nth.  */
    
    index : u32,
    
    /* The next section in the list belonging to the BFD, or NULL.  */
    
    next : ^asection,

    prev: ^asection,
    
    /* The field flags contains attributes of the section. Some
     flags are read in from the object file, and some are
     synthesized from other information.  */
    
    flags : u32,

//    flags2 : u64,
    /* Some internal packed boolean fields.  */
    
    /* See the vma field.  */
//    unsigned int user_set_vma : 1;
    
    /* Whether relocations have been processed.  */
  //  unsigned int reloc_done : 1;
    
  /* A mark flag used by some of the linker backends.  */
    //unsigned int linker_mark : 1;

    /* Another mark flag used by some of the linker backends.  Set for
     output sections that have a input section.  */
    //unsigned int linker_has_input : 1;
    
    /* A mark flag used by some linker backends for garbage collection.  */
    //unsigned int gc_mark : 1;
    
    /* Used by the ELF code to mark sections which have been allocated to segments.  */
    //unsigned int segment_mark : 1;
    
    /* End of internal packed boolean fields.  */
    
    /*  The virtual memory address of the section - where it will be
      at run time.  The symbols are relocated against this.  The
      user_set_vma flag is maintained by bfd; if it's not set, the
      backend can assign addresses (for example, in <<a.out>>, where
      the default address for <<.data>> is dependent on the specific
      target and various flags).  */
    
    vma : u64,
    
    /*  The load address of the section - where it would be in a
      rom image; really only used for writing section header
      information. */
    
    lma : u64,
    
    /* The size of the section in octets, as it will be output.
     Contains a value even if the section has no contents (e.g., the
     size of <<.bss>>).  This will be filled in after relocation.  */
    
    size : u64,
    
    /* The original size on disk of the section, in octets.  Normally this
     value is the same as the size, but if some relaxing has
     been done, then this value will be bigger.  */
    
    rawsize : u64,
    
    /* If this section is going to be output, then this value is the
     offset in *bytes* into the output section of the first byte in the
     input section (byte ==> smallest addressable unit on the
     target).  In most cases, if this was going to start at the
     100th octet (8-bit quantity) in the output section, this value
     would be 100.  However, if the target byte size is 16 bits
     (bfd_octets_per_byte is "2"), this value would be 50.  */

    compressed_size : u64,


    relax : ^relax_table,

    relax_count: i32,
    
    output_offset: u64,

    /* The output section through which to map on output.  */
    
    output_section : ^asection,
    
    /* The alignment requirement of the section, as an exponent of 2 -
     e.g., 3 aligns to 2^3 (or 8).  */
    
    alignment_power : u32,
    
    /* If an input section, a pointer to a vector of relocation
     records for the data in this section.  */
    
    relocation : ^reloc_cache_entry,
    
    /* If an output section, a pointer to a vector of pointers to
     relocation records for the data in this section.  */
    
    orelocation : ^^reloc_cache_entry,
    
    /* The number of relocation records in one of the above  */
    
    reloc_count : u32,
    
    /* Information below is back end specific - and not always used
     or updated.  */

    // TODO: File stuff? Do we need?

}

bfd_architecture :: enum {

    bfd_arch_unknown,   /* File arch not known.  */
    bfd_arch_obscure,   /* Arch known, not one of these.  */
    bfd_arch_m68k,      /* Motorola 68xxx.  */
    bfd_arch_vax,       /* DEC Vax.  */
    bfd_arch_or1k,      /* OpenRISC 1000.  */
    bfd_arch_sparc,     /* SPARC.  */
    bfd_arch_spu,       /* PowerPC SPU.  */
    bfd_arch_mips,      /* MIPS Rxxxx.  */
    bfd_arch_i386,      /* Intel 386.  */
    bfd_arch_l1om,      /* Intel L1OM.  */
    bfd_arch_k1om,      /* Intel K1OM.  */
    bfd_arch_iamcu,     /* Intel MCU.  */
    bfd_arch_romp,      /* IBM ROMP PC/RT.  */
    bfd_arch_convex,    /* Convex.  */
    bfd_arch_m98k,      /* Motorola 98xxx.  */
    bfd_arch_pyramid,   /* Pyramid Technology.  */
    bfd_arch_h8300,     /* Renesas H8/300 (formerly Hitachi H8/300).  */
    bfd_arch_pdp11,     /* DEC PDP-11.  */
    bfd_arch_powerpc,   /* PowerPC.  */
    bfd_arch_rs6000,    /* IBM RS/6000.  */
    bfd_arch_hppa,      /* HP PA RISC.  */
    bfd_arch_d10v,      /* Mitsubishi D10V.  */
    bfd_arch_d30v,      /* Mitsubishi D30V.  */
    bfd_arch_dlx,       /* DLX.  */
    bfd_arch_m68hc11,   /* Motorola 68HC11.  */
    bfd_arch_m68hc12,   /* Motorola 68HC12.  */
    bfd_arch_m9s12x,    /* Freescale S12X.  */
    bfd_arch_m9s12xg,   /* Freescale XGATE.  */
    bfd_arch_s12z,    /* Freescale S12Z.  */
    bfd_arch_z8k,       /* Zilog Z8000.  */
    bfd_arch_sh,        /* Renesas / SuperH SH (formerly Hitachi SH).  */
    bfd_arch_alpha,     /* Dec Alpha.  */
    bfd_arch_arm,       /* Advanced Risc Machines ARM.  */
    bfd_arch_nds32,     /* Andes NDS32.  */
    bfd_arch_ns32k,     /* National Semiconductors ns32000.  */
    bfd_arch_tic30,     /* Texas Instruments TMS320C30.  */
    bfd_arch_tic4x,     /* Texas Instruments TMS320C3X/4X.  */
    bfd_arch_tic54x,    /* Texas Instruments TMS320C54X.  */
    bfd_arch_tic6x,     /* Texas Instruments TMS320C6X.  */
    bfd_arch_v850,      /* NEC V850.  */
    bfd_arch_v850_rh850,/* NEC V850 (using RH850 ABI).  */
    bfd_arch_arc,       /* ARC Cores.  */
    bfd_arch_m32c,       /* Renesas M16C/M32C.  */
    bfd_arch_m32r,      /* Renesas M32R (formerly Mitsubishi M32R/D).  */
    bfd_arch_mn10200,   /* Matsushita MN10200.  */
    bfd_arch_mn10300,   /* Matsushita MN10300.  */
    bfd_arch_fr30,
    bfd_arch_frv,
    bfd_arch_moxie,     /* The moxie processor.  */
    bfd_arch_ft32,      /* The ft32 processor.  */
    bfd_arch_mcore,
    bfd_arch_mep,
    bfd_arch_metag,
    bfd_arch_ia64,      /* HP/Intel ia64.  */
    bfd_arch_ip2k,      /* Ubicom IP2K microcontrollers. */
    bfd_arch_iq2000,     /* Vitesse IQ2000.  */
    bfd_arch_bpf,       /* Linux eBPF.  */
    bfd_arch_epiphany,  /* Adapteva EPIPHANY.  */
    bfd_arch_mt,
    bfd_arch_pj,
    bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
    bfd_arch_bfin,      /* ADI Blackfin.  */
    bfd_arch_cr16,      /* National Semiconductor CompactRISC (ie CR16).  */
    bfd_arch_crx,       /*  National Semiconductor CRX.  */
    bfd_arch_cris,      /* Axis CRIS.  */
    bfd_arch_riscv,
    bfd_arch_rl78,
    bfd_arch_rx,        /* Renesas RX.  */
    bfd_arch_s390,      /* IBM s390.  */
    bfd_arch_score,     /* Sunplus score.  */
    bfd_arch_mmix,      /* Donald Knuth's educational processor.  */
    bfd_arch_xstormy16,
    bfd_arch_msp430,    /* Texas Instruments MSP430 architecture.  */
    bfd_arch_xc16x,     /* Infineon's XC16X Series.  */
    bfd_arch_xgate,     /* Freescale XGATE.  */
    bfd_arch_xtensa,    /* Tensilica's Xtensa cores.  */
    bfd_arch_z80,
    bfd_arch_lm32,      /* Lattice Mico32.  */
    bfd_arch_microblaze,/* Xilinx MicroBlaze.  */
    bfd_arch_tilepro,   /* Tilera TILEPro.  */
    bfd_arch_tilegx,    /* Tilera TILE-Gx.  */
    bfd_arch_aarch64,   /* AArch64.  */
    bfd_arch_nios2,     /* Nios II.  */
    bfd_arch_visium,    /* Visium.  */
    bfd_arch_wasm32,    /* WebAssembly.  */
    bfd_arch_pru,       /* PRU.  */
    bfd_arch_nfp,       /* Netronome Flow Processor */
    bfd_arch_csky,      /* C-SKY.  */
    bfd_arch_loongarch,       /* LoongArch */
    bfd_arch_last

}


bfd_arch_info_type :: struct {
    
    bits_per_word : i32,
    bits_per_address : i32,
    bits_per_byte : i32,
    arch : u8,
    mach : u32,
    arch_name : cstring,
    printable_name : cstring,
    section_align_power : u32,

}


bfd_error_type :: enum {
    bfd_error_no_error = 0,
    bfd_error_system_call,
    bfd_error_invalid_target,
    bfd_error_wrong_format,
    bfd_error_wrong_object_format,
    bfd_error_invalid_operation,
    bfd_error_no_memory,
    bfd_error_no_symbols,
    bfd_error_no_armap,
    bfd_error_no_more_archived_files,
    bfd_error_malformed_archive,
    bfd_error_missing_dso,
    bfd_error_file_not_recognized,
    bfd_error_file_ambiguously_recognized,
    bfd_error_no_contents,
    bfd_error_nonrepresentable_section,
    bfd_error_no_debug_section,
    bfd_error_bad_value,
    bfd_error_file_truncated,
    bfd_error_file_too_big,
    bfd_error_sorry,
    bfd_error_on_input,
    bfd_error_invalid_error_code
}

bfd_flavour :: enum
{
    /* N.B. Update bfd_flavour_name if you change this.  */
    bfd_target_unknown_flavour,
    bfd_target_aout_flavour,
    bfd_target_coff_flavour,
    bfd_target_ecoff_flavour,
    bfd_target_xcoff_flavour,
    bfd_target_elf_flavour,
    bfd_target_tekhex_flavour,
    bfd_target_srec_flavour,
    bfd_target_verilog_flavour,
    bfd_target_ihex_flavour,
    bfd_target_som_flavour,
    bfd_target_os9k_flavour,
    bfd_target_versados_flavour,
    bfd_target_msdos_flavour,
    bfd_target_ovax_flavour,
    bfd_target_evax_flavour,
    bfd_target_mmo_flavour,
    bfd_target_mach_o_flavour,
    bfd_target_pef_flavour,
    bfd_target_pef_xlib_flavour,
    bfd_target_sym_flavour
}

bfd_mach_i386_intel_syntax  ::   (1 << 0)
bfd_mach_i386_i8086         ::   (1 << 1)
bfd_mach_i386_i386          ::   (1 << 2)
bfd_mach_x86_64             ::   (1 << 3)
bfd_mach_x64_32             ::   (1 << 4)

/* Attributes of a symbol.  */
BSF_NO_FLAGS         ::   0

/* The symbol has local scope; <<static>> in <<C>>. The value
     is the offset into the section of the data.  */
BSF_LOCAL               :: (1 << 0)

/* The symbol has global scope; initialized data in <<C>>. The
     value is the offset into the section of the data.  */
BSF_GLOBAL              :: (1 << 1)

/* The symbol has global scope and is exported. The value is
     the offset into the section of the data.  */
BSF_EXPORT             :: BSF_GLOBAL /* No real difference.  */

/* A normal C symbol would be one of:
     <<BSF_LOCAL>>, <<BSF_UNDEFINED>> or <<BSF_GLOBAL>>.  */


/* The symbol is a debugging record. The value has an arbitrary
     meaning, unless BSF_DEBUGGING_RELOC is also set.  */
BSF_DEBUGGING     ::      (1 << 2)

/* The symbol denotes a function entry point.  Used in ELF,
     perhaps others someday.  */
BSF_FUNCTION      ::      (1 << 3)

/* Used by the linker.  */
BSF_KEEP                :: (1 << 5)

  /* An ELF common symbol.  */
BSF_ELF_COMMON          :: (1 << 6)

/* A weak global symbol, overridable without warnings by
     a regular global symbol of the same name.  */
BSF_WEAK                :: (1 << 7)

/* This symbol was created to point to a section, e.g. ELF's
     STT_SECTION symbols.  */
BSF_SECTION_SYM         :: (1 << 8)

/* The symbol used to be a common symbol, but now it is
     allocated.  */
BSF_OLD_COMMON          :: (1 << 9)

/* In some files the type of a symbol sometimes alters its
     location in an output file - ie in coff a <<ISFCN>> symbol
     which is also <<C_EXT>> symbol appears where it was
     declared and not at the end of a section.  This bit is set
     by the target BFD part to convey this information.  */
BSF_NOT_AT_END          :: (1 << 10)

/* Signal that the symbol is the label of constructor section.  */
BSF_CONSTRUCTOR         :: (1 << 11)

/* Signal that the symbol is a warning symbol.  The name is a
     warning.  The name of the next symbol is the one to warn about;
     if a reference is made to a symbol with the same name as the next
     symbol, a warning is issued by the linker.  */
BSF_WARNING             :: (1 << 12)

/* Signal that the symbol is indirect.  This symbol is an indirect
     pointer to the symbol with the same name as the next symbol.  */
BSF_INDIRECT            :: (1 << 13)

/* BSF_FILE marks symbols that contain a file name.  This is used
     for ELF STT_FILE symbols.  */
BSF_FILE                :: (1 << 14)

/* Symbol is from dynamic linking information.  */
BSF_DYNAMIC             :: (1 << 15)

/* The symbol denotes a data object.  Used in ELF, and perhaps
     others someday.  */
BSF_OBJECT              :: (1 << 16)

/* This symbol is a debugging symbol.  The value is the offset
     into the section of the data.  BSF_DEBUGGING should be set
     as well.  */
BSF_DEBUGGING_RELOC     :: (1 << 17)

/* This symbol is thread local.  Used in ELF.  */
BSF_THREAD_LOCAL        :: (1 << 18)

/* This symbol represents a complex relocation expression,
     with the expression tree serialized in the symbol name.  */
BSF_RELC                :: (1 << 19)

/* This symbol represents a signed complex relocation expression,
     with the expression tree serialized in the symbol name.  */
BSF_SRELC               :: (1 << 20)

/* This symbol was created by bfd_get_synthetic_symtab.  */
BSF_SYNTHETIC           :: (1 << 21)

/* This symbol is an indirect code object.  Unrelated to BSF_INDIRECT.
     The dynamic linker will compute the value of this symbol by
     calling the function that it points to.  BSF_FUNCTION must
     also be also set.  */
BSF_GNU_INDIRECT_FUNCTION :: (1 << 22)

/* This symbol is a globally unique data object.  The dynamic linker
     will make sure that in the entire process there is just one symbol
     with this name and type in use.  BSF_OBJECT must also be set.  */
BSF_GNU_UNIQUE          :: (1 << 23)

/* This section symbol should be included in the symbol table.  */
BSF_SECTION_SYM_USED    :: (1 << 24)


asymbol :: struct {
    /* A pointer to the BFD which owns the symbol. This information
     is necessary so that a back end can work out what additional
     information (invisible to the application writer) is carried
     with the symbol.

     This field is *almost* redundant, since you can use section->owner
     instead, except that some symbols point to the global sections
     bfd_{abs,com,und}_section.  This could be fixed by making
     these globals be per-bfd (or per-target-flavor).  FIXME.  */
    the_bfd : ^bfdt, /* Use bfd_asymbol_bfd(sym) to access this field.  */
    
    /* The text of the symbol. The name is left alone, and not copied; the
     application may not alter it.  */
    name : cstring,

    /* The value of the symbol.  This really should be a union of a
     numeric value with a pointer, since some flags indicate that
     a pointer to another symbol is stored here.  */
    value : u64,
    flags : u32,

  /* A pointer to the section to which this symbol is
     relative.  This will always be non NULL, there are special
     sections for undefined and absolute symbols.  */
    section : ^asection,
    p : u64
}

bfd_get_arch :: proc(arch_info : ^bfd_arch_info_type) -> bfd_architecture {
    ret : bfd_architecture = bfd_architecture(arch_info.arch)
    return ret
}

bfd_get_flavour :: proc(abfd: ^bfdt) -> bfd_flavour {
    ret : bfd_flavour = bfd_flavour(abfd.xvec.flavour)
    return ret
}

bfd_get_start_address :: proc(abfd: ^bfdt) -> u64 {
    return abfd.start_address
}

bfd_asymbol_value :: proc(sy: ^asymbol) -> u64 {
    return sy.section.vma + sy.value
}

foreign lib {
    bfd_init :: proc() ---
    bfd_openr :: proc(filename: cstring, target: cstring) -> ^bfdt ---
    bfd_check_format :: proc(abfd: ^bfdt, format: bfd_format) -> bool ---
    bfd_get_section_by_name :: proc(abfd: ^bfdt, section: cstring) -> ^asection ---
    bfd_set_error :: proc(error_tag: bfd_error_type) ---
    bfd_get_error :: proc() -> bfd_error_type ---
    bfd_errmsg :: proc(error_tag : bfd_error_type) -> cstring ---
    bfd_get_arch_info :: proc(abfd : ^bfdt) -> ^bfd_arch_info_type ---
    _bfd_elf_get_symtab_upper_bound :: proc(^bfdt) -> i64 ---
    _bfd_elf_get_dynamic_symtab_upper_bound :: proc(^bfdt) -> i64 ---
    _bfd_elf_canonicalize_symtab :: proc(^bfdt, []^asymbol) -> i64 ---
    _bfd_elf_canonicalize_dynamic_symtab :: proc(^bfdt, []^asymbol) -> i64 ---
    bfd_get_section_contents :: proc(^bfdt, ^asection, ^u8, u64, u64) -> bool ---
}
