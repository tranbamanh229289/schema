package main

type AgeCredentialSubject struct {
	ID string 		`json:"id"`
	BirthYear int	`json:"birthyear"`
}


// func createUser(sk *babyjub.PrivateKey) (*w3c.DID , error) {
// 	state := big.NewInt(0)
// 	typ, err := core.BuildDIDType(core.DIDMethodPolygonID, core.Polygon, core.Mumbai)

// 	if err != nil {
// 		return nil, err
// 	}

// 	id, err := core.NewIDFromIdenState(typ, state)

// 	if err != nil {
// 		return nil, err
// 	}

// 	did, err := core.ParseDIDFromID(*id)

// 	if err != nil {
// 		return nil, err
// 	}
// 	fmt.Println(did)
// 	return did, nil
// }


// func createClaim(issuerDID, userDID *w3c.DID, birthYear int)(*verifiable.W3CCredential, error){
// 	currentYear := time.Now().Year()
// 	age := currentYear - birthYear

// 	if age < 18 {
// 		return nil, fmt.Errorf("user is under 18 years old")
// 	}

// 	credentialSubject := AgeCredentialSubject{
// 		ID:        userDID.String(),
// 		BirthYear: birthYear,
// 	}

// 	issuanceDate := time.Now()
// 	credential := &verifiable.W3CCredential{
// 		Context: []string {
// 			verifiable.JSONLDSchemaW3CCredential2018,
// 			"https://example.com/age-context.jsonld",
// 		},
// 		ID:           fmt.Sprintf("urn:uuid:%s", fmt.Sprintf("%d", time.Now().UnixNano())),
// 		Type:         []string{"VerifiableCredential", "AgeCredential"},
// 		Issuer:       issuerDID.String(),
// 		IssuanceDate: &issuanceDate,
// 		CredentialSubject: credentialSubject,
// 	}

// 	fmt.Println("✅ Claim created successfully!")
// 	fmt.Printf("Claim ID: %s\n", credential.ID)
// 	fmt.Printf("Subject: %s\n", credentialSubject.ID)
// 	fmt.Printf("Birth Year: %d\n", credentialSubject.BirthYear)
	
// 	return credential, nil
// }

