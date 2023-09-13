
process BAGEL {
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which BAGEL.py >> output.txt
    """
}
