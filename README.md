# key-analyzer(secp256k1)

This research project investigates the feasibility of analyzing private key properties for the SECP256K1 elliptic curve, commonly used in cryptocurrencies like Bitcoin. We aim to develop a tool that explores two main aspects:

1. **Private Key Length Estimation**: Can we determine the bit range of a private key solely from its corresponding public key?
2. **Additive vs. Negative Inverse Identification**: Can we distinguish if a public key represents an additive inverse or negative inverse of another private key's public key?

## Challenges and Considerations

Determining private key information from public keys is inherently difficult in ECC due to the **Discrete Logarithm Problem (DLP)**. Existing approaches like lookup tables or point negation are impractical due to size limitations or offer minimal information gain.


### Private Key Length Analysis

We will explore techniques to infer the private key's bit range within a specified range (e.g., 100-160 bits) based solely on the public key. This focuses on understanding public key properties and potential statistical methods.

### Additive vs. Negative Inverse Detection:

We will investigate mathematical relationships on the SECP256K1 curve to identify if a public key represents an additive inverse (positive) or negative inverse of another private key's public key. This analysis doesn't reduce key size but explores representation within the key space.

Exploring whether a public key represents an additive or negative inverse involves:

- **Private Key Representation**: If  𝐻=𝑎𝐺 (where $G$ is the generator point and $a$ is the private key), then $\ -H = (-a)G $, showing that point negation results in a new private key $\-a$.
- **Key Space Considerations**: This aspect doesn't inherently reduce the private key size or information but changes the representation within the same key space.


## Implementation

### Key Length Analysis

1. Accept public key input
2. Analyze the key for potential bit range estimation and additive/negative inverse properties
3. Validate findings using established ECC properties and potentially heuristic or statistical methods


## Installation and Usage (Linux)

### Prerequisites:

Install necessary libraries:

```bash
$ sudo apt install libgcrypt-dev libgmp-dev
```

### Running the Tool

```bash
make
```

## Future Work

- **Side Channel Attacks**: Investigate the feasibility of using side channel attacks or fault injection techniques to reduce private key sizes and test the security of ECDSA with smaller key sizes.
- **Security Implications**: Evaluate the security implications of reducing private key sizes and the potential vulnerabilities introduced.


## References

- [Secp256k1](https://www.nervos.org/knowledge-base/secp256k1_a_key%20algorithm_(explainCKBot))
- [Elliptic Curves](https://crypto.stanford.edu/pbc/notes/elliptic/explicit.html)
