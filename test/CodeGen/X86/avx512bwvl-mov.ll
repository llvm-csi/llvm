; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -march=x86-64 -mtriple=x86_64-apple-darwin -mcpu=knl -mattr=+avx512bw -mattr=+avx512vl --show-mc-encoding| FileCheck %s

define <32 x i8> @test_256_1(i8 * %addr) {
; CHECK-LABEL: test_256_1:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vmovdqu8 (%rdi), %ymm0 ## encoding: [0x62,0xf1,0x7f,0x28,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %vaddr = bitcast i8* %addr to <32 x i8>*
  %res = load <32 x i8>, <32 x i8>* %vaddr, align 1
  ret <32 x i8>%res
}

define void @test_256_2(i8 * %addr, <32 x i8> %data) {
; CHECK-LABEL: test_256_2:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vmovdqu8 %ymm0, (%rdi) ## encoding: [0x62,0xf1,0x7f,0x28,0x7f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %vaddr = bitcast i8* %addr to <32 x i8>*
  store <32 x i8>%data, <32 x i8>* %vaddr, align 1
  ret void
}

define <32 x i8> @test_256_3(i8 * %addr, <32 x i8> %old, <32 x i8> %mask1) {
; CHECK-LABEL: test_256_3:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vpxord %ymm2, %ymm2, %ymm2 ## encoding: [0x62,0xf1,0x6d,0x28,0xef,0xd2]
; CHECK-NEXT:    vpcmpneqb %ymm2, %ymm1, %k1 ## encoding: [0x62,0xf3,0x75,0x28,0x3f,0xca,0x04]
; CHECK-NEXT:    vmovdqu8 (%rdi), %ymm0 {%k1} ## encoding: [0x62,0xf1,0x7f,0x29,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %mask = icmp ne <32 x i8> %mask1, zeroinitializer
  %vaddr = bitcast i8* %addr to <32 x i8>*
  %r = load <32 x i8>, <32 x i8>* %vaddr, align 1
  %res = select <32 x i1> %mask, <32 x i8> %r, <32 x i8> %old
  ret <32 x i8>%res
}

define <32 x i8> @test_256_4(i8 * %addr, <32 x i8> %mask1) {
; CHECK-LABEL: test_256_4:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vpxord %ymm1, %ymm1, %ymm1 ## encoding: [0x62,0xf1,0x75,0x28,0xef,0xc9]
; CHECK-NEXT:    vpcmpneqb %ymm1, %ymm0, %k1 ## encoding: [0x62,0xf3,0x7d,0x28,0x3f,0xc9,0x04]
; CHECK-NEXT:    vmovdqu8 (%rdi), %ymm0 {%k1} {z} ## encoding: [0x62,0xf1,0x7f,0xa9,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %mask = icmp ne <32 x i8> %mask1, zeroinitializer
  %vaddr = bitcast i8* %addr to <32 x i8>*
  %r = load <32 x i8>, <32 x i8>* %vaddr, align 1
  %res = select <32 x i1> %mask, <32 x i8> %r, <32 x i8> zeroinitializer
  ret <32 x i8>%res
}

define <16 x i16> @test_256_5(i8 * %addr) {
; CHECK-LABEL: test_256_5:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vmovdqu16 (%rdi), %ymm0 ## encoding: [0x62,0xf1,0xff,0x28,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %vaddr = bitcast i8* %addr to <16 x i16>*
  %res = load <16 x i16>, <16 x i16>* %vaddr, align 1
  ret <16 x i16>%res
}

define void @test_256_6(i8 * %addr, <16 x i16> %data) {
; CHECK-LABEL: test_256_6:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vmovdqu16 %ymm0, (%rdi) ## encoding: [0x62,0xf1,0xff,0x28,0x7f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %vaddr = bitcast i8* %addr to <16 x i16>*
  store <16 x i16>%data, <16 x i16>* %vaddr, align 1
  ret void
}

define <16 x i16> @test_256_7(i8 * %addr, <16 x i16> %old, <16 x i16> %mask1) {
; CHECK-LABEL: test_256_7:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vpxord %ymm2, %ymm2, %ymm2 ## encoding: [0x62,0xf1,0x6d,0x28,0xef,0xd2]
; CHECK-NEXT:    vpcmpneqw %ymm2, %ymm1, %k1 ## encoding: [0x62,0xf3,0xf5,0x28,0x3f,0xca,0x04]
; CHECK-NEXT:    vmovdqu16 (%rdi), %ymm0 {%k1} ## encoding: [0x62,0xf1,0xff,0x29,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %mask = icmp ne <16 x i16> %mask1, zeroinitializer
  %vaddr = bitcast i8* %addr to <16 x i16>*
  %r = load <16 x i16>, <16 x i16>* %vaddr, align 1
  %res = select <16 x i1> %mask, <16 x i16> %r, <16 x i16> %old
  ret <16 x i16>%res
}

define <16 x i16> @test_256_8(i8 * %addr, <16 x i16> %mask1) {
; CHECK-LABEL: test_256_8:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vpxord %ymm1, %ymm1, %ymm1 ## encoding: [0x62,0xf1,0x75,0x28,0xef,0xc9]
; CHECK-NEXT:    vpcmpneqw %ymm1, %ymm0, %k1 ## encoding: [0x62,0xf3,0xfd,0x28,0x3f,0xc9,0x04]
; CHECK-NEXT:    vmovdqu16 (%rdi), %ymm0 {%k1} {z} ## encoding: [0x62,0xf1,0xff,0xa9,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %mask = icmp ne <16 x i16> %mask1, zeroinitializer
  %vaddr = bitcast i8* %addr to <16 x i16>*
  %r = load <16 x i16>, <16 x i16>* %vaddr, align 1
  %res = select <16 x i1> %mask, <16 x i16> %r, <16 x i16> zeroinitializer
  ret <16 x i16>%res
}

