--
--  Copyright (C) 2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

generic
   type DMA_Channel (<>) is new Abstract_DMA_Channel with private;

   Channel : in out DMA_Channel;

procedure A0B.STM32_DMA.Generic_DMA.Generic_DMA1_CH2_Handler
  with Pure;
