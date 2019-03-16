.assembly extern mscorlib {}

.assembly ArraysAndSorting { .ver 1:0:0:0 }
.module app.exe

.method static void main() cil managed
{
    .maxstack 2
    .entrypoint
    .locals init ([0] int32[] arr)

    ldc.i4 12
    call int32[] CreateRandomArray(int32)
    stloc.0

    ldloc.0
    call void PrintArrayInfo(int32[])

    ldloc.0
    call void Bubblesort(int32[])

    ldloc.0
    call void PrintArrayInfo(int32[])

    call int32 [mscorlib]System.Console::Read()
    pop

    ret
}

.method public static void Bubblesort(int32[]) cil managed
{
    .maxstack 8
    .locals init (
         [0] int32[] arr
        ,[1] int32 len
        ,[2] int32 i
        ,[3] int32 j
    )

    ldarg.0
    stloc.0         // local[0] == passed array

    ldarg.0
    ldlen
    conv.i4
    stloc.1         // local[1] == array.Length

    ldc.i4.0        // local[2] == 0
    stloc.2

    br outer_loop_check

outer_loop_body:
    // Initialize inner loop variable
    // j = i + 1
    ldloc       i
    ldc.i4      1
    add
    stloc       j

    br inner_loop_check

inner_loop_body:
    ldloc       arr
    ldloc       i
    ldelem.i4

    ldloc       arr
    ldloc       j
    ldelem.i4

    blt         inner_loop_increment

    // Swap
    ldloc       arr
    ldloc       i
    ldloc       j
    call        void SwapItems(int32[], int32, int32)


inner_loop_increment:
    // Increment j
    ldloc      j   // j++
    ldc.i4     1
    add
    stloc      j

inner_loop_check:
    ldloc       j
    ldloc       len
    blt inner_loop_body    // loop if j < len

// outer loop increment
    // Increment i
    ldloc      i   // i++
    ldc.i4     1
    add
    stloc      i

outer_loop_check:
    ldloc       i
    ldloc       len
    blt outer_loop_body    // loop if i < len -1

    ret
}

.method public static void SwapItems(int32[], int32, int32) cil managed
{
    .maxstack 4
    .locals init (
        [0] int32 tmp
    )

    ldarg.0         // tmp = items[i]
    ldarg.1
    ldelem.i4
    stloc.0  

    ldarg.0         // items[i] = items[j]
    ldarg.1
    ldarg.0
    ldarg.2
    ldelem.i4
    stelem.i4

    ldarg.0         // items[j] = tmp
    ldarg.2
    ldloc.0
    stelem.i4

    ret
}

.method public static void PrintArrayInfo(int32[]) cil managed
{
    .maxstack 8
    .locals init (
         [0] int32[] arr
        ,[1] int32 len
        ,[2] int32 count
    )

    ldarg.0
    stloc.0         // local[0] == passed array

    ldloc.0
    ldlen
    conv.i4
    stloc.1         // local[1] == array.Length

    // load string, local[1] onto stack [0] and stack[1], then output length
    // ------------------------------------------
    ldstr "Array length: {0}"
    ldloca.s   len
    call       instance string [mscorlib]System.Int32::ToString()
    call       void [mscorlib]System.Console::WriteLine(string, object)

loop_init:
    ldloc   len         // Init count to length
    stloc.2

loop_check:
    ldloc   count       // Decrement count by 1
    ldc.i4.1
    sub
    stloc.2

    ldloc.2
    ldc.i4.0
    blt loop_exit        // exit loop if count < 0

loop_body:
    // load string onto stack
    ldstr       "array[{0}] = {1}"

    // load string representation of count onto stack
    ldloca      count
    call        instance string [mscorlib]System.Int32::ToString()

    // load string representation of array[count] onto stack
    ldloc       arr
    ldloc       count
    ldelema     int32
    call        instance string [mscorlib]System.Int32::ToString()

    call        void [mscorlib]System.Console::WriteLine(string, object, object)
    br          loop_check

loop_exit:
    ret
}

.method public static int32[] CreateRandomArray(int32) cil managed
{
    .maxstack 8
    .locals init (
         [0] int32[] arr
        ,[1] int32 len
        ,[2] int32 count
        ,[3] class [mscorlib]System.Random rand
    )

    ldarg.0     // stack[0] == size of array
    dup         // stack[1] == size of array
    dup         // stack[2] == size of array

    newarr      [mscorlib]System.Int32      // local[0] == array with size stack[2]
    stloc.0                                 

    stloc.1     // stack[1] -> local[1] == size of array
    stloc.2     // stack[0] -> local[2] == counter (init size of array)

    newobj instance void [mscorlib]System.Random::.ctor()
    stloc.3

loop_check:
    ldloc   count       // Decrement count by 1
    ldc.i4.1
    sub
    stloc.2

    ldloc.2
    ldc.i4.0
    blt loop_exit        // exit loop if count < 0

loop_body:
    ldloc       arr         // arr[i] = rand.Next(0, arr.Length);
    ldloc       count
    ldloc       rand
    ldc.i4.0
    ldloc       len
    callvirt    instance int32 [mscorlib]System.Random::Next(int32, int32)
    stelem.i4

    br          loop_check


loop_exit:
    ldloc arr
    ret
}