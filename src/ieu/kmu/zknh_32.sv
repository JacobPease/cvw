///////////////////////////////////////////
// zknh_32.sv
//
// Written: kelvin.tran@okstate.edu, james.stine@okstate.edu
// Created: 13 February 2024
//
// Purpose: RISC-V ZKNH 32-Bit top level unit
//
// A component of the CORE-V-WALLY configurable RISC-V project.
// https://github.com/openhwgroup/cvw
// 
// Copyright (C) 2021-24 Harvey Mudd College & Oklahoma State University
//
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
//
// Licensed under the Solderpad Hardware License v 2.1 (the “License”); you may not use this file 
// except in compliance with the License, or, at your option, the Apache License version 2.0. You 
// may obtain a copy of the License at
//
// https://solderpad.org/licenses/SHL-2.1/
//
// Unless required by applicable law or agreed to in writing, any work distributed under the 
// License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
// either express or implied. See the License for the specific language governing permissions 
// and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////

module zknh_32 (input  logic [31:0] A, B,
		input logic [3:0] ZKNHSelect,
		output logic [31:0] ZKNHResult);
   
   logic [31:0] 		    sha256sig0_res;
   logic [31:0] 		    sha256sig1_res;
   logic [31:0] 		    sha256sum0_res;
   logic [31:0] 		    sha256sum1_res;
   
   logic [31:0] 		    sha512sig0h_res;
   logic [31:0] 		    sha512sig0l_res;
   logic [31:0] 		    sha512sig1h_res;
   logic [31:0] 		    sha512sig1l_res;
   logic [31:0] 		    sha512sum0r_res;
   logic [31:0] 		    sha512sum1r_res;
   
   sha256sig0 #(32) sha256sig0(A, sha256sig0_res);
   sha256sig1 #(32) sha256sig1(A, sha256sig1_res);
   sha256sum0 #(32) sha256sum0(A, sha256sum0_res);
   sha256sum1 #(32) sha256sum1(A, sha256sum1_res);
   sha512sig0h sha512sig0h(A, B, sha512sig0h_res);
   sha512sig0l sha512sig0l(A, B, sha512sig0l_res);
   sha512sig1h sha512sig1h(A, B, sha512sig1h_res);
   sha512sig1l sha512sig1l(A, B, sha512sig1l_res);
   sha512sum0r sha512sum0r(A, B, sha512sum0r_res);
   sha512sum1r sha512sum1r(A, B, sha512sum1r_res);
   
   // Result Select Mux
   always_comb begin
      casez(ZKNHSelect)
	4'b0000: ZKNHResult = sha256sig0_res;
	4'b0001: ZKNHResult = sha256sig1_res;
	4'b0010: ZKNHResult = sha256sum0_res;
	4'b0011: ZKNHResult = sha256sum1_res;
	4'b0100: ZKNHResult = sha512sig0h_res;
	4'b0101: ZKNHResult = sha512sig0l_res;
	4'b0110: ZKNHResult = sha512sig1h_res;
	4'b0111: ZKNHResult = sha512sig1l_res;
	4'b1000: ZKNHResult = sha512sum0r_res;
	4'b1001: ZKNHResult = sha512sum1r_res;
	default ZKNHResult = 0;
      endcase
   end

endmodule
