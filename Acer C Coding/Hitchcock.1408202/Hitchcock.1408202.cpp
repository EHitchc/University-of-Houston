//Ethan Hitchcock (1408202)
//Multicycle Unpipelined Processor
//ECE 5367 - Dr. Fu

#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <fstream>
#include <cstring>

//D://ECE 5367\input.txt
using namespace std;

//Defines
#define LW 0x23
#define SW 0x2B
#define R_INSTRUCT 0x00
#define R_ADD 0x20
#define R_SUB 0x22
#define R_SLT 0x2A
#define ADDI 0x08
#define BEQ 0x04
#define BNE 0x05

struct instruct32_t {
    string instr_number;
    int opcode;
    int rs;
    int rt;
    int rd;
    int shamt;
    int rfunction;
    int address;

    instruct32_t(): opcode(0),
                    rs(0),
                    rt(0),
                    rd(0),
                    shamt(0),
                    rfunction(0),
                    address(0){}


    void Reset() {
        opcode = 0;
        rs = 0;
        rt = 0;
        rd = 0;
        shamt = 0;
        rfunction = 0;
        address = 0;
    }

    void R_type() {
        rs = strtol(instr_number.substr(6, 5).c_str(), NULL, 2);
        rt = strtol(instr_number.substr(11, 5).c_str(), NULL, 2);
        rd = strtol(instr_number.substr(16, 5).c_str(), NULL, 2);
        shamt = strtol(instr_number.substr(21, 5).c_str(), NULL, 2);
        rfunction = strtol(instr_number.substr(26, 6).c_str(), NULL, 2);
    }

    void I_type() {
        rs = strtol(instr_number.substr(6, 5).c_str(), NULL, 2);
        rt = strtol(instr_number.substr(11, 5).c_str(), NULL, 2);
        //allow negative values in address field
        address = strtol(instr_number.substr(17, 15).c_str(), NULL, 2);
        if (instr_number.substr(16, 1).compare("1") == 0) address -= 0x8000;
    }
} ;

//GLOBALS
int registers_32[32] = {};      //32-Memory Registers
int memory_32[250] = {};        //32-Bit Memory Addresses