define <16 x i8> @test_128_1(i8 * %addr) {
; CHECK-LABEL: test_128_1:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vmovdqu8 (%rdi), %xmm0 ## encoding: [0x62,0xf1,0x7f,0x08,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %vaddr = bitcast i8* %addr to <16 x i8>*
  %res = load <16 x i8>, <16 x i8>* %vaddr, align 1
  ret <16 x i8>%res
}

define void @test_128_2(i8 * %addr, <16 x i8> %data) {
; CHECK-LABEL: test_128_2:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vmovdqu8 %xmm0, (%rdi) ## encoding: [0x62,0xf1,0x7f,0x08,0x7f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %vaddr = bitcast i8* %addr to <16 x i8>*
  store <16 x i8>%data, <16 x i8>* %vaddr, align 1
  ret void
}

define <16 x i8> @test_128_3(i8 * %addr, <16 x i8> %old, <16 x i8> %mask1) {
; CHECK-LABEL: test_128_3:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vpxord %xmm2, %xmm2, %xmm2 ## encoding: [0x62,0xf1,0x6d,0x08,0xef,0xd2]
; CHECK-NEXT:    vpcmpneqb %xmm2, %xmm1, %k1 ## encoding: [0x62,0xf3,0x75,0x08,0x3f,0xca,0x04]
; CHECK-NEXT:    vmovdqu8 (%rdi), %xmm0 {%k1} ## encoding: [0x62,0xf1,0x7f,0x09,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %mask = icmp ne <16 x i8> %mask1, zeroinitializer
  %vaddr = bitcast i8* %addr to <16 x i8>*
  %r = load <16 x i8>, <16 x i8>* %vaddr, align 1
  %res = select <16 x i1> %mask, <16 x i8> %r, <16 x i8> %old
  ret <16 x i8>%res
}

define <16 x i8> @test_128_4(i8 * %addr, <16 x i8> %mask1) {
; CHECK-LABEL: test_128_4:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vpxord %xmm1, %xmm1, %xmm1 ## encoding: [0x62,0xf1,0x75,0x08,0xef,0xc9]
; CHECK-NEXT:    vpcmpneqb %xmm1, %xmm0, %k1 ## encoding: [0x62,0xf3,0x7d,0x08,0x3f,0xc9,0x04]
; CHECK-NEXT:    vmovdqu8 (%rdi), %xmm0 {%k1} {z} ## encoding: [0x62,0xf1,0x7f,0x89,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %mask = icmp ne <16 x i8> %mask1, zeroinitializer
  %vaddr = bitcast i8* %addr to <16 x i8>*
  %r = load <16 x i8>, <16 x i8>* %vaddr, align 1
  %res = select <16 x i1> %mask, <16 x i8> %r, <16 x i8> zeroinitializer
  ret <16 x i8>%res
}

define <8 x i16> @test_128_5(i8 * %addr) {
; CHECK-LABEL: test_128_5:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vmovdqu16 (%rdi), %xmm0 ## encoding: [0x62,0xf1,0xff,0x08,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %vaddr = bitcast i8* %addr to <8 x i16>*
  %res = load <8 x i16>, <8 x i16>* %vaddr, align 1
  ret <8 x i16>%res
}

define void @test_128_6(i8 * %addr, <8 x i16> %data) {
; CHECK-LABEL: test_128_6:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vmovdqu16 %xmm0, (%rdi) ## encoding: [0x62,0xf1,0xff,0x08,0x7f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %vaddr = bitcast i8* %addr to <8 x i16>*
  store <8 x i16>%data, <8 x i16>* %vaddr, align 1
  ret void
}

define <8 x i16> @test_128_7(i8 * %addr, <8 x i16> %old, <8 x i16> %mask1) {
; CHECK-LABEL: test_128_7:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vpxord %xmm2, %xmm2, %xmm2 ## encoding: [0x62,0xf1,0x6d,0x08,0xef,0xd2]
; CHECK-NEXT:    vpcmpneqw %xmm2, %xmm1, %k1 ## encoding: [0x62,0xf3,0xf5,0x08,0x3f,0xca,0x04]
; CHECK-NEXT:    vmovdqu16 (%rdi), %xmm0 {%k1} ## encoding: [0x62,0xf1,0xff,0x09,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %mask = icmp ne <8 x i16> %mask1, zeroinitializer
  %vaddr = bitcast i8* %addr to <8 x i16>*
  %r = load <8 x i16>, <8 x i16>* %vaddr, align 1
  %res = select <8 x i1> %mask, <8 x i16> %r, <8 x i16> %old
  ret <8 x i16>%res
}

define <8 x i16> @test_128_8(i8 * %addr, <8 x i16> %mask1) {
; CHECK-LABEL: test_128_8:
; CHECK:       ## BB#0:
; CHECK-NEXT:    vpxord %xmm1, %xmm1, %xmm1 ## encoding: [0x62,0xf1,0x75,0x08,0xef,0xc9]
; CHECK-NEXT:    vpcmpneqw %xmm1, %xmm0, %k1 ## encoding: [0x62,0xf3,0xfd,0x08,0x3f,0xc9,0x04]
; CHECK-NEXT:    vmovdqu16 (%rdi), %xmm0 {%k1} {z} ## encoding: [0x62,0xf1,0xff,0x89,0x6f,0x07]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %mask = icmp ne <8 x i16> %mask1, zeroinitializer
  %vaddr = bitcast i8* %addr to <8 x i16>*
  %r = load <8 x i16>, <8 x i16>* %vaddr, align 1
  %res = select <8 x i1> %mask, <8 x i16> %r, <8 x i16> zeroinitializer
  ret <8 x i16>%res
}

