import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_counter(dut):
    """Verify reset, counting, and 4-bit overflow."""

    # Initialize inputs
    dut.clk.value = 0
    dut.rst.value = 1

    # Apply synchronous reset at a rising clock edge
    await Timer(5, unit="ns")
    dut.clk.value = 1
    await Timer(1, unit="ns")

    assert int(dut.count.value) == 0, "Counter should be zero after reset"

    # Deassert reset and check counting
    dut.clk.value = 0
    dut.rst.value = 0
    await Timer(5, unit="ns")

    for expected in range(1, 16):
        dut.clk.value = 1
        await Timer(1, unit="ns")

        assert int(dut.count.value) == expected, (
            f"Expected {expected}, got {int(dut.count.value)}"
        )

        dut.clk.value = 0
        await Timer(4, unit="ns")

    # Check 4-bit overflow: 15 -> 0
    dut.clk.value = 1
    await Timer(1, unit="ns")

    assert int(dut.count.value) == 0, "Counter should wrap from 15 to 0"
