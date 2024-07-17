process HELLO {
    input:
    val name

    output:
    file "hello.txt"

    script:
    """
    echo "Hello, $name!" > hello.txt
    """
}
