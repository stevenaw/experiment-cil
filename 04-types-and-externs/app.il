.assembly extern mscorlib {}
.assembly extern stevenaw {}

.assembly TypesAndExterns
{
    .ver 1:0:0:0
}
.module app.exe

.method static void main() cil managed
{
    .entrypoint
    .maxstack 2

    ldstr "Enter a number: "
    call int32 [stevenaw]Stevenaw.CliUtils::ReadNumberFromCLI(string)   // stack[0] == number

    ldstr "Enter another number: "
    call int32 [stevenaw]Stevenaw.CliUtils::ReadNumberFromCLI(string)   // stack[1] == number

    add                                                                 // add stack[0] + stack[1]
                                                                        // stack[0] now sum, stack[1] empty

    ldstr "Result of adding is: "                                       // stack[1] == string
    call void [stevenaw]Stevenaw.CliUtils::PrintNumber (int32, string)  // consume stack[0], stack[1] and output
    
    call void [stevenaw]Stevenaw.CliUtils::PromptForExit()
    ret
}