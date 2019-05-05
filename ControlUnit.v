module ControlUnit(
	input clock,
	input wire opcode [5:0],
	input wire funct [5:0],
	output wire pcWriteCond [1:0],
	output wire pcWrite [1:0],
	output wire iord [3:0],
	output wire memRead [1:0],
	output wire memWrite [1:0],
	output wire irWrite [1:0],
	output wire regDst [2:0],
	output wire regWrite [1:0],
	output wire writeRegA [1:0],
	output wire writeRegB [1:0],
	output wire aluSrcA [2:0],
	output wire aluSrcB [3:0],
	output wire aluOutControl [1:0],
	output wire epcWrite [1:0],
	output wire pcSource [3:0],
	output wire memToReg [4:0],
	output wire aluOp [3:0],
	output wire sControl [2:0],
	output wire memMux [1:0],
	output wire lsControl [2:0],
	output wire multControl [1:0],
	output wire divControl [1:0],
	output wire muxHiControl [1:0],
	output wire muxLoControl [1:0],
	output wire writeHI [1:0],
	output wire writeLO [1:0],
	output wire shiftSrc [1:0],
	output wire shiftAmt [1:0],
	output wire shiftControl [3:0],
	output wire divZero [1:0],
	output wire overflow [1:0]
);

	reg [3:0] count = 0;

    always @(posedge clock or posedge Reset) begin
        if (Reset) begin
            // reset				
            pcWriteCond = 1'b0;
            pcWrite = 1'b0;			
            irWrite = 1'b0;
            epcWrite = 1'b0;
            regDst = 2'b10;
            memToReg = 4'b1000;
            regWrite = 1'b1;
            multControl = 1'b0;
            divControl = 1'b0;
            writeHI = 1'b0;
            writeLO = 1'b0;
        end else if (count == 0) begin
            // busca
            pcSource = 3'b000;
            pcWriteCond = 1'b0;
            pcWrite = 1'b1;
            epcWrite = 1'b0;
            irWrite = 1'b0;
            regWrite = 1'b0;
            multControl = 1'b0;
            divControl = 1'b0;
            writeHI = 1'b0;
            writeLO = 1'b0;
            iord = 3'b000;
            memWrite = 1'b0;
            aluSrcA = 2'b00;
            aluSrcB = 2'b01;
            aluOp = 3'b000;
            count = 1;
        end else if (count == 1) begin						
            // espera
            pcWriteCond = 1'b0;
            pcWrite = 1'b0;
            epcWrite = 1'b0;
            regWrite = 1'b0;
            multControl = 1'b0;
            divControl = 1'b0;
            writeHI = 1'b0;
            writeLO = 1'b0;
            irWrite = 1'b1;
            count = 2;
        end else if (count == 2) begin		
            // decodificacao
            pcWriteCond = 1'b0;
            pcWrite = 1'b0;
            epcWrite = 1'b0;
            irWrite = 1'b0;
            regWrite = 1'b0;
            multControl = 1'b0;
            divControl = 1'b0;
            writeHI = 1'b0;
            writeLO = 1'b0;
            aluSrcA = 2'b00;
            aluSrcB = 2'b11;
            aluOp = 3'b000;
            count = 3;
        end else if (count == 3) begin		
            // execução
            pcWriteCond = 1'b0;
            pcWrite = 1'b0;
            epcWrite = 1'b0;
            irWrite = 1'b0;
            regWrite = 1'b0;
            multControl = 1'b0;
            divControl = 1'b0;
            writeHI = 1'b0;
            writeLO = 1'b0;
            case (opcode)
                6'h0: begin							
                    // instrucoes R
                    case(funct)
                        6'h20: begin					
                            // add
                            aluSrcA = 2'b01;
                            aluSrcB = 2'b00;
                            aluOp = 3'b001;
                            cont = 4;
                        end 6'h24: begin
                            // and
                            aluSrcA = 2'b01;
                            aluSrcB = 2'b00;
                            aluOp = 3'b011;
                            cont = 4;
                        end
                    endcase
            endcase
        end else if (count == 4) begin
            // escrita
            pcWriteCond = 1'b0;
            pcWrite = 1'b0;
            epcWrite = 1'b0;
            irWrite = 1'b0;
            regWrite = 1'b0;
            multControl = 1'b0;
            divControl = 1'b0;
            writeHI = 1'b0;
            writeLO = 1'b0;
            case (opcode)
                6'h0: begin							
                // instrucoes R
                    case(funct)
                        6'h20: begin				
                            // add
                            regDst = 2'b01;
                            memToReg = 4'b0000;
                            regWrite = 1'b1;
                            count = 5;
                        end 6'h24: begin				
                            // and
                            regDst = 2'b01;
                            memToReg = 4'b0000;
                            regWrite = 1'b1;
                            count = 0;
                        end
                    endcase
            endcase
        end
    end
endmodule