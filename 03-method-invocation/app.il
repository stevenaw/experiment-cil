.assembly extern mscorlib {}

.assembly MethodInvocation
{
    .ver 1:0:0:0
}
.module app.exe

.method static void main() cil managed
{
    .maxstack 2
    .entrypoint

    ldstr "Enter a number: "
    call int32 ReadNumberFromCLI(string)    // stack[0] == number

    ldstr "Enter another number: "
    call int32 ReadNumberFromCLI(string)    // stack[1] == number

    add                                     // add stack[0] + stack[1]
                                            // stack[0] now sum, stack[1] empty

    ldstr "Result of adding is: "           // stack[1] == string
    call void PrintNumber (int32, string)   // consume stack[0], stack[1] and output
    
    call void PromptForExit()
    ret
}

.method public static void PrintNumber (int32, string) cil managed
{
    .maxstack 1

    ldarg.1
    call void [mscorlib]System.Console::Write (string)

    ldarg.0
    call void [mscorlib]System.Console::WriteLine (int32)

    ret
}

.method public static int32 ReadNumberFromCLI (string) cil managed
{
    .maxstack 1

    ldarg.0
    call void [mscorlib]System.Console::Write (string)

    call string [mscorlib]System.Console::ReadLine ()
    call int32 [mscorlib]System.Int32::Parse (string)

    // stack[0] == parsed int. So we should return it

    ret
}

.method public static void PromptForExit () cil managed
{
    .maxstack 1

    ldstr "Press any key to continue..."
    call void [mscorlib]System.Console::WriteLine (string)

    call int32 [mscorlib]System.Console::Read ()
    pop

    ret
}
