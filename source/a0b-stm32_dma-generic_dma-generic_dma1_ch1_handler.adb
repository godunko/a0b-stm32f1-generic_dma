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

procedure A0B.STM32_DMA.Generic_DMA.Generic_DMA1_CH1_Handler is
begin
   Channel.On_Interrupt;
end A0B.STM32_DMA.Generic_DMA.Generic_DMA1_CH1_Handler;

--  package body A0B.STM32_DMA.Generic_DMA.DMA1_CH1_Handler is
--
--     procedure DMA1_CH1_Handler
--       with Export, Convention => C, External_Name => "DMA1_CH1_Handler";
--
--     ----------------------
--     -- DMA1_CH1_Handler --
--     ----------------------
--
--     procedure DMA1_CH1_Handler is
--     begin
--        Channel.On_Interrupt;
--     end DMA1_CH1_Handler;
--
--  end A0B.STM32_DMA.Generic_DMA.DMA1_CH1_Handler;
