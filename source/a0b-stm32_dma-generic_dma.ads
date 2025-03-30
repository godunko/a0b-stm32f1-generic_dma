--
--  Copyright (C) 2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with System;

--  with A0B.ARMv7M;
with A0B.Callbacks;
with A0B.Peripherals.DMA;
--  with A0B.Peripherals.DMAMUX;
with A0B.Types;

generic
   type Interrupt_Number is range <>;

   with procedure Clear_Pending (Interrupt : Interrupt_Number);

   with procedure Enable_Interrupt (Interrupt : Interrupt_Number);

   --  with procedure Disable_Interrupt (Interrupt : Interrupt_Number);

package A0B.STM32_DMA.Generic_DMA
  with Pure
is

--     type Multiplexer_Input_Line is new A0B.Types.Unsigned_7;
--
--     SPI1_RX : constant Multiplexer_Input_Line := 10;
--     SPI1_TX : constant Multiplexer_Input_Line := 11;

   type DMA_Channel
     (Peripheral : not null access A0B.Peripherals.DMA.DMA_Registers;
      Channel    : A0B.STM32_DMA.DMA_Channel_Number;
      Interrupt  : Interrupt_Number)
   is tagged limited private
     with Preelaborable_Initialization;

   not overriding procedure Initialize (Self : in out DMA_Channel);

   procedure Configure_Peripheral_To_Memory
     (Self                 : in out DMA_Channel'Class;
      Priority             : A0B.STM32_DMA.Priority_Level;
      Peripheral_Address   : System.Address;
      Peripheral_Data_Size : A0B.STM32_DMA.Data_Size;
      Memory_Data_Size     : A0B.STM32_DMA.Data_Size);

   procedure Configure_Memory_To_Peripheral
     (Self                 : in out DMA_Channel'Class;
      Priority             : A0B.STM32_DMA.Priority_Level;
      Peripheral_Address   : System.Address;
      Peripheral_Data_Size : A0B.STM32_DMA.Data_Size;
      Memory_Data_Size     : A0B.STM32_DMA.Data_Size);

--     procedure Initialize
--       (Self      : in out DMA_Channel'Class;
--        Input     : Multiplexer_Input_Line;
--        Direction : A0B.Peripherals.DMA.Direction;
--        Priority  : A0B.Peripherals.DMA.Priority_Level);
--
--     procedure Set_Peripheral
--       (Self      : in out DMA_Channel'Class;
--        Address   : System.Address;
--        Size      : A0B.Peripherals.DMA.Data_Size;
--        Increment : Boolean);

   procedure Set_Memory
     (Self            : in out DMA_Channel'Class;
      Memory_Address  : System.Address;
      Number_Of_Items : A0B.Types.Unsigned_16);

   procedure Set_Transfer_Completed_Callback
     (Self     : in out DMA_Channel'Class;
      Callback : A0B.Callbacks.Callback);

--     procedure Set_Number_Of_Data
--       (Self           : in out DMA_Channel'Class;
--        Number_Of_Data : A0B.Types.Unsigned_16);

   function Get_Number_Of_Items
     (Self : DMA_Channel'Class) return A0B.Types.Unsigned_16;

   procedure Enable (Self : in out DMA_Channel'Class);

   procedure Disable (Self : in out DMA_Channel'Class);

   function Is_Enabled (Self : DMA_Channel'Class) return Boolean;

   procedure Enable_Transfer_Completed_Interrupt
     (Self : in out DMA_Channel'Class);

--     procedure Disable_Transfer_Completed (Self : in out DMA_Channel'Class);
--
--     function Get_Masked_And_Clear_Transfer_Completed
--       (Self : in out DMA_Channel'Class) return Boolean;

private

   type DMA_Channel
     (Peripheral : not null access A0B.Peripherals.DMA.DMA_Registers;
      Channel    : A0B.STM32_DMA.DMA_Channel_Number;
      Interrupt  : Interrupt_Number)
   is tagged limited record
      Callback : A0B.Callbacks.Callback;
   end record;

   procedure On_Interrupt (Self : in out DMA_Channel'Class);

end A0B.STM32_DMA.Generic_DMA;
