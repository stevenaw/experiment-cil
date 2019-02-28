.assembly extern mscorlib {}

.assembly ControlStructures
{
    .ver 1:0:0:0
}
.module app.exe

.method static void main() cil managed
{
    .maxstack 2
    .entrypoint

loop_body:
    ldstr "Keep looping (1 or 0)?"
    call void [mscorlib]System.Console::WriteLine (string)

    call string [mscorlib]System.Console::ReadLine ()
    call int32 [mscorlib]System.Int32::Parse (string)   // stack[0] = input as int32
    ldc.i4.0                                             // stack[1] = 0
    bne.un loop_body                                    // Loop is stack[0] != stack[1]

exit:
    ldstr "Press any key to continue..."
    call void [mscorlib]System.Console::WriteLine (string)

    call int32 [mscorlib]System.Console::Read ()
    pop
    ret
}