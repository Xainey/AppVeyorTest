Function Verb-Noun
{
    param
    (
        $path,
        $timeout
    )

    foreach($dir in $path)
    {
        if($dir -eq "localhost")
        {
            throw "local not allowed"
        }
        if(test-path $dir)
        {
            $true
        }
        else
        {
            throw "ham"
        }
    }
}