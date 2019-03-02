.assembly extern mscorlib {}

.assembly stevenaw
{
    .ver 1:0:0:0
}
.module stevenaw.dll

.class public Stevenaw.CliUtils
{
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
}