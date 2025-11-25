pragma circom 2.0.0

include "circomlib/circuits/comparators.circom";
include "circomlib/circuits/poseidon.circom";

template AgeVerification(levels) {
  // public input
  signal input userId;
  signal input issuerId;
  signal input issuerRoot;
  signal input currentTime;
  signal input minAge;
  
  // private input
  signal input claim[8];
  // claim[0] = schemaHash (13302928230528131355 cho Age Credential)
  // claim[1] = issuerId
  // claim[2] = expirationDate (YYYYMMDD)
  // claim[3] = updatability (0=non-updatable, 1=updatable)
  // claim[4] = version
  // claim[5] = userId (subject)
  // claim[6] = birthday (YYYYMMDD format)
  // claim[7] = merklized (0=no, 1=yes)

  signal input issuerSigR8x;
  signal input issuerSigR8y;
  signal input issuerSigS;

  signal input issuerAuthPubKeyX;
  signal input issuerAuthPubKeyY;

  signal input merkleProof[levels];

  // output
  signal output isValid;

  // extract claim data
  signal issuerFromClaim <== claim[1];
  signal expirationTime <== claim[2];
  signal userFromClaim <== claim[5];
  signal birthday <== claim[6];

  // check schema
  claim[0] === 13302928230528131355;

  // verify issuerId
  issuerId === issuerFromClaim;
  userId === userFromClaim;

  // check expiration: currentTime <= expirationTime
  component expDateCheck = LessThan(32)
  expDateCheck.in[0] <== currentTime;
  expDateCheck.in[1] <== expirationTime;
  expDateCheck === 1;

  // calculate real age
  signal birthYear <== birthday \ 10000;
  signal birthMonthDay <== birthday - birthYear * 10000;
  signal currentYear <== currentTime \ 10000;
  signal currentMonthDay <== currentTime - currentYear * 10000;
  signal age <== currentYear - birthYear;

  component lt = LessThan(32);
  lt.in[0] <== currentMonthDay;
  lt.in[1] <== birthMonthDay;
  signal realAge <== age - lt.out;

  // check realAge > minAge
  component geq = GreaterEqThan(8);
  geq.in[0] <== realAge;
  geq.in[1] <== minAge;
  geq.out === 1;

  // hash claim
  component claimHasher = Poseidon(8)
  for (var i = 0; i < 8; i++) {
    claimHasher.inputs[i] <== claim[i];
  }
  signal claimHash <= claimHasher.out;

  // verify issuer signature
  component verifier = EdDSAPoseidonVerifier();
  verifier.enabled <== 1;
  verifier.Ax <== issuerAuthPubKeyX;
  verifier.Ay <== issuerAuthPubKeyY;
  verifier.R8x <== issuerSigR8x;
  verifier.R8y <== issuerSigR8y;
  verifier.S <== issuerSigS;
  verifier.M <== claimHash;

  // verify merkle tree proof
  
}