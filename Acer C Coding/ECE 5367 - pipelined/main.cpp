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
    int instrCount;

    instruct32_t(): opcode(0),
                    rs(0),
                    rt(0),
                    rd(0),
                    shamt(0),
                    rfunction(0),
                    address(0),
                    instrCount(0){}


    void Reset() {
        opcode = 0;
        rs = 0;
        rt = 0;
        rd = 0;
        shamt = 0;
        rfunction = 0;
        address = 0;
        instrCount = 0;
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
bool IF_Flag = true;
bool ID_Flag = false;
bool EX_Flag = false;
bool MEM_Flag = false;
bool WB_Flag = false;
bool IF_STALL_FLAG = false;
bool ID_STALL_FLAG = false;
bool EX_STALL_FLAG = false;
bool MEM_STALL_FLAG = false;
bool WB_STALL_FLAG = false;
bool BRANCH_FLAG = false;

void pipeline_Reinit() {
    IF_Flag = true;
    ID_Flag = false;
    EX_Flag = false;
    MEM_Flag = false;
    WB_Flag = false;
    IF_STALL_FLAG = false;
    ID_STALL_FLAG = false;
    EX_STALL_FLAG = false;
    MEM_STALL_FLAG = false;
    WB_STALL_FLAG = false;
    BRANCH_FLAG = false;
}

int main()
{
    //Initial Varibles
    int count_BRANCH_FLAG = 0;
    int cycle_Counter = 0;
    bool continue_Flag = 1;
    int program_Counter = 0;
    string trash;
    instruct32_t instr[5];
    int processCyclesInPipeline = 0;
    int instruction_Counter = 0;

    //Read in source file
    ifstream f_source;
    ofstream f_output;

    //Prompt user for input_File name and output_File name
    string input_File, output_File, continue_Input;
    cout << "Please enter input file directory: " << endl;
    getline(cin, input_File);
    //input_File = "D:\\ECE 5367/input.txt";
    cout << "Please enter output file directory: " << endl;
    getline(cin, output_File);
    //output_File = "D:\\ECE 5367/output.txt";

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

            instruction_Counter = 0;
            while(!f_source.eof() || processCyclesInPipeline < 5) {
                //Ensure $ZERO is always 0
                registers_32[0] = 0;

                //write cycle number
                f_output << "c#" << ++cycle_Counter << " ";

                //-------------- WB --------------
                //WB(WB_Flag);
                if(cycle_Counter > 4 && WB_Flag) {
                    //Push instr from MEM to WB
                    instr[4] = instr[3];
                    f_output << "I" << instr[4].instrCount << "-WB ";
                    WB_Flag = false;
                    ID_Flag = true;
                    IF_Flag = true;
                    MEM_STALL_FLAG = false;
                    EX_STALL_FLAG = false;
                    ID_STALL_FLAG = false;
                    IF_STALL_FLAG = false;
                }

                //-------------- MEM --------------
                if(cycle_Counter > 3 && processCyclesInPipeline < 4 && MEM_Flag) {
                    //Push instr from EX to MEM
                    instr[3] = instr[2];
                    f_output << "I" << instr[3].instrCount << "-MEM ";
                    MEM_Flag = false;
                    WB_Flag = true;
                }
                else if(MEM_STALL_FLAG) {
                    f_output << "I" << instr[3].instrCount+1 << "-stall ";
                }
                if(count_BRANCH_FLAG == 2) {
                    count_BRANCH_FLAG = (count_BRANCH_FLAG + 1)%3;
                    BRANCH_FLAG = false;
                    ID_Flag = false;
                }

                //-------------- EX --------------
                if(cycle_Counter > 2 && processCyclesInPipeline < 3 && EX_Flag) {
                    //Push instr from ID to EX
                    instr[2] = instr[1];
                    f_output << "I" << instr[2].instrCount << "-EX ";
                    EX_Flag = false;
                    MEM_Flag = true;

                    //perform function
                    switch(instr[2].opcode) {
                        case R_INSTRUCT:
                            //EX/WB functionality
                            switch(instr[2].rfunction) {
                                case R_ADD:
                                    registers_32[instr[2].rd] = registers_32[instr[2].rs] + registers_32[instr[2].rt];
                                    break;
                                case R_SUB:
                                    registers_32[instr[2].rd] = registers_32[instr[2].rs] - registers_32[instr[2].rt];
                                    break;
                                case R_SLT:
                                    if (registers_32[instr[2].rs] < registers_32[instr[2].rt]) {
                                        registers_32[instr[2].rd] = 1;
                                    }
                                    else {
                                        registers_32[instr[2].rd] = 0;
                                    }
                                    break;
                            }
                            break;
                        case ADDI:
                            //perform ADDI function
                            registers_32[instr[2].rt] = registers_32[instr[2].rs] + instr[2].address;
                            break;

                        case LW:
                            //perform LW function
                            registers_32[instr[2].rt] = memory_32[(registers_32[instr[2].rs] + instr[2].address) / 4];
                            break;

                        case SW:
                            //perform SW function
                            memory_32[(registers_32[instr[2].rs] + instr[2].address) / 4] = registers_32[instr[2].rt];
                            break;
                        }
                }
                else if(EX_STALL_FLAG) {
                    f_output << "I" << instr[2].instrCount+1 << "-stall ";
                }
                if(count_BRANCH_FLAG) {
                    count_BRANCH_FLAG = (count_BRANCH_FLAG + 1)%3;
                    IF_Flag = false;
                    BRANCH_FLAG = false;
                }

            //-------------- ID --------------
            if(cycle_Counter > 1 && processCyclesInPipeline < 2 && ID_Flag) {
                //Push instr from IF to ID
                instr[1] = instr[0];
                f_output << "I" << instr[1].instrCount << "-ID ";

                switch(instr[1].opcode) {
                    case BEQ:
                        //freeze pipeline for branch
                        if (registers_32[instr[1].rs] == registers_32[instr[1].rt]) { //Stall at ID then flush instr if necessary
                            count_BRANCH_FLAG = 1;
                            //consume #instr.address of instructions to jump to correct instruction
                            f_source.seekg(0, ios_base::beg);
                            program_Counter += instr[1].address;
                            for (int i = 0; i <= program_Counter; i++) {
                                getline(f_source, trash);
                            }
                            IF_Flag = true;
                        }
                        break;

                    case BNE:
                        //perform BNE function
                        if (registers_32[instr[1].rs] != registers_32[instr[1].rt]) {
                            count_BRANCH_FLAG = 1;
                            //consume #instr.address of instructions to jump to correct instruction
                            f_source.seekg(0, ios_base::beg);
                            program_Counter += instr[1].address;
                            for (int i = 0; i < program_Counter; i++) {
                                getline(f_source, trash);
                            }
                            IF_Flag = true;
                        }
                        break;
                }

                //Pipeline in use flag
                EX_Flag = true;
                ID_Flag = false;

            }
            else if(ID_STALL_FLAG) {
                f_output << "I" << instr[1].instrCount + 1 << "-stall ";
            }

            //-------------- IF --------------
            if(IF_Flag && processCyclesInPipeline < 1) {
                //grab 32 bit instruction
                f_source >> instr[0].instr_number;
                //set Instruction #
                program_Counter++;
                instr[0].instrCount = ++instruction_Counter;
                //output that pipeline fetched new instruction
                f_output << "I" << instr[0].instrCount << "-IF";
                //enable next part of path
                ID_Flag = true;

                //Perform Decode - Check to see if R-type or I_type
                instr[0].opcode = strtol(instr[0].instr_number.substr(0, 6).c_str(), NULL, 2);
                switch(instr[0].opcode) {
                    case R_INSTRUCT:
                        //Set up instr class for R-type processing
                        instr[0].R_type();

                        //check to see what previous instruction is (sw/lw/ALU/branch)
                        //Should the pipeline be stalling?
                        if(cycle_Counter > 0) {
                            switch(instr[1].opcode) {
                                case R_INSTRUCT:
                                    //check to see if ID rs or rt uses rd from EX
                                    if(instr[1].rd == instr[0].rs || instr[1].rd == instr[0].rt) { //Stall at ID twice
                                        ID_Flag = false;
                                        IF_Flag = false;
                                        ID_STALL_FLAG = true;
                                    }
                                    break;

                                case ADDI:
                                    //check to see if ID rs or rt uses rt from EX
                                    if(instr[1].rt == instr[0].rs || instr[1].rt == instr[0].rt) { //Stall at ID twice
                                        ID_Flag = false;
                                        IF_Flag = false;
                                        ID_STALL_FLAG = true;
                                    }
                                    break;

                                case LW:
                                    //check to see if ID rs or rt uses rt from EX
                                    if(instr[1].rt == instr[0].rs || instr[1].rt == instr[0].rt) { //Stall at ID twice
                                        ID_Flag = false;
                                        IF_Flag = false;
                                        ID_STALL_FLAG = true;
                                    }
                                    break;

                                case SW:
                                    //no hazard
                                    break;
                                case BEQ:
                                    //freeze pipeline for branch
                                    if (registers_32[instr[1].rs] == registers_32[instr[1].rt]) {
                                        BRANCH_FLAG = true;
//                                        if(count_BRANCH_FLAG) {
//                                            BRANCH_FLAG = false;
//                                        }
                                        ID_Flag = false;
                                    }
                                    break;

                                case BNE:
                                    //perform BNE function
                                    if (registers_32[instr[1].rs] != registers_32[instr[1].rt]) {
                                        BRANCH_FLAG = true;
//                                        if(count_BRANCH_FLAG) {
//                                            BRANCH_FLAG = false;
//                                        }
                                        ID_Flag = false;
                                    }
                                    break;
                            }
                            break;
                        }
                    default:
                        //Set up instr class for I-type processing
                        instr[0].I_type();

                        switch(instr[0].opcode) {
                            case LW:
                            case ADDI:
                            case SW:
                                //check to see what previous instruction was (sw/lw/ALU/branch)
                                //Should the pipeline be stalling?
                                if(cycle_Counter > 0) {
                                    switch(instr[1].opcode) {
                                        case R_INSTRUCT:
                                            //check to see if ID rs or rt uses rd from EX
                                            if(instr[1].rd == instr[0].rs || instr[1].rd == instr[0].rt) {
                                                ID_Flag = false;
                                                IF_Flag = false;
                                                ID_STALL_FLAG = true;
                                            }
                                            break;

                                        case ADDI:
                                            //check to see if ID rs or rt uses rt from EX
                                            if(instr[1].rt == instr[0].rs || instr[1].rt == instr[0].rt) {
                                                ID_Flag = false;
                                                IF_Flag = false;
                                                ID_STALL_FLAG = true;
                                            }
                                            break;

                                        case LW:
                                            //check to see if ID rs or rt uses rt from EX
                                            if(instr[1].rt == instr[0].rs || instr[1].rt == instr[0].rt) {
                                                ID_Flag = false;
                                                IF_Flag = false;
                                                ID_STALL_FLAG = true;
                                            }
                                            break;

                                        case SW:
                                            //no hazard
                                            break;

                                        case BEQ:
                                            //freeze pipeline for branch
                                            if (registers_32[instr[1].rs] == registers_32[instr[1].rt]) {
                                                BRANCH_FLAG = true;
                                                if(count_BRANCH_FLAG) {
                                                    BRANCH_FLAG = false;
                                                }
                                                ID_Flag = false;
                                            }
                                            break;

                                        case BNE:
                                            //perform BNE function
                                            if (registers_32[instr[1].rs] != registers_32[instr[1].rt]) {
                                                BRANCH_FLAG = true;
                                                if(count_BRANCH_FLAG) {
                                                    BRANCH_FLAG = false;
                                                }
                                                ID_Flag = false;
                                            }
                                            break;
                                    }
                                    break;
                                }
                            case BNE:
                            case BEQ:
                                //check to see what previous instruction was (sw/lw/ALU/branch)
                                //Should the pipeline be stalling?
                                if(cycle_Counter > 0) {
                                    switch(instr[1].opcode) {
                                        case R_INSTRUCT:
                                            //check to see if ID rs or rt uses rd from EX
                                            if(instr[1].rd == instr[0].rs || instr[1].rd == instr[0].rt) {
                                                ID_Flag = false;
                                                IF_Flag = false;
                                                ID_STALL_FLAG = true;
                                            }
                                            break;

                                        case ADDI:
                                            //check to see if ID rs or rt uses rt from EX
                                            if(instr[1].rt == instr[0].rs || instr[1].rt == instr[0].rt) {
                                                ID_Flag = false;
                                                IF_Flag = false;
                                                ID_STALL_FLAG = true;
                                            }
                                            break;

                                        case LW:
                                            //check to see if ID rs or rt uses rt from EX
                                            if(instr[1].rt == instr[0].rs || instr[1].rt == instr[0].rt) {
                                                ID_Flag = false;
                                                IF_Flag = false;
                                                ID_STALL_FLAG = true;
                                            }
                                            break;

                                        case SW:
                                            //no hazard
                                            break;

                                        case BEQ:
                                            //freeze pipeline for branch
                                            if (registers_32[instr[1].rs] == registers_32[instr[1].rt]) {
                                                BRANCH_FLAG = true;
                                                if(count_BRANCH_FLAG) {
                                                    BRANCH_FLAG = false;
                                                }
                                                ID_Flag = false;
                                            }
                                            break;

                                        case BNE:
                                            //perform BNE function
                                            if (registers_32[instr[1].rs] != registers_32[instr[1].rt]) {
                                                BRANCH_FLAG = true;
                                                if(count_BRANCH_FLAG) {
                                                    BRANCH_FLAG = false;
                                                }
                                                ID_Flag = false;
                                            }
                                            break;
                                    }
                                    break;
                                }
                        }
                }
            }
            else if(IF_STALL_FLAG) {
                //output that pipeline fetched new instruction
                f_output << "I" << instr[0].instrCount+1 << "-stall ";
            }


            //Output new Line
            f_output << endl;

            if (f_source.eof()) {
            processCyclesInPipeline++;
            }
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

        cycle_Counter = 0;
        program_Counter = 0;
        pipeline_Reinit();
        count_BRANCH_FLAG = 0;
        processCyclesInPipeline = 0;


        for(int i = 0; i < 5; i++) {
            instr[i].Reset();
        }
    }

    return 0;
}
