--
--  Copyright (C) 2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package A0B.STM32_DMA
  with Pure, No_Elaboration_Code_All
is

   type DMA_Channel_Number is range 1 .. 8;

   type Data_Size is (Size_8_Bits, Size_16_Bits, Size_32_Bits, Reserved_11)
     with Size => 2;

   type Priority_Level is (Low, Medium, High, Very_High) with Size => 2;

end A0B.STM32_DMA;
