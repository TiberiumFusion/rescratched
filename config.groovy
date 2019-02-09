environments {
    '11.6R' {
        output = 'Scratch'
        playerVersion = '11.6'
        additionalCompilerOptions = [
                "-swf-version=19",
                "-define+=SCRATCH::allow3d,true",
        ]
    }
    '11.6D' {
        output = 'Scratch'
        playerVersion = '11.6'
        additionalCompilerOptions = [
                "-swf-version=19",
                "-define+=SCRATCH::allow3d,true",
        ]
    }
    '10.2' {
        output = 'ScratchFor10.2'
        playerVersion = '10.2'
        additionalCompilerOptions = [
                "-swf-version=11",
                "-define+=SCRATCH::allow3d,false",
        ]
    }
}
