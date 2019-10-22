module Commons
{
    
}

extern module Vampire
{
    import opened Commons

    datatype BloodType = APlus | AMinus 
        | BPlus | BMinus 
        | OPlus | OMinus
        | ABPlus | ABMinus

    extern method Hello()
    {
        print "Hello, C#!\n";
    }
}
