/*
 * Copyright © 2017 Eric Matthews,  Lesley Shannon
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Initial code developed under the supervision of Dr. Lesley Shannon,
 * Reconfigurable Computing Lab, Simon Fraser University.
 *
 * Author(s):
 *             Eric Matthews <ematthew@sfu.ca>
 */

package taiga_config;

    parameter FPGA_VENDOR = "xilinx"; //xilinx or intel

    parameter XLEN = 32;
    parameter ADDR_W = 32;

    parameter CPU_ID = 0;//32 bit value

    parameter bit[31:0] RESET_VEC = 32'h00000000;
    parameter ASIDLEN = 7;//pid
    parameter PAGE_ADDR_W = 12;

    parameter TIMER_W = 33; //32 days @ 100MHz

    parameter USE_MUL = 1;
    parameter USE_DIV = 1;
    parameter USE_VARIABLE_LATENCY_DIV = 0;

    parameter USE_AMO = 0;

    parameter NUM_WB_UNITS = 6;
    parameter WB_UNITS_WIDTH = $clog2(NUM_WB_UNITS);

   typedef enum {//bit [WB_UNITS_WIDTH-1:0] {
        ALU_UNIT_ID = 0,
        BRANCH_UNIT_ID=1,
        CSR_UNIT_ID = 2,
        LS_UNIT_ID = 3,
        MUL_UNIT_ID = 4,
        DIV_UNIT_ID = 5,
        CUSTOM_ID_0 = 6,
        CUSTOM_ID_1 = 7,
        CUSTOM_ID_2 = 8,
        CUSTOM_ID_3 = 9
    } unit_ids;

    parameter INFLIGHT_QUEUE_DEPTH = 4;
    parameter FETCH_BUFFER_DEPTH = 4;

    parameter LS_INPUT_BUFFER_DEPTH = 4;
    parameter LS_OUTPUT_BUFFER_DEPTH = 4;

    parameter MUL_CYCLES = 1;
    parameter MUL_OUTPUT_BUFFER_DEPTH = 2;

    parameter DIV_INPUT_BUFFER_DEPTH = 2;
    parameter DIV_OUTPUT_BUFFER_DEPTH = 2;

    //Address space
    parameter USE_I_SCRATCH_MEM = 1;
    parameter USE_D_SCRATCH_MEM = 1;
    parameter SCRATCH_ADDR_L = 32'h00000000;
    parameter SCRATCH_ADDR_H = 32'h0000FFFF;
    parameter SCRATCH_BIT_CHECK = 4;

    parameter MEMORY_ADDR_L = 32'h40000000;
    parameter MEMORY_ADDR_H = 32'h4FFFFFFF;
    parameter MEMORY_BIT_CHECK = 4;

    parameter BUS_ADDR_L = 32'h60000000;
    parameter BUS_ADDR_H = 32'h6FFFFFFF;
    parameter BUS_BIT_CHECK = 4;

    //Bus
    parameter USE_BUS = 1;
    parameter C_M_AXI_ADDR_WIDTH = 32;
    parameter C_M_AXI_DATA_WIDTH = 32;

    parameter USE_MMU = 0;

    //Caches
    //Size in bytes: (DCACHE_LINES * DCACHE_WAYS * DCACHE_LINE_W * 4)
    parameter USE_DCACHE = 0;
    parameter DCACHE_LINES = 512;
    parameter DCACHE_WAYS = 2;
    parameter DCACHE_LINE_ADDR_W = $clog2(DCACHE_LINES);
    parameter DCACHE_LINE_W = 8; //In words
    parameter DCACHE_SUB_LINE_ADDR_W = $clog2(DCACHE_LINE_W);
    parameter DCACHE_TAG_W = ADDR_W - DCACHE_LINE_ADDR_W - DCACHE_SUB_LINE_ADDR_W - 2;

    parameter USE_DTAG_INVALIDATIONS = 0;

    parameter DTLB_WAYS = 2;
    parameter DTLB_DEPTH = 32;


    //Size in bytes: (ICACHE_LINES * ICACHE_WAYS * ICACHE_LINE_W * 4)
    //For optimal BRAM packing lines should not be less than 512
    parameter USE_ICACHE = 0;
    parameter ICACHE_LINES = 128;
    parameter ICACHE_WAYS = 2;
    parameter ICACHE_LINE_ADDR_W = $clog2(ICACHE_LINES);
    parameter ICACHE_LINE_W = 8; //In words
    parameter ICACHE_SUB_LINE_ADDR_W = $clog2(ICACHE_LINE_W);
    parameter ICACHE_TAG_W = ADDR_W - ICACHE_LINE_ADDR_W - ICACHE_SUB_LINE_ADDR_W - 2;

    parameter USE_BRANCH_PREDICTOR = 1;
    parameter BRANCH_TABLE_ENTRIES = 512;
    parameter RAS_DEPTH = 8;

    parameter ITLB_WAYS = 2;
    parameter ITLB_DEPTH = 32;

    parameter L1_CONNECTIONS = USE_ICACHE + USE_DCACHE + USE_MMU*2;
    parameter L1_DCACHE_ID = 0;
    parameter L1_DMMU_ID = USE_MMU;
    parameter L1_ICACHE_ID = USE_MMU + USE_DCACHE;
    parameter L1_IMMU_ID = USE_MMU + USE_DCACHE + USE_ICACHE;

endpackage
