function Verb-Noun
{
    param
    (
        $path,
        $timeout
    )

    foreach($dir in $path)
    {
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