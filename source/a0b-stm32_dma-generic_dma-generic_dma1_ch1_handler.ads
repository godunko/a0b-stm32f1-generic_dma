--
--  Copyright (C) 2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  with System;
--
--  with A0B.ARMv7M;
--  with A0B.Callbacks;
--  with A0B.Peripherals.DMA;
--  with A0B.Peripherals.DMAMUX;
--  with A0B.Types;

generic
   type DMA_Channel (<>) is
     new A0B.STM32_DMA.Generic_DMA.DMA_Channel with private;
   --  type DMA_Channel is new A0B.stm
   --  type Interrupt_Number is range <>;
   --
   --  with procedure Clear_Pending (Interrupt : Interrupt_Number);
   --
   --  with procedure Enable_Interrupt (Interrupt : Interrupt_Number);
   --
   --  with procedure Disable_Interrupt (Interrupt : Interrupt_Number);

   --  Channel : in out A0B.STM32_DMA.Generic_DMA.DMA_Channel'Class;
   Channel : in out DMA_Channel;

procedure A0B.STM32_DMA.Generic_DMA.Generic_DMA1_CH1_Handler
  with Pure;  -- , Convention => C;
  --  with Pure, Export, Convention => C; -- , External_Name => "DMA1_CH1_Handler";

--  package A0B.STM32_DMA.Generic_DMA.DMA1_CH1_Handler
--    with Pure, Elaborate_Body
--  is
--
--  end A0B.STM32_DMA.Generic_DMA.DMA1_CH1_Handler;
