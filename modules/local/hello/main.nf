process HELLO {
    input:
    val name

    output:
    file "hello.txt"

    script:
    """
    echo "Hello, module!" > hello.txt
    """
}
