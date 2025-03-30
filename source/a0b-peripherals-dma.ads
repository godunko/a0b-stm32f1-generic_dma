--
--  Copyright (C) 2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Common definitions for STM32F1+ [RM0008]
--
--  DMA: Direct memory access controller
--
--  STM32F1 support 8/16/32 bits accesses, while G4 only supports 32bits
--  accesses.

pragma Ada_2022;

with System;

with A0B.STM32_DMA;
with A0B.Types;

package A0B.Peripherals.DMA
  with Pure, No_Elaboration_Code_All
is

   DMA_ISR_Offset    : constant := 16#00#;
   DMA_IFCR_Offset   : constant := 16#04#;
   DMA_CCRx_Offset   : constant := 16#08#;
   DMA_CNDTRx_Offset : constant := 16#0C#;
   DMA_CPARx_Offset  : constant := 16#10#;
   DMA_CMARx_Offset  : constant := 16#14#;

   type Channel_Number is range 1 .. 8;

   type Direction is (Read_From_Peripheral, Read_From_Memory);

   -------------
   -- DMA_CCR --
   -------------

   type DMA_CCR_Register is record
      EN             : Boolean;
      TCIE           : Boolean;
      HTIE           : Boolean;
      TEIE           : Boolean;
      DIR            : Direction;
      CIRC           : Boolean;
      PINC           : Boolean;
      MINC           : Boolean;
      PSIZE          : A0B.STM32_DMA.Data_Size;
      MSIZE          : A0B.STM32_DMA.Data_Size;
      PL             : A0B.STM32_DMA.Priority_Level;
      MEM2MEM        : Boolean;
      Reserved_15_31 : A0B.Types.Reserved_17;
   end record with Size => 32;

   for DMA_CCR_Register use record
      EN             at 0 range 0 .. 0;
      TCIE           at 0 range 1 .. 1;
      HTIE           at 0 range 2 .. 2;
      TEIE           at 0 range 3 .. 3;
      DIR            at 0 range 4 .. 4;
      CIRC           at 0 range 5 .. 5;
      PINC           at 0 range 6 .. 6;
      MINC           at 0 range 7 .. 7;
      PSIZE          at 0 range 8 .. 9;
      MSIZE          at 0 range 10 .. 11;
      PL             at 0 range 12 .. 13;
      MEM2MEM        at 0 range 14 .. 14;
      Reserved_15_31 at 0 range 15 .. 31;
   end record;

   --------------
   -- DMA_CMAR --
   --------------

   type DMA_CMAR_Register is record
      MA : System.Address;
   end record with Size => 32;

   ---------------
   -- DMA_CNDTR --
   ---------------

   type DMA_CNDTR_Register is record
      NDT            : A0B.Types.Unsigned_16;
      Reserved_16_31 : A0B.Types.Reserved_16;
   end record with Size => 32;

   for DMA_CNDTR_Register use record
      NDT            at 0 range 0 .. 15;
      Reserved_16_31 at 0 range 16 .. 31;
   end record;

   --------------
   -- DMA_CPAR --
   --------------

   type DMA_CPAR_Register is record
      PA : System.Address;
   end record with Size => 32;

   --------------
   -- DMA_IFCR --
   --------------

   type DMA_IFCR_Flags is record
      CGIF  : Boolean;
      CTCIF : Boolean;
      CHTIF : Boolean;
      CTEIF : Boolean;
   end record with Size => 4;

   for DMA_IFCR_Flags use record
      CGIF  at 0 range 0 .. 0;
      CTCIF at 0 range 1 .. 1;
      CHTIF at 0 range 2 .. 2;
      CTEIF at 0 range 3 .. 3;
   end record;

   type DMA_IFCR_IFCR_Field is
     array (A0B.STM32_DMA.DMA_Channel_Number) of DMA_IFCR_Flags
       with Pack, Size => 32;

   type DMA_IFCR_Register is record
      IFCR : DMA_IFCR_IFCR_Field;
   end record with Size => 32;

   -------------
   -- DMA_ISR --
   -------------

   type DMA_ISR_Flags is record
      GIF  : Boolean;
      TCIF : Boolean;
      HTIF : Boolean;
      TEIF : Boolean;
   end record with Size => 4;

   for DMA_ISR_Flags use record
      GIF  at 0 range 0 .. 0;
      TCIF at 0 range 1 .. 1;
      HTIF at 0 range 2 .. 2;
      TEIF at 0 range 3 .. 3;
   end record;

   type DMA_ISR_ISR_Field is
     array (A0B.STM32_DMA.DMA_Channel_Number) of DMA_ISR_Flags
       with Pack, Size => 32;

   type DMA_ISR_Register is record
      ISR : DMA_ISR_ISR_Field;
   end record with Size => 32;

   ---------
   -- DMA --
   ---------

   type Channel_Registers is record
      DMA_CCR   : DMA_CCR_Register   with Volatile, Full_Access_Only;
      DMA_CNDTR : DMA_CNDTR_Register with Volatile, Full_Access_Only;
      DMA_CPAR  : DMA_CPAR_Register  with Volatile, Full_Access_Only;
      DMA_CMAR  : DMA_CMAR_Register  with Volatile, Full_Access_Only;
      Reserved  : A0B.Types.Reserved_32;
   end record with Size => 160;

   for Channel_Registers use record
      DMA_CCR   at DMA_CCRx_Offset - DMA_CCRx_Offset range 0 .. 31;
      DMA_CNDTR at DMA_CNDTRx_Offset - DMA_CCRx_Offset range 0 .. 31;
      DMA_CPAR  at DMA_CPARx_Offset - DMA_CCRx_Offset range 0 .. 31;
      DMA_CMAR  at DMA_CMARx_Offset - DMA_CCRx_Offset range 0 .. 31;
   end record;

   type Channel_Array is
     array (A0B.STM32_DMA.DMA_Channel_Number) of Channel_Registers
       with Pack, Size => 8 * 160;

   type DMA_Registers is record
      DMA_ISR  : DMA_ISR_Register with Volatile, Full_Access_Only;
      DMA_IFCR : DMA_IFCR_Register with Volatile, Full_Access_Only;
      Channel  : Channel_Array;
   end record;

   for DMA_Registers use record
      DMA_ISR  at DMA_ISR_Offset range 0 .. 31;
      DMA_IFCR at DMA_IFCR_Offset range 0 .. 31;
      Channel  at DMA_CCRx_Offset range 0 .. 1_279;
   end record;

end A0B.Peripherals.DMA;
