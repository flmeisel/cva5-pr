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

import taiga_config::*;
import taiga_types::*;

module dbram(
        input logic clk,
        input logic rst,

        input data_access_shared_inputs_t ls_inputs,
        ls_sub_unit_interface.sub_unit ls,
        output logic[31:0] data_out,

        bram_interface.user data_bram
        );

    assign ls.ready = 1;

    assign data_bram.addr = ls_inputs.addr[31:2];
    assign data_bram.en = ls.new_request;
    assign data_bram.be = ls_inputs.be;
    assign data_bram.data_in = ls_inputs.data_in;
    assign data_out = data_bram.data_out & {32{ls.data_valid}};

    always_ff @ (posedge clk) begin
        if (rst)
            ls.data_valid <= 0;
        else if (ls.new_request & ls_inputs.load)
            ls.data_valid <= 1;
        else
            ls.data_valid <= 0;
    end


endmodule
