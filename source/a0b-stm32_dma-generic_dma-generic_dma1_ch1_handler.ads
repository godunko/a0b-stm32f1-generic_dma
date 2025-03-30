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
   type DMA_Channel (<>) is new Abstract_DMA_Channel with private;

   Channel : in out DMA_Channel;

procedure A0B.STM32_DMA.Generic_DMA.Generic_DMA1_CH1_Handler
  with Pure;  -- , Convention => C;
  --  with Pure, Export, Convention => C; -- , External_Name => "DMA1_CH1_Handler";

--  package A0B.STM32_DMA.Generic_DMA.DMA1_CH1_Handler
--    with Pure, Elaborate_Body
--  is
--
--  end A0B.STM32_DMA.Generic_DMA.DMA1_CH1_Handler;
