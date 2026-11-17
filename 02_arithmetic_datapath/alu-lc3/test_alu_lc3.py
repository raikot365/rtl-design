import cocotb
from cocotb.triggers import ReadOnly, Timer

@cocotb.test()
async def test_alu_lc3(dut):
    # Test ADD operation 
    dut.a.value = 0x0001
    dut.b.value = 0x0001
    dut.aluk.value = 0b00  # OP_ALU_ADD
    await ReadOnly()
    result = int(dut.alu_out.value)
    dut._log.info(
        f"ADD: a={int(dut.a.value):04X}, "
        f"b={int(dut.b.value):04X}, "
        f"result={result:04X}")
    assert result == 0x0002, "Error en la operación ADD"

    await Timer(10, unit="ns")
    # Test ADD operation with overflow
    dut.a.value = 0xFFFF
    dut.b.value = 0x0001
    dut.aluk.value = 0b00  # OP_ALU_ADD
    await ReadOnly()
    result = int(dut.alu_out.value)
    dut._log.info(
        f"ADD with overflow: a={int(dut.a.value):04X}, "
        f"b={int(dut.b.value):04X}, "
        f"result={result:04X}")
    assert result == 0x0000, "Error en la operación ADD con overflow"

    await Timer(10, unit="ns")
    # Test AND operation
    dut.a.value = 0x00FF
    dut.b.value = 0x0F0F
    dut.aluk.value = 0b01  # OP_ALU_AND
    await ReadOnly()
    result = int(dut.alu_out.value)
    dut._log.info(
        f"AND: a={int(dut.a.value):04X}, "
        f"b={int(dut.b.value):04X}, "
        f"result={result:04X}")
    assert result == 0x000F, "Error en la operación AND"

    await Timer(10, unit="ns")
    # Test AND operation
    dut.a.value = 0xFFFF
    dut.b.value = 0x0000
    dut.aluk.value = 0b01  # OP_ALU_AND
    await ReadOnly()
    result = int(dut.alu_out.value)
    dut._log.info(
        f"AND: a={int(dut.a.value):04X}, "
        f"b={int(dut.b.value):04X}, "
        f"result={result:04X}")
    assert result == 0x0000, "Error en la operación AND"

    await Timer(10, unit="ns")
    # Test NOT operation
    dut.a.value = 0x0001
    dut.aluk.value = 0b10  # OP_ALU_NOT
    await ReadOnly()
    result = int(dut.alu_out.value)
    dut._log.info(
        f"NOT: a={int(dut.a.value):04X}, "
        f"result={result:04X}")
    assert result == 0xFFFE, "Error en la operación NOT"

    await Timer(10, unit="ns")
    # Test NOT operation
    dut.a.value = 0x0000
    dut.aluk.value = 0b10  # OP_ALU_NOT
    await ReadOnly()
    result = int(dut.alu_out.value)
    dut._log.info(
        f"NOT: a={int(dut.a.value):04X}, "
        f"result={result:04X}")
    assert result == 0xFFFF, "Error en la operación NOT"

    await Timer(10, unit="ns")
    # Test PASS operation
    dut.a.value = 0x1001
    dut.aluk.value = 0b11  # OP_ALU_PASS
    await ReadOnly()
    result = int(dut.alu_out.value)
    dut._log.info(
        f"PASS: a={int(dut.a.value):04X}, "
        f"result={result:04X}")
    assert result == 0x1001, "Error en la operación PASS"

    await Timer(10, unit="ns")
    # Test PASS operation with different value
    dut.a.value = 0xABCD
    dut.aluk.value = 0b11  # OP_ALU_PASS
    await ReadOnly()
    result = int(dut.alu_out.value)
    dut._log.info(
        f"PASS: a={int(dut.a.value):04X}, "
        f"result={result:04X}")
    assert result == 0xABCD, "Error en la operación PASS"