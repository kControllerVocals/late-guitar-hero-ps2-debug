NX_SignInComplete = 0
NX_SignedIn = 0

script StartNetworkPlatform 
endscript

script NetworkPlatformComplete 

	change \{NX_SignInComplete = 1}
	if GotParam \{SignedIn}
		change \{NX_SignedIn = 1}
	endif
endscript
