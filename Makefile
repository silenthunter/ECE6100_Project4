all:
	iverilog GT_IFU.v GT_main_memory.v GT_cache.v GT_direct_map.v GT_victim.v Sync_counter_32bit.v Toggle_FF.v basics.v driver.v
test_ifu:
	iverilog GT_IFU.v GT_main_memory.v Sync_counter_32bit.v Toggle_FF.v basics.v test_GT_IFU.v
