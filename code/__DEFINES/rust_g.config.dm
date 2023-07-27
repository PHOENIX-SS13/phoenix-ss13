// #define RUST_G "path/to/rust_g"
// #define RUSTG_OVERRIDE_BUILTINS
// Overriding here to bypass full RUSTG_OVERRIDE_BUILTINS package
#define url_encode(text) rustg_url_encode(text)
#define url_decode(text) rustg_url_decode(text)