int main()
{
    //Initial Varibles
    int instruction_Counter = 0;
    int cycle_Counter = 0;
    bool continue_Flag = 1;
    int program_Counter = 0;
    string trash;

    //Read in source file
    ifstream f_source;
    ofstream f_output;

    //Prompt user for input_File name and output_File name
    string input_File, output_File, continue_Input;
    cout << "Please enter input file directory: " << endl;
    getline(cin, input_File);
    cout << "Please enter output file directory: " << endl;
    getline(cin, output_File);

    while (continue_Flag) {

        //Open Source Files
        f_source.open(input_File.c_str());
        f_output.open(output_File.c_str());

        while (f_source.fail() || f_output.rdstate()) { //If opening files fails
            //ensure files closed
            f_source.close();
            f_output.close();

            //reprompt user to enter correct File names
            cout << "Unable to open input or output file at those directories." << endl;
            string input_File, output_File, continue_Input;
            cout << "Please enter input file directory: " << endl;
            getline(cin, input_File);
            cout << "Please enter output file directory: " << endl;
            getline(cin, output_File);

            //Open Source Files
            f_source.open(input_File.c_str());
            f_output.open(output_File.c_str());
        }

        //Initialise memory and registers
        string section;
        getline(f_source, section);
        program_Counter++;

        if(section.compare("REGISTERS") == 0) {
            string registerName, registerData;
            int registerIndex = 0;

            f_source >> registerName;
            program_Counter++;
            while(registerName.compare(0, 1, "R", 1) == 0) {    //Check to see if any Registers modified
                //Extract register index and register contents
                f_source >> registerData;
                registerName = registerName.substr(1, registerName.size() - 1);
                registerIndex = strtol(registerName.c_str(), NULL, 10);

                //Set register contents accordingly
                registers_32[registerIndex] = strtol(registerData.c_str(), NULL, 10);
                //cout << "R" << registerIndex << ": " << registers_32[registerIndex] << endl;
                //Set up for next loop
                f_source >> registerName;
                program_Counter++;
            }
            section.assign(registerName);
        }

        if(section.compare("MEMORY") == 0) {
            string memoryName, memoryData;
            int memoryIndex = 0;

            f_source >> memoryName;
            program_Counter++;
            while(memoryName.compare("CODE") != 0) {    //Check to see if any Registers modified
                //Extract memory index and memory contents
                f_source >> memoryData;
                memoryIndex = strtol(memoryName.c_str(), NULL, 10);

                //Set memory contents accordingly
                memory_32[memoryIndex / 4] = strtol(memoryData.c_str(), NULL, 10);
    //            cout << memoryName << ": " << memory_32[memoryIndex / 4] << endl;
                //Set up for next loop
                f_source >> memoryName;
                program_Counter++;
            }
            section.assign(memoryName);
        }

        if(section.compare("CODE") == 0) {
            instruct32_t instr;

            //IF - initial
            f_source >> instr.instr_number;
            while(!f_source.eof()) {
                //Ensure $ZERO is always 0
                registers_32[0] = 0;

                //Increment PC and reset #CC
                cycle_Counter++;
                instruction_Counter++;
                program_Counter++;
                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-IF" << endl;

                //ID (Increment #CC)
                instr.opcode = strtol(instr.instr_number.substr(0, 6).c_str(), NULL, 2);
                cycle_Counter++;
                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-ID" << endl;

                switch(instr.opcode) {
                    case R_INSTRUCT:
                        //Set up instr class for R-type processing
                        instr.R_type();
                        cycle_Counter++;
                        f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-EX" << endl;
                        cycle_Counter++;
                        f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-WB" << endl;

                        //EX/WB functionality
                        switch(instr.rfunction) {
                            case R_ADD:
                                registers_32[instr.rd] = registers_32[instr.rs] + registers_32[instr.rt];
                                break;
                            case R_SUB:
                                registers_32[instr.rd] = registers_32[instr.rs] - registers_32[instr.rt];
                                break;
                            case R_SLT:
                                if (registers_32[instr.rs] < registers_32[instr.rt]) {
                                    registers_32[instr.rd] = 1;
                                }
                                else {
                                    registers_32[instr.rd] = 0;
                                }
                                break;
                        }
                        break;
                    default:
                        //Set up instr class for I-type processing
                        instr.I_type();

                        //EX/WB/MEM - depending on function
                        switch(instr.opcode) {
                            case ADDI:
                                //output EX/WB
                                cycle_Counter++;
                                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-EX" << endl;
                                cycle_Counter++;
                                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-WB" << endl;

                                //perform ADDI function
                                registers_32[instr.rt] = registers_32[instr.rs] + instr.address;
                                break;

                            case LW:
                                //output EX/MEM/WB to file
                                cycle_Counter++;
                                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-EX" << endl;
                                cycle_Counter++;
                                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-MEM" << endl;
                                cycle_Counter++;
                                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-WB" << endl;

                                //perform LW function
                                registers_32[instr.rt] = memory_32[(registers_32[instr.rs] + instr.address) / 4];
                                break;

                            case SW:
                                //output EX/MEM to file
                                cycle_Counter++;
                                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-EX" << endl;
                                cycle_Counter++;
                                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-MEM" << endl;

                                //perform SW function
                                memory_32[(registers_32[instr.rs] + instr.address) / 4] = registers_32[instr.rt];
                                break;

                            case BEQ:
                                //output EX to file
                                cycle_Counter++;
                                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-EX" << endl;

                                //perform BEQ function
                                if (registers_32[instr.rs] == registers_32[instr.rt]) {
                                    //consume #instr.address of instructions to jump to correct instruction
                                    if (instr.address < 0) {
                                        f_source.seekg(0, ios_base::beg);
                                        program_Counter += instr.address;
                                        for (int i = 0; i < program_Counter; i++) {
                                            getline(f_source, trash);
                                        }
                                    }
                                    else {
                                        for (int i = 0; i < instr.address; i++) {
                                            f_source >> instr.instr_number;
                                        }
                                    }
                                }
                                break;

                            case BNE:
                                //output EX to file
                                cycle_Counter++;
                                f_output << "C#" << cycle_Counter << " I" << instruction_Counter << "-EX" << endl;

                                //perform BNE function
                                if (registers_32[instr.rs] != registers_32[instr.rt]) {
                                    //consume #instr.address of instructions to jump to correct instruction
                                    if (instr.address < 0) {
                                        f_source.seekg(0, ios_base::beg);
                                        program_Counter += instr.address;
                                        for (int i = 0; i < program_Counter; i++) {
                                            getline(f_source, trash);
                                        }
                                    }
                                    else {
                                        for (int i = 0; i < instr.address; i++) {
                                            f_source >> instr.instr_number;
                                        }
                                    }
                                }
                                break;
                        }
                }

                //IF - loop
                if(!f_source.eof()) {
                    f_source >> instr.instr_number;
                }

                instr.Reset();
            }
        }

        //Write Registers and Memory to File and clear for future operations
        f_output << "REGISTERS" << endl;
        for(int i = 0; i < 32; i++) {
            if (registers_32[i] != 0) {
                f_output << "R" << i << " " << registers_32[i] << endl;
                registers_32[i] = 0;
            }
        }

        f_output << "MEMORY" << endl;
        for(int i = 0; i < 250; i++) {
            if (memory_32[i] != 0) {
                f_output << i * 4 << " " << memory_32[i] << endl;
                memory_32[i] = 0;
            }
        }

        f_source.close();
        f_output.close();

        bool end_Loop = 0;

        //Prompt user whether they want to convert another input file
        while (!end_Loop) {
            cout << "\nWould you like to process another input file?" << endl << "\t (Y/N): ";
            getline(cin, continue_Input);
            if (continue_Input.compare("Y") == 0) {
                //Prompt user for input_File name and output_File name
                cout << "Please enter input file directory: " << endl;
                getline(cin, input_File);
                cout << "Please enter output file directory: " << endl;
                getline(cin, output_File);

                end_Loop = 1;
            }
            else if (continue_Input.compare("N") == 0) {
                continue_Flag = 0;

                end_Loop = 1;
            }
            else {
                cout << "Your input was not recognised, please input 'Y' or 'N'" << endl;
            }
        }

        instruction_Counter = 0;
        cycle_Counter = 0;
        program_Counter = 0;
    }

    return 0;
}
