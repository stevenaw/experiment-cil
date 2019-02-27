.assembly extern mscorlib {}

.assembly HelloWorld
{
    .ver 1:0:0:0
}
.module helloWorld.exe

.method static void main() cil managed
{
    .maxstack 1
    .entrypoint
    
    ldstr "Hello world"
    call void [mscorlib]System.Console::WriteLine (string)

    ldstr "Press any key to continue..."
    call void [mscorlib]System.Console::WriteLine (string)

    call int32 [mscorlib]System.Console::Read ()
    pop

    ret
}