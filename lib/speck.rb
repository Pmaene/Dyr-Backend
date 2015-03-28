class Speck
    def initialize(key)
        @key = key

        @keys = []
        @ls = []

        expand_key()
    end

    def enc(plaintext)
        x = plaintext[0..7].to_i(16)
        y = plaintext[8..15].to_i(16)

        for i in 0..26
            x = ((rotr(x, 8) + y) % (1 << 32)) ^ @keys[i]
            y = rotl(y, 3) ^ x
        end

        "#{"%08x" % x}#{"%08x" % y}"
    end

    private

        def rotl(x, n)
            ((x << n) % (1 << 32)) | (x >> (32 - n))
        end

        def rotr(x, n)
            ((x << (32 - n)) % (1 << 32)) | (x >> n)
        end

        def expand_key
            @keys[0] = @key[24..31].to_i(16)

            @ls[0] = @key[16..23].to_i(16)
            @ls[1] = @key[8..15].to_i(16)
            @ls[2] = @key[0..7].to_i(16)

            for i in 0..25
                @ls[i+3] = ((@keys[i] + rotr(@ls[i], 8)) % (1 << 32)) ^ i
                @keys[i+1] = rotl(@keys[i], 3) ^ @ls[i+3]
            end
        end
end
