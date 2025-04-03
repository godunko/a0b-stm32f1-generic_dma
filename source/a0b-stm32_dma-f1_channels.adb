--
--  Copyright (C) 2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body A0B.STM32_DMA.F1_Channels is

--  with A0B.ARMv7M.NVIC_Utilities;
--  with A0B.STM32G4.Peripherals.RCC;
--
--  package body A0B.STM32G4.DMA is
--
--     DMAMUX_Peripheral : A0B.Peripherals.DMAMUX.DMAMUX_Registers
--       with Import, Address => A0B.STM32G4.Peripherals.DMAMUX_Base;
--
--     procedure Configure
--       (Self      : in out DMA_Channel'Class;
--        Input     : Multiplexer_Input_Line;
--        Direction : A0B.Peripherals.DMA.Direction;
--        Priority  : A0B.Peripherals.DMA.Priority_Level);
--
--     ---------------
--     -- Configure --
--     ---------------
--
--     procedure Configure
--       (Self      : in out DMA_Channel'Class;
--        Input     : Multiplexer_Input_Line;
--        Direction : A0B.Peripherals.DMA.Direction;
--        Priority  : A0B.Peripherals.DMA.Priority_Level) is
--     begin
--        declare
--           Value : A0B.Peripherals.DMAMUX.DMAMUX_CxCR_Register :=
--             DMAMUX_Peripheral.DMAMUX_CxCR (Self.Multiplexer_Channel);
--
--        begin
--           Value.DMAREQ_ID :=
--             A0B.Peripherals.DMAMUX.DMAMUX_CxCR_DMAREQ_ID_Field (Input);
--           Value.SOIE      := False;  --  0: Interrupt disabled
--           Value.EGE       := False;  --  0: Event generation disabled
--           Value.SE        := False;  --  0: Synchronization disabled
--           Value.SPOL      := A0B.Peripherals.DMAMUX.No_Event;
--           --  00: No event (no synchronization, no detection).
--           Value.NBREQ     := 0;      --  <>
--           Value.SYNC_ID   := 0;      --  <>
--
--           DMAMUX_Peripheral.DMAMUX_CxCR (Self.Multiplexer_Channel) := Value;
--        end;
--
--        declare
--           Value : A0B.Peripherals.DMA.DMA_CCR_Register :=
--             Self.Peripheral.Channel (Self.Channel).DMA_CCR;
--
--        begin
--        --  EN             : Boolean;
--        --  TCIE           : Boolean;
--        --  HTIE           : Boolean;
--        --  TEIE           : Boolean;
--        --  DIR            : Direction;
--        --  CIRC           : Boolean;
--        --  PINC           : Boolean;
--        --  MINC           : Boolean;
--        --  PSIZE          : Data_Size;
--        --  MSIZE          : Data_Size;
--        --  PL             : Priority_Level;
--        --  MEM2MEM        : Boolean;
--           Value.EN      := False;  --  0: Channel disabled
--           Value.TCIE    := False;  --  0: TC interrupt disabled
--           Value.HTIE    := False;  --  0: HT interrupt disabled
--           Value.TEIE    := False;  --  0: TE interrupt disabled
--           Value.DIR     := Direction;
--           Value.CIRC    := False;  --  0: Circular mode disabled
--           --  Value.PINC
--           --  Value.MINC
--           --  Value.PSIZE
--           --  Value.MSIZE
--           Value.PL      := Priority;
--           Value.MEM2MEM := False;  --  0: Memory to memory mode disabled
--
--           Self.Peripheral.Channel (Self.Channel).DMA_CCR := Value;
--        end;
--
--        A0B.ARMv7M.NVIC_Utilities.Clear_Pending (Self.Interrupt);
--        A0B.ARMv7M.NVIC_Utilities.Enable_Interrupt (Self.Interrupt);
--     end Configure;
--
--     --------------------------------
--     -- Disable_Transfer_Completed --
--     --------------------------------
--
--     procedure Disable_Transfer_Completed (Self : in out DMA_Channel'Class) is
--     begin
--        Self.Peripheral.Channel (Self.Channel).DMA_CCR.TCIE := False;
--     end Disable_Transfer_Completed;
--
--     ----------------
--     -- Initialize --
--     ----------------
--
--     procedure Initialize
--       (Self      : in out DMA_Channel'Class;
--        Input     : Multiplexer_Input_Line;
--        Direction : A0B.Peripherals.DMA.Direction;
--        Priority  : A0B.Peripherals.DMA.Priority_Level) is
--     begin
--        A0B.STM32G4.Peripherals.RCC.RCC_AHB1ENR.DMAMUX1EN := True;
--        A0B.STM32G4.Peripherals.RCC.RCC_AHB1ENR.DMA1EN := True;
--        A0B.STM32G4.Peripherals.RCC.RCC_AHB1ENR.DMA2EN := True;
--
--        Self.Configure (Input, Direction, Priority);
--     end Initialize;
--
--     ----------------
--     -- Set_Memory --
--     ----------------
--
--     procedure Set_Memory
--       (Self      : in out DMA_Channel'Class;
--        Address   : System.Address;
--        Size      : A0B.Peripherals.DMA.Data_Size;
--        Increment : Boolean) is
--     begin
--        declare
--           Value : A0B.Peripherals.DMA.DMA_CCR_Register :=
--             Self.Peripheral.Channel (Self.Channel).DMA_CCR;
--
--        begin
--           Value.MINC  := Increment;
--           Value.MSIZE := Size;
--
--           Self.Peripheral.Channel (Self.Channel).DMA_CCR := Value;
--        end;
--
--        Self.Peripheral.Channel (Self.Channel).DMA_CMAR := (MA => Address);
--     end Set_Memory;
--
--     ------------------------
--     -- Set_Number_Of_Data --
--     ------------------------
--
--     procedure Set_Number_Of_Data
--       (Self           : in out DMA_Channel'Class;
--        Number_Of_Data : A0B.Types.Unsigned_16) is
--     begin
--        Self.Peripheral.Channel (Self.Channel).DMA_CNDTR.NDT := Number_Of_Data;
--     end Set_Number_Of_Data;
--
--     --------------------
--     -- Set_Peripheral --
--     --------------------
--
--     procedure Set_Peripheral
--       (Self      : in out DMA_Channel'Class;
--        Address   : System.Address;
--        Size      : A0B.Peripherals.DMA.Data_Size;
--        Increment : Boolean) is
--     begin
--        declare
--           Value : A0B.Peripherals.DMA.DMA_CCR_Register :=
--             Self.Peripheral.Channel (Self.Channel).DMA_CCR;
--
--        begin
--           Value.PINC  := Increment;
--           Value.PSIZE := Size;
--
--           Self.Peripheral.Channel (Self.Channel).DMA_CCR := Value;
--        end;
--
--        Self.Peripheral.Channel (Self.Channel).DMA_CPAR := (PA => Address);
--     end Set_Peripheral;

   ------------------------------------
   -- Configure_Memory_To_Peripheral --
   ------------------------------------

   procedure Configure_Memory_To_Peripheral
     (Self                 : in out Abstract_DMA_Channel'Class;
      Priority             : A0B.STM32_DMA.Priority_Level;
      Peripheral_Address   : System.Address;
      Peripheral_Data_Size : A0B.STM32_DMA.Data_Size;
      Memory_Data_Size     : A0B.STM32_DMA.Data_Size)
   is
      Registers : A0B.Peripherals.DMA.Channel_Registers
        renames Self.Peripheral.Channel (Self.Channel);

   begin
      declare
         Value : A0B.Peripherals.DMA.DMA_CCR_Register := Registers.DMA_CCR;

      begin
         Value.DIR     := A0B.Peripherals.DMA.Read_From_Memory;
         Value.CIRC    := False;  --  0: Circular mode disabled
         Value.PINC    := False;  --  0: Peripheral increment mode disabled
         Value.MINC    := True;   --  1: Memory increment mode enabled
         Value.PSIZE   := Peripheral_Data_Size;
         Value.MSIZE   := Memory_Data_Size;
         Value.PL      := Priority;
         Value.MEM2MEM := False;  --  0: Memory to memory mode disabled

         Registers.DMA_CCR := Value;
      end;

      Registers.DMA_CPAR := (PA => Peripheral_Address);
   end Configure_Memory_To_Peripheral;

   ------------------------------------
   -- Configure_Peripheral_To_Memory --
   ------------------------------------

   procedure Configure_Peripheral_To_Memory
     (Self                 : in out Abstract_DMA_Channel'Class;
      Priority             : A0B.STM32_DMA.Priority_Level;
      Peripheral_Address   : System.Address;
      Peripheral_Data_Size : A0B.STM32_DMA.Data_Size;
      Memory_Data_Size     : A0B.STM32_DMA.Data_Size)
   is
      Registers : A0B.Peripherals.DMA.Channel_Registers
        renames Self.Peripheral.Channel (Self.Channel);

   begin
      declare
         Value : A0B.Peripherals.DMA.DMA_CCR_Register := Registers.DMA_CCR;

      begin
         Value.DIR     := A0B.Peripherals.DMA.Read_From_Peripheral;
         Value.CIRC    := False;  --  0: Circular mode disabled
         Value.PINC    := False;  --  0: Peripheral increment mode disabled
         Value.MINC    := True;   --  1: Memory increment mode enabled
         Value.PSIZE   := Peripheral_Data_Size;
         Value.MSIZE   := Memory_Data_Size;
         Value.PL      := Priority;
         Value.MEM2MEM := False;  --  0: Memory to memory mode disabled

         Registers.DMA_CCR := Value;
      end;

      Registers.DMA_CPAR := (PA => Peripheral_Address);
   end Configure_Peripheral_To_Memory;

   -------------
   -- Disable --
   -------------

   procedure Disable (Self : in out Abstract_DMA_Channel'Class) is
   begin
      Self.Peripheral.Channel (Self.Channel).DMA_CCR.EN := False;
   end Disable;

   ------------
   -- Enable --
   ------------

   procedure Enable (Self : in out Abstract_DMA_Channel'Class) is
   begin
      Self.Peripheral.Channel (Self.Channel).DMA_CCR.EN := True;
   end Enable;

   -----------------------------------------
   -- Enable_Transfer_Completed_Interrupt --
   -----------------------------------------

   procedure Enable_Transfer_Completed_Interrupt
     (Self : in out Abstract_DMA_Channel'Class) is
   begin
      Self.Peripheral.Channel (Self.Channel).DMA_CCR.TCIE := True;
   end Enable_Transfer_Completed_Interrupt;

   ---------------------------------------------
   -- Get_Masked_And_Clear_Transfer_Completed --
   ---------------------------------------------

   function Get_Masked_And_Clear_Transfer_Completed
     (Self : in out Abstract_DMA_Channel'Class) return Boolean is
   begin
      return Result : constant Boolean :=
        Self.Peripheral.DMA_ISR.ISR (Self.Channel).TCIF
          and Self.Peripheral.Channel (Self.Channel).DMA_CCR.TCIE
      do
         declare
            Value : A0B.Peripherals.DMA.DMA_IFCR_Register :=
              (IFCR => (others => (others => False)));

         begin
            Value.IFCR (Self.Channel).CTCIF := True;
            Self.Peripheral.DMA_IFCR := Value;
         end;
      end return;
   end Get_Masked_And_Clear_Transfer_Completed;

   -------------------------
   -- Get_Number_Of_Items --
   -------------------------

   function Get_Number_Of_Items
     (Self : Abstract_DMA_Channel'Class) return A0B.Types.Unsigned_16 is
   begin
      return Self.Peripheral.Channel (Self.Channel).DMA_CNDTR.NDT;
   end Get_Number_Of_Items;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Abstract_DMA_Channel'Class) is
   begin
      Self.Internal_Initialize;
   end Initialize;

   -------------------------
   -- Internal_Initialize --
   -------------------------

   not overriding procedure Internal_Initialize
     (Self : in out Abstract_DMA_Channel) is
   begin
      --  XXX Enable clocks - it is platform depended

      declare
         Value : A0B.Peripherals.DMA.DMA_CCR_Register :=
           Self.Peripheral.Channel (Self.Channel).DMA_CCR;

      begin
         Value.EN   := False;  --  0: Channel disabled
         Value.TCIE := False;  --  0: TC interrupt disabled
         Value.HTIE := False;  --  0: HT interrupt disabled
         Value.TEIE := False;  --  0: TE interrupt disabled

         Self.Peripheral.Channel (Self.Channel).DMA_CCR := Value;
      end;
   end Internal_Initialize;

   ----------------
   -- Is_Enabled --
   ----------------

   function Is_Enabled (Self : Abstract_DMA_Channel'Class) return Boolean is
   begin
      return Self.Peripheral.Channel (Self.Channel).DMA_CCR.EN;
   end Is_Enabled;

   ------------------
   -- On_Interrupt --
   ------------------

   procedure On_Interrupt (Self : in out Abstract_DMA_Channel'Class) is
   begin
      A0B.Callbacks.Emit (Self.Callback);
   end On_Interrupt;

   ----------------
   -- Set_Memory --
   ----------------

   procedure Set_Memory
     (Self            : in out Abstract_DMA_Channel'Class;
      Memory_Address  : System.Address;
      Number_Of_Items : A0B.Types.Unsigned_16)
   is
      Registers : A0B.Peripherals.DMA.Channel_Registers
        renames Self.Peripheral.Channel (Self.Channel);

   begin
      Registers.DMA_CMAR      := (MA => Memory_Address);
      Registers.DMA_CNDTR.NDT := Number_Of_Items;
   end Set_Memory;

   -------------------------------------
   -- Set_Transfer_Completed_Callback --
   -------------------------------------

   procedure Set_Transfer_Completed_Callback
     (Self     : in out Abstract_DMA_Channel'Class;
      Callback : A0B.Callbacks.Callback) is
   begin
      Self.Callback := Callback;
   end Set_Transfer_Completed_Callback;

end A0B.STM32_DMA.F1_Channels;
