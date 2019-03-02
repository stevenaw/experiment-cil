.assembly extern mscorlib {}
.assembly extern stevenaw {}

.assembly RecursionFibonacci
{
    .ver 1:0:0:0
}
.module app.exe

.method static void main() cil managed
{
    .maxstack 2
    .entrypoint

    ldstr "Enter a number to find its Fibonacci: "
    call int32 [stevenaw]Stevenaw.CliUtils::ReadNumberFromCLI(string)   // stack[0] == number

    call int32 Fibonacci(int32)                                         // consume stack[0] 
                                                                        // calculate fibonacci number
                                                                        // return as stack[0]

    ldstr "Fibonacci of number is: "                                    // stack[1] == string
    call void [stevenaw]Stevenaw.CliUtils::PrintNumber (int32, string)  // consume stack[0], stack[1] and output
    
    call void [stevenaw]Stevenaw.CliUtils::PromptForExit()
    ret
}

.method public static int32 Fibonacci(int32) cil managed
{
    .maxstack 3

    ldarg.0
    brzero returnZero             // if arg is 0, return default (0)

    ldarg.0
    ldc.i4.2
    blt.un returnOne            // if arg < 2, return 1

    ldarg.0
    ldc.i4.1
    sub                         // stack[0] == n-1
    call int32 Fibonacci(int32) // stack[0] == f(n-1)


    ldarg.0
    ldc.i4.2
    sub                         // stack[1] == n-2
    call int32 Fibonacci(int32) // stack[1] == f(n-2)

    add                         // stack[0] = stack[0] + stack[1]
                                // stack[0] = f(n-1) + f(n-2)
                                // Fall through to return stack[0]
exit:
    ret                         

returnZero:
    ldc.i4.0
    br exit
  
returnOne:
    ldc.i4.1
    br exit
}